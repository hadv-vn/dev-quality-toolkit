---
name: health-dashboard
description: >
  Điều phối tạo dashboard HTML kiểm tra health check toàn diện cho project
  hiện tại (không phải một diff/PR) — tổng hợp bảo mật (`security-auditor`),
  dependency lỗi thời/CVE (`dependency-auditor`), test coverage
  (`test-coverage-analyzer`), nợ kỹ thuật (`tech-debt-tracker`), kiến trúc
  (`architecture-reviewer` nếu repo lớn), cùng vài chỉ số repo cơ bản (tần
  suất commit, có CI config không, có test suite không) thành một dashboard
  HTML tĩnh duy nhất, màu PASS/WARN/FAIL, dễ mở lại theo thời gian để so
  sánh sức khoẻ dự án giữa các lần chạy. Dùng khi người dùng gõ
  /developer:health-dashboard hoặc yêu cầu kiểu "kiểm tra health check
  project này", "tạo dashboard sức khoẻ dự án".
argument-hint: "[đường dẫn file HTML output — tùy chọn, mặc định docs/health-dashboard.html]"
disable-model-invocation: true
allowed-tools: Read, Glob, Grep, Bash(git log:*), Bash(git status:*), Bash(git rev-parse:*), Bash(git branch:*)
---

# Health dashboard — kiểm tra sức khoẻ toàn project

Đường dẫn file HTML output người dùng chỉ định (có thể trống, mặc định
`docs/health-dashboard.html`): $ARGUMENTS

Skill này là bộ ĐIỀU PHỐI, giống `/developer:pre-merge` nhưng quét **toàn bộ
project** (không phải một diff): KHÔNG tự audit sâu, KHÔNG tự sửa code.
Việc phân tích giao cho các agent chuyên biệt đã có sẵn; việc của skill là
chọn đúng agent, thu thêm vài chỉ số repo cơ bản, tổng hợp dữ liệu, rồi giao
cho agent `developer:health-dashboard-generator` render ra file HTML.

## Bước 1 — Xác định phạm vi & stack

Dùng `Glob` tìm manifest (`package.json`, `pyproject.toml`/
`requirements*.txt`, `go.mod`, `Cargo.toml`, `*.csproj`, `build.gradle*`,
`*.pro`/`CMakeLists.txt`, `Gemfile`...) để biết stack chính. Monorepo nhiều
package → ghi nhận riêng từng phần, không gộp nhận định chung nếu không
đồng nhất.

## Bước 2 — Chọn và gọi agent audit theo stack (song song)

| Luôn chạy | Agent |
|---|---|
| Bảo mật toàn repo | `developer:security-auditor` (giao phạm vi = toàn bộ source, không phải diff) |
| Dependency lỗi thời/CVE | `developer:dependency-auditor` (nếu có manifest dependency) |
| Test coverage | `developer:test-coverage-analyzer` (nếu có test suite/coverage report; không có → ghi WARN "chưa có test") |
| Nợ kỹ thuật | `developer:tech-debt-tracker` |

| Chạy thêm khi phù hợp | Điều kiện |
|---|---|
| `developer:architecture-reviewer` | Repo lớn/nhiều module-layer |
| `developer:qt-cpp-commit-reviewer` / `android-commit-reviewer` / `python-pep8-security-reviewer` | Stack tương ứng chiếm đa số code, muốn thêm góc nhìn chuyên biệt ngoài `security-auditor` chung |

Gọi tất cả agent đã chọn trong CÙNG MỘT lượt (song song), giao đúng phạm vi
"toàn bộ project hiện tại" (hoặc đúng từng package nếu monorepo), yêu cầu
mỗi agent trả về: số finding theo mức độ (Critical/High/Medium/Low) và top
1-3 finding đáng chú ý nhất — không cần toàn văn báo cáo dài.

## Bước 3 — Tự thu thập chỉ số repo cơ bản (không cần agent)

- `git log --since="30 days ago" --oneline | wc -l`-tương đương (đếm dòng) →
  tần suất commit 30 ngày gần nhất. Repo không phải git hoặc lệnh lỗi → ghi
  "không xác định", không bịa số.
- `git branch` / `git status` → có đang ở branch mặc định không, có thay
  đổi chưa commit không (không phải lỗi, chỉ là thông tin tham khảo).
- `Glob` tìm `.github/workflows/*.yml`, `.gitlab-ci.yml`, `Jenkinsfile`,
  `.circleci/config.yml` → có CI config hay không (chỉ xác nhận tồn tại,
  KHÔNG đánh giá pipeline đang pass/fail — việc đó thuộc
  `developer:ci-fixer` khi có log lỗi cụ thể, ngoài phạm vi skill này).
- `Glob` tìm thư mục/file test (`test/`, `tests/`, `__tests__/`, `*_test.*`,
  `*.spec.*`, `*.test.*`) → có test suite hay không, dùng làm ngữ cảnh cho
  mục test coverage nếu `test-coverage-analyzer` không tìm thấy report.

## Bước 4 — Tổng hợp dữ liệu theo đúng cấu trúc cho agent render

Không tự ý thêm hạng mục agent chưa thực sự chạy; agent lỗi/không chạy được
→ ghi trạng thái "Không xác định", không coi là PASS.

```
category: security | status: PASS/WARN/FAIL | critical: n | high: n | medium: n | low: n | top: "<tóm tắt finding nổi bật nhất, hoặc rỗng nếu sạch>"
category: dependency | ...
category: test-coverage | ...
category: tech-debt | ...
category: architecture | ... (nếu có chạy)
category: repo-activity | status: INFO | commits_30d: n | ci_config: có/không | test_suite: có/không
```

Quy tắc status: có Critical/High → FAIL; chỉ Medium/Low hoặc WARN rõ ràng
(ví dụ chưa có test) → WARN; sạch → PASS; agent không chạy được → "Không
xác định" (không tính PASS).

## Bước 5 — Giao cho agent render HTML

Gọi agent `developer:health-dashboard-generator`, truyền nguyên dữ liệu đã
tổng hợp ở Bước 4 cùng: tên project, stack đã xác định, thời điểm chạy, và
đường dẫn output ($ARGUMENTS hoặc mặc định `docs/health-dashboard.html`).
File output đã tồn tại → vẫn giao bình thường, agent đó tự lo việc hỏi xác
nhận trước khi ghi đè.

## Nguyên tắc an toàn

- Không tự `git add`/`git commit`/`git push` file dashboard vừa tạo.
- Không tự chạy test suite đầy đủ hay bất kỳ lệnh có thể sửa trạng thái
  (`npm audit fix`, `pip install`...) — mọi agent con đã tự giới hạn ở chế
  độ chỉ đọc/phân tích theo đúng nguyên tắc riêng của agent đó.
- Trung thực tuyệt đối: chỉ đưa vào dashboard dữ liệu agent/lệnh thực sự trả
  về, không suy diễn hộ khi một agent không chạy được.

## Kết quả bàn giao

Sau khi agent render xong, trả lời ngắn gọn:

```
Đã tạo/cập nhật dashboard: <đường dẫn file>

Tổng quan: <n> PASS, <n> WARN, <n> FAIL, <n> không xác định
Đáng chú ý nhất: <1-2 finding nghiêm trọng nhất nếu có>
```
