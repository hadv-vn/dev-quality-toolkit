---
name: discovery-planning
description: >
  Điều phối giai đoạn khám phá vấn đề và lập kế hoạch sơ bộ cho một ý tưởng/
  yêu cầu CHƯA được làm rõ: xác định vấn đề cần giải quyết, mục tiêu, quy mô
  thô, và khung kế hoạch ban đầu — trước khi đi vào đặc tả yêu cầu chính thức
  (`/developer:requirements-analysis`). Dùng khi người dùng gõ
  /developer:discovery-planning hoặc có một ý tưởng/feature còn rất mơ hồ cần
  khám phá trước khi làm gì tiếp.
argument-hint: "[mô tả ý tưởng/vấn đề cần khám phá — có thể để trống]"
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---

# Discovery & Planning

Ý tưởng/vấn đề người dùng cung cấp (có thể trống): $ARGUMENTS

Skill này là bộ ĐIỀU PHỐI giai đoạn khám phá — không tự quyết định giải pháp
kỹ thuật, không viết SRS chính thức (đó là giai đoạn sau). Mục tiêu duy nhất:
giúp người dùng đi từ "có một ý tưởng" tới "hiểu rõ vấn đề + có khung kế hoạch
sơ bộ", làm nền cho `/developer:requirements-analysis`.

## Nguyên tắc

- Chỉ ước lượng ở mức THÔ (nhỏ/vừa/lớn, hoặc số ngày sơ bộ kèm cảnh báo độ
  không chắc chắn cao) — ước lượng effort chi tiết có khoảng tin cậy
  best/likely/worst chỉ nên làm SAU KHI yêu cầu đã rõ hơn (ở giai đoạn
  Architecture & Design, dùng `developer:project-estimator`).
- Không ép người dùng trả lời đủ mọi câu hỏi — nếu ý tưởng đã tương đối rõ,
  có thể bỏ qua bước làm rõ và đi thẳng vào phần quy mô/kế hoạch.

## Bước 1 — Làm rõ vấn đề & mục tiêu

`$ARGUMENTS` trống hoặc còn rất mơ hồ → gọi `developer:requirements-analyst`
với yêu cầu: làm rõ vấn đề cần giải quyết là gì, ai là người dùng/đối tượng
hưởng lợi, mục tiêu đo lường được là gì, và ước lượng quy mô thô (nhỏ/vừa/
lớn) kèm đề xuất chia nhỏ nếu quy mô lớn.

`$ARGUMENTS` đã khá rõ (đã có vấn đề + mục tiêu + đối tượng) → bỏ qua bước
này, ghi nhận thẳng vào báo cáo.

## Bước 2 — Ràng buộc & rủi ro sơ bộ

Hỏi/ghi nhận các ràng buộc đã biết: ngân sách, thời hạn, công nghệ bắt buộc,
yêu cầu tuân thủ. Đây là thông tin thu thập trực tiếp từ người dùng/hội
thoại — KHÔNG tự suy đoán hoặc bịa nếu không có.

## Bước 3 — Kế hoạch sơ bộ (tùy chọn)

Nếu người dùng muốn một khung kế hoạch ban đầu (không chỉ dừng ở hiểu vấn
đề), gọi `developer:wbs-writer` với input là các hạng mục/user story sơ bộ từ
Bước 1 để dựng cây Phase → Deliverable → Task ở mức THÔ. Nói rõ với
`wbs-writer` đây là kế hoạch sơ bộ, sẽ được làm chi tiết lại sau khi có
SRS/thiết kế.

## Bước 4 — Tổng hợp

```
# Discovery & Planning: <tên ý tưởng/tính năng>

## Vấn đề cần giải quyết
...

## Mục tiêu & đối tượng hưởng lợi
...

## Quy mô thô
Nhỏ / Vừa / Lớn — <lý do>

## Ràng buộc đã biết
- ...

## Kế hoạch sơ bộ (nếu có)
<bảng WBS mức cao>

## Bước tiếp theo đề xuất
`/developer:requirements-analysis` để đặc tả yêu cầu chính thức (SRS).
```

Không tự chuyển sang viết SRS trong skill này — chỉ đề xuất bước tiếp theo.
