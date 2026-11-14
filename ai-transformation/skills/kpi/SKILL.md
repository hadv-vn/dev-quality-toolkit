---
name: kpi
description: >
  Điều phối tính KPI theo AI Transformation Program §8 cho một project/kỳ đo
  cụ thể — KPI vận hành §8.1 (AI Adoption, Rework Rate, Nén, Hiệu quả
  token...) từ telemetry thật người dùng cung cấp, và Knowledge Health §8.2
  (c1-c7: Traceability, Orphan Rate, Decision Coverage...) tự đọc từ repo —
  bằng cách giao cho agent `ai-transformation:kpi-analyst` tính toán (tuyệt
  đối không bịa số khi thiếu dữ liệu nguồn). Dùng khi người dùng gõ
  /ai-transformation:kpi hoặc yêu cầu kiểu "tính KPI tuần này cho project",
  "đo Knowledge Health cho repo này", "làm weekly report + dashboard theo
  chuẩn AI Transformation".
argument-hint: "[đường dẫn project — tùy chọn, mặc định thư mục hiện tại] [đường dẫn/ghi chú telemetry — tùy chọn]"
disable-model-invocation: true
allowed-tools: Read, Glob, Grep
---

# KPI — tính KPI theo AI Transformation Program §8

Tham số người dùng cung cấp (đường dẫn project, và/hoặc đường dẫn file
telemetry hoặc dữ liệu tuần dán trực tiếp — có thể trống): $ARGUMENTS

Skill này là bộ ĐIỀU PHỐI — không tự tính KPI, không tự đọc hết repo rồi
suy số thay. Mọi phép tính và luật "không bịa số" đã được định nghĩa chi
tiết trong agent `ai-transformation:kpi-analyst`; skill chỉ chuẩn bị đúng
input cho agent đó.

## Bước 1 — Xác định phạm vi tính

- Project/lát cắt: `$ARGUMENTS` nếu có, nếu không thì thư mục hiện tại.
- Xác định người dùng muốn tính **Phần A (KPI vận hành, cần telemetry)**,
  **Phần B (Knowledge Health, tự đọc repo)**, hay cả hai. Không rõ → hỏi.

## Bước 2 — Thu thập input cho Phần A (nếu được yêu cầu)

KPI vận hành (§8.1) **không tính được nếu thiếu telemetry thật** — đây là
dữ liệu agent không thể tự quan sát (giờ người làm thật, số vòng lặp,
Human-edit...). Trước khi gọi agent:

- `Glob` thử tìm file telemetry đã có trong phạm vi (tên kiểu
  `TELEMETRY*`, `*telemetry*`, hoặc bảng telemetry nhúng trong
  `WEEKLY-*.md`/`DECISION-LOG-*.md`).
- Không tìm thấy gì và người dùng cũng chưa dán dữ liệu trong
  `$ARGUMENTS` → hỏi người dùng cung cấp trực tiếp (bảng Tool · Token est ·
  giờ người thật · số vòng lặp · Rework · Human-edit theo từng task, hoặc
  dữ liệu tuần kiểu EX-05: kế hoạch vs thực tế, bug mở, giờ AI tiết kiệm,
  token tuần). **Không tự chạy agent với dữ liệu giả định** — agent sẽ ghi
  N/A đúng theo luật, nhưng hỏi trước vẫn tốt hơn để tránh một lượt chạy vô
  nghĩa.
- Có dữ liệu rồi (từ file đọc được hoặc người dùng cung cấp) → giao nguyên
  văn cho agent, không tự diễn giải/làm tròn trước.

## Bước 3 — Giao cho agent tính

Gọi agent `ai-transformation:kpi-analyst`, truyền: phạm vi project, dữ liệu
telemetry (nguyên văn, nếu có Phần A), và yêu cầu rõ tính Phần A/Phần B/cả
hai theo Bước 1. Yêu cầu agent trả về đúng định dạng báo cáo đã định nghĩa
(bảng KPI + mục "Tự kiểm bịa số" bắt buộc).

## Bước 4 — Trình lại kết quả

Giữ nguyên bảng số liệu, cột "Nguồn dữ liệu"/"Bằng chứng", và mục "Tự kiểm
bịa số" — không rút gọn các phần này. Có thể tóm tắt phần mở đầu.

Người dùng muốn lưu thành `WEEKLY-*.md`/`DASHBOARD-*.md` → nhắc rằng việc
ghi file do chính agent `kpi-analyst` thực hiện (agent đó có quyền
`Write`/`Edit` trên 2 loại file này) ở lượt gọi vừa rồi hoặc lượt tiếp
theo, không phải skill này tự ghi.

## Nguyên tắc an toàn

- Không tự tính hộ bất kỳ KPI nào ngoài agent — tránh hai nguồn số liệu
  không khớp nhau.
- Không gợi ý/chèn số liệu "ước lượng cho có" khi người dùng chưa cung cấp
  telemetry — im lặng hỏi lại còn hơn đẩy agent vào tình huống phải tự bịa.

## Kết quả bàn giao

```
KPI theo AI Transformation Program §8 cho <phạm vi>:

<toàn bộ báo cáo từ kpi-analyst>
```
