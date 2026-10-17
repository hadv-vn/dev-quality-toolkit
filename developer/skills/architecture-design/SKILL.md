---
name: architecture-design
description: >
  Điều phối giai đoạn thiết kế kiến trúc, module, API, dữ liệu và UI/UX cho
  một yêu cầu đã có SRS: chọn đúng agent thiết kế theo nhu cầu cụ thể (kiến
  trúc tổng thể, HLD/LLD, API, schema dữ liệu, UI, threat model, ADR, test
  plan), không chạy agent không liên quan. Dùng khi người dùng gõ
  /developer:architecture-design hoặc cần thiết kế kỹ thuật cho một tính năng
  đã rõ yêu cầu.
argument-hint: "[tính năng cần thiết kế + các khía cạnh cần (kiến trúc/API/dữ liệu/UI)]"
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---

# Architecture & Design

Phạm vi thiết kế người dùng cung cấp (có thể trống): $ARGUMENTS

Skill này điều phối các agent thiết kế theo ĐÚNG NHU CẦU — không chạy cho đủ
bộ. Nếu `$ARGUMENTS` trống, hỏi: tính năng này cần thiết kế những khía cạnh
nào (kiến trúc/API/dữ liệu/UI/bảo mật)?

## Bước 1 — Kiến trúc tổng thể đã chốt chưa?

Câu hỏi khóa quyết định nhánh xử lý:

- **Chưa chốt, còn ≥2 phương án** → gọi `developer:system-architect` để so
  sánh trade-off. DỪNG lại sau bước này, chờ người dùng chốt phương án trước
  khi tiếp tục Bước 2 — không tự chọn phương án thay người dùng.
- **Đã chốt** (do `system-architect` ở lượt trước, hoặc người dùng tự quyết)
  → sang Bước 2 ngay.
- **Tính năng nhỏ, không cần so sánh phương án** → bỏ qua, sang Bước 2.

## Bước 2 — Tài liệu hóa thiết kế (theo nhu cầu)

Chạy các agent sau, CHỈ khi khía cạnh tương ứng có trong phạm vi:

| Khía cạnh | Agent | Khi nào chạy |
|---|---|---|
| Component/deployment view tổng thể | `developer:high-level-designer` | Kiến trúc đã chốt, cần tài liệu hóa HLD chính thức |
| Class/sequence/pseudocode | `developer:low-level-designer` | Đã có HLD, cần chi tiết hóa trước khi code |
| API REST/GraphQL mới | `developer:api-designer` | Tính năng có endpoint mới |
| Mô hình dữ liệu mới | `developer:data-modeler` | Chưa có migration, cần ERD/schema mới |
| Giao diện người dùng | `developer:ui-ux-designer` | Tính năng có UI mới |
| Rủi ro bảo mật ở bước thiết kế | `developer:threat-modeler` | Luồng nhạy cảm (thanh toán, auth, upload...) |

Có thể chạy song song các agent độc lập nhau (API, dữ liệu, UI, threat model)
trong cùng một lượt; `high-level-designer` nên chạy trước `low-level-designer`
vì LLD cần HLD làm input.

## Bước 3 — Ghi lại quyết định quan trọng

Có quyết định kiến trúc đáng ghi nhận (chọn công nghệ, pattern, trade-off
lớn) → gọi `developer:adr-writer`. Không ghi ADR cho từng chi tiết nhỏ.

## Bước 4 — Test Plan

Gọi `developer:test-plan-writer` để soạn phạm vi/cấp độ/tiêu chí kiểm thử dựa
trên SRS + thiết kế vừa có — chuẩn bị cho giai đoạn
`/developer:verification-testing`, trước khi code.

## Bước 5 — Tổng hợp

```
# Architecture & Design: <tên tính năng>

## Phương án kiến trúc
<đã chốt / đang chờ chốt — nếu đang chờ, dừng ở đây>

## Tài liệu đã tạo
| Khía cạnh | Agent | Kết quả |
|---|---|---|

## ADR
...

## Test Plan
...

## Bước tiếp theo đề xuất
`/developer:implementation` để bắt đầu code theo đúng thiết kế trên.
```
