---
name: pre-merge
description: >
  Kiểm tra toàn diện một thay đổi trước khi merge: tự nhận diện stack và loại
  file trong diff, chạy song song các reviewer chuyên biệt của plugin
  developer, rồi gộp thành một checklist PASS/WARN/FAIL duy nhất. Dùng khi
  người dùng gõ /developer:pre-merge.
argument-hint: "[base-branch | commit-range | trống = thay đổi chưa commit]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git rev-parse:*), Bash(git merge-base:*), Bash(git branch:*)
---

# Pre-merge check

Phạm vi người dùng chỉ định (có thể trống): $ARGUMENTS

Skill này là bộ điều phối: KHÔNG tự review sâu, KHÔNG sửa code. Việc phân tích
giao cho các agent chuyên biệt; việc của skill là chọn đúng agent, giao đúng
phạm vi, và tổng hợp kết quả trung thực.

## Bước 1 — Xác định diff cần kiểm tra

- `$ARGUMENTS` trống → thay đổi chưa commit: `git diff HEAD` (staged +
  unstaged). Nếu trống, fallback sang branch hiện tại so với branch mặc định.
- `$ARGUMENTS` là tên branch → `git diff <base>...HEAD`.
- `$ARGUMENTS` là range (`a..b`) hoặc SHA → dùng nguyên.
- Diff vẫn trống → báo "không có gì để kiểm tra" và dừng.

Chạy `git diff --stat <phạm vi>` để có danh sách file. Ghi lại đúng lệnh diff
đã dùng — mỗi agent sẽ nhận lệnh này để tự đọc diff.

## Bước 2 — Chọn agent theo nội dung diff

| Dấu hiệu trong diff | Agent |
|---|---|
| `.kt`, `.java`, `AndroidManifest.xml`, `*.gradle(.kts)` | `developer:android-commit-reviewer` |
| `.cpp`, `.h`, `.hpp`, `.c`, `.ui`, `.pro`, `CMakeLists.txt` | `developer:qt-cpp-commit-reviewer` |
| `.py` | `developer:python-pep8-security-reviewer` |
| Code ngôn ngữ khác (JS/TS, Go, C#, Rust, PHP...) | `developer:security-auditor` |
| Migration / schema (`migrations/`, `*.sql`, `schema.prisma`, Alembic, Flyway) | `developer:db-schema-reviewer` |
| Terraform, K8s manifest, Helm, CloudFormation | `developer:iac-reviewer` |
| Manifest/lock dependency (`package.json`, `requirements*.txt`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `build.gradle` đổi dependency...) | `developer:dependency-auditor` |
| `.md` | `developer:docs-reviewer` |
| Diff lớn (> ~15 file code) hoặc chạm nhiều module/layer | thêm `developer:architecture-reviewer` |

Chỉ chạy agent có dấu hiệu khớp — không chạy "cho đủ bộ". Nếu một nhóm file
không khớp agent nào (ảnh, file nhị phân...), ghi nhận ở mục "Không kiểm tra".

## Bước 3 — Chạy agent song song

Gọi tất cả agent đã chọn trong CÙNG MỘT lượt (song song). Prompt cho mỗi
agent phải tự đủ, gồm:
- Lệnh diff chính xác (Bước 1) và danh sách file thuộc phạm vi của agent đó.
- Yêu cầu: chỉ review phần thay đổi, phân loại mức độ (Critical/High/Medium/
  Low), kèm `file:line`, không sửa code.

## Bước 4 — Kiểm tra test (tự làm, không cần agent)

- Diff có sửa code sản phẩm nhưng không chạm file test nào → WARN
  "thay đổi logic không có test đi kèm", gợi ý `developer:test-writer`.
- Có file test bị thêm `skip`/`@Ignore`/`xit`/`@pytest.mark.skip` → WARN.
- Không tự chạy test suite (có thể lâu/tốn tài nguyên); chỉ gợi ý lệnh chạy
  nếu nhận diện được (package.json scripts, pytest, gradle...).

## Bước 5 — Tổng hợp báo cáo

Trung thực tuyệt đối: chỉ ghi phát hiện mà agent thực sự báo cáo; agent lỗi
hoặc không chạy được thì ghi rõ, không coi là PASS.

```
# Pre-merge: <phạm vi diff> — <n> file

## Kết luận: ✅ SẴN SÀNG MERGE | ⚠️ MERGE ĐƯỢC NHƯNG CẦN XEM | ❌ CHƯA NÊN MERGE

| Hạng mục | Agent | Kết quả | Critical/High |
|---|---|---|---|
| ... | ... | PASS / WARN / FAIL | 0 / 2 |

## Phải sửa trước khi merge (Critical/High)
1. [agent] file:line — vấn đề — gợi ý sửa

## Nên xem (Medium/Low)
- ...

## Không kiểm tra
- <nhóm file không có agent phù hợp, agent lỗi...>

## Bước tiếp theo gợi ý
- <ví dụ: `developer:test-writer` cho X; `developer:refactor-assistant` cho Y>
```

Quy tắc kết luận: có bất kỳ Critical/High → ❌; chỉ có Medium/Low hoặc WARN
test → ⚠️; còn lại → ✅.
