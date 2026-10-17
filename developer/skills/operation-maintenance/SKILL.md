---
name: operation-maintenance
description: >
  Điều phối giai đoạn vận hành & bảo trì: ưu tiên xử lý sự cố production
  ĐANG DIỄN RA, truy nguyên nguyên nhân gốc khi đã có bằng chứng cụ thể, tìm
  pattern bất thường trên log diện rộng, cập nhật tài liệu, và đối chiếu
  quality gate định kỳ. Dùng khi người dùng gõ
  /developer:operation-maintenance hoặc hệ thống đã lên production cần theo
  dõi/sửa lỗi/cải tiến liên tục.
argument-hint: "[tình huống hiện tại — sự cố đang xảy ra / stack trace / log / việc bảo trì định kỳ]"
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash(git log:*), Bash(git blame:*)
---

# Operation & Maintenance

Tình huống hiện tại (có thể trống → hỏi lại): $ARGUMENTS

## Bước 0 — Ưu tiên tuyệt đối: sự cố đang diễn ra ngay bây giờ?

Nếu `$ARGUMENTS` hoặc hội thoại cho thấy production ĐANG down/lỗi NGAY BÂY
GIỜ (real-time) → gọi `developer:incident-commander` NGAY, dừng mọi bước
khác trong skill này. Agent đó chỉ điều phối (severity, việc cần làm ngay,
bằng chứng cần giữ) — không tự khắc phục; hành động khắc phục thật (rollback,
hotfix) do người dùng quyết định và thực hiện ngoài skill này.

Không có sự cố real-time → tiếp tục các bước dưới theo nhu cầu.

## Bước 1 — Điều tra (nếu có sự cố đã qua/có bằng chứng)

- Có stack trace/crash log/bug report cụ thể → `developer:root-cause-analyzer`.
- Chỉ có một tập log lớn, chưa biết nhìn vào đâu → `developer:log-analyzer`
  trước để khoanh vùng pattern bất thường, rồi mới sang
  `root-cause-analyzer` nếu cần đi sâu một điểm cụ thể.

## Bước 2 — Ghi nhận bản sửa

Sau khi đã sửa lỗi/phát hành hotfix → `developer:changelog-writer` để ghi
nhận vào changelog.

## Bước 3 — Bảo trì định kỳ (theo nhu cầu, không chạy cho đủ bộ)

| Việc cần làm | Agent |
|---|---|
| Nợ kỹ thuật tích lũy, cần ưu tiên xử lý | `developer:tech-debt-tracker` |
| Nâng cấp dependency đã lỗi thời/có CVE | `developer:dependency-upgrader` |
| Review README/tài liệu Markdown | `developer:docs-reviewer` |
| Viết/cập nhật README, hướng dẫn | `developer:doc-writer` |
| Thành viên mới cần hiểu codebase | `developer:onboarding-guide` |
| Đối chiếu quality gate định kỳ (ADR, coverage, security audit...) | `developer:qms-compliance-checker` |

## Bước 4 — Tổng hợp

```
# Operation & Maintenance: <tình huống>

## Sự cố real-time
<có/không — nếu có, dừng ở incident-commander>

## Điều tra
...

## Đã ghi nhận changelog
...

## Bảo trì định kỳ
...
```
