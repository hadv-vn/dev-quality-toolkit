---
name: implementation
description: >
  Điều phối giai đoạn phát triển (coding): review code theo đúng stack khi
  đang code (không phải merge-gate cuối — đó là /developer:pre-merge), kiểm
  tra test đi kèm, dependency, và tài liệu API có lỗi thời không, rồi gợi ý
  bước tiếp theo (refactor, viết test, commit). Dùng khi người dùng gõ
  /developer:implementation hoặc đang code một tính năng đã có thiết kế và
  muốn một vòng kiểm tra nhanh trong lúc code (không phải lúc chuẩn bị merge).
argument-hint: "[phạm vi code đang làm — trống = thay đổi chưa commit]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*)
---

# Implementation

Phạm vi người dùng chỉ định (có thể trống): $ARGUMENTS

Skill này dùng TRONG LÚC code để có phản hồi nhanh theo từng phần việc nhỏ.
Nếu mục tiêu là cổng kiểm tra cuối cùng trước khi merge, dùng
`/developer:pre-merge` thay vì skill này (logic chọn reviewer theo stack
giống nhau, nhưng `pre-merge` tổng hợp PASS/WARN/FAIL nghiêm ngặt hơn cho
quyết định merge).

## Bước 1 — Xác định phạm vi

`$ARGUMENTS` trống → `git diff HEAD` (thay đổi chưa commit, staged +
unstaged). Có giá trị → coi là tên file/module cụ thể cần tập trung. Không
có gì để xem → báo và dừng.

## Bước 2 — Review theo stack (nếu có diff code)

| Dấu hiệu trong diff | Agent |
|---|---|
| `.kt`, `.java`, `AndroidManifest.xml`, Gradle, Compose | `developer:android-commit-reviewer` |
| `.cpp`, `.h`, `.hpp`, `.c`, `.ui`, `.pro`, CMakeLists | `developer:qt-cpp-commit-reviewer` |
| `.py` | `developer:python-pep8-security-reviewer` |
| Ngôn ngữ khác (JS/TS, Go, C#, Rust...) | `developer:security-auditor` |
| Diff lớn, chạm nhiều module/layer | thêm `developer:architecture-reviewer` |

## Bước 3 — Test đi kèm

- Sửa logic nhưng không có test tương ứng → gọi `developer:test-writer` để
  viết bổ sung (hỏi xác nhận trước khi tạo file test mới).
- Reviewer ở Bước 2 chỉ ra code cần refactor trước khi test được (quá phức
  tạp, lồng nhiều if...) → gợi ý `developer:refactor-assistant`, không tự
  làm trong skill này trừ khi người dùng xác nhận.

## Bước 4 — Dependency & tài liệu (nếu liên quan)

- Diff đổi manifest dependency (`package.json`, `requirements*.txt`,
  `go.mod`, `build.gradle`...) → `developer:dependency-auditor`.
- Diff đổi signature API public → `developer:api-doc-generator` để cập nhật
  doc/docstring theo code mới, tránh doc lỗi thời ngay từ lúc code.

## Bước 5 — Tổng hợp & bước tiếp theo

```
# Implementation: <phạm vi>

## Review
| Agent | Kết quả | Critical/High |
|---|---|---|

## Test
...

## Dependency/Doc
...

## Bước tiếp theo đề xuất
`/developer:commit` để commit phần vừa xong, hoặc `/developer:pre-merge` khi
đã hoàn tất tính năng và muốn chuẩn bị merge.
```
