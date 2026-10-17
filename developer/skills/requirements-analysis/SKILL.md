---
name: requirements-analysis
description: >
  Điều phối giai đoạn phân tích và đặc tả yêu cầu: làm rõ yêu cầu còn mơ hồ
  (nếu cần), cấu trúc hóa thành SRS chính thức, và khởi tạo Requirements
  Traceability Matrix (RTM) để truy xuất về sau. Dùng khi người dùng gõ
  /developer:requirements-analysis hoặc đã có một ý tưởng từ giai đoạn
  Discovery & Planning cần đặc tả thành tài liệu yêu cầu chính thức.
argument-hint: "[tên tính năng/yêu cầu cần đặc tả — có thể để trống]"
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---

# Requirements Analysis

Yêu cầu/tính năng cần đặc tả (có thể trống): $ARGUMENTS

Skill này điều phối, không tự quyết định nghiệp vụ thay người dùng. Đích đến
là một tài liệu SRS đã sẵn sàng làm input cho giai đoạn
`/developer:architecture-design`.

## Bước 1 — Kiểm tra mức độ rõ ràng

Hỏi/đối chiếu: yêu cầu đã có đủ (a) đối tượng dùng, (b) phạm vi, (c) user
story, (d) acceptance criteria chưa?

- Chưa đủ → gọi `developer:requirements-analyst` trước để làm rõ.
- Đã đủ (ví dụ đã qua `/developer:discovery-planning`, hoặc người dùng tự
  cung cấp đầy đủ) → bỏ qua, dùng thẳng làm input Bước 2.

## Bước 2 — Đặc tả SRS

Gọi `developer:srs-writer` với input là user story + acceptance criteria đã
có, yêu cầu xuất SRS theo tinh thần IEEE 830 rút gọn, có ID yêu cầu rõ ràng
(ví dụ `REQ-<module>-NNN`) — ID này cần cho Bước 3.

## Bước 3 — Khởi tạo RTM (tùy chọn)

Nếu người dùng cần truy xuất yêu cầu ↔ thiết kế/code/test ngay từ đầu (dự án
cần traceability, ví dụ chuẩn V-Model/CMMI), gọi `developer:rtm-manager` để
khởi tạo RTM từ các ID yêu cầu vừa có ở Bước 2. Không có nhu cầu này → bỏ qua
mà không cần hỏi lại.

## Bước 4 — Tổng hợp

```
# Requirements Analysis: <tên tính năng>

## SRS
<đường dẫn/tóm tắt file SRS đã tạo, danh sách ID yêu cầu>

## RTM (nếu có)
<trạng thái khởi tạo>

## Bước tiếp theo đề xuất
`/developer:architecture-design` để thiết kế kiến trúc/API/dữ liệu/UI dựa
trên SRS này.
```
