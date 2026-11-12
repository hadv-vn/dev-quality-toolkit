---
name: audit
description: >
  Điều phối đối chiếu một project/lát cắt với tiêu chuẩn nội bộ "AI
  Transformation v3.0" (artefact theo 11 bước Build Playbook, Delegation Map
  L0-L5/Leash A-A+, 3 cơ chế governance, 3 luật cứng, Decision Log thật,
  RTM, telemetry, 3 cổng Viva mini) bằng cách giao cho agent
  `ai-transformation:standard-auditor` chấm PASS/MISSING/N-A, sau đó trình
  lại báo cáo kèm việc cần làm trước khi coi là đạt chuẩn. Dùng khi người
  dùng gõ /ai-transformation:audit hoặc yêu cầu kiểu "đối chiếu project này
  với tiêu chuẩn AI Transformation", "kiểm tra giúp dự án có đủ chuẩn AI
  Transformation chưa trước khi viva".
argument-hint: "[đường dẫn project cần audit — tùy chọn, mặc định thư mục hiện tại]"
disable-model-invocation: true
allowed-tools: Read, Glob, Grep
---

# Audit — đối chiếu tiêu chuẩn AI Transformation v3.0

Đường dẫn project cần audit (có thể trống, mặc định thư mục làm việc hiện
tại): $ARGUMENTS

Skill này là bộ ĐIỀU PHỐI — KHÔNG tự đọc hết toàn bộ artefact và tự chấm
thay. Việc chấm checklist giao đúng cho agent chuyên biệt
`ai-transformation:standard-auditor`, vì toàn bộ logic chấm (đúng artefact
nào ứng với bước nào, Decision Log thế nào mới coi là "thật", Delegation
Map sai ở đâu mới coi là vi phạm governance nghiêm trọng...) đã được định
nghĩa chi tiết trong agent đó — skill lặp lại logic này ở đây sẽ dễ lệch
chuẩn khi agent được cập nhật sau.

## Bước 1 — Xác định phạm vi trước khi gọi agent

- Phạm vi: `$ARGUMENTS` nếu có, nếu không thì thư mục hiện tại.
- Dùng `Glob` xem nhanh có artefact nào mang mã đề hay không (ví dụ
  `*-PB*.md`, `SCOPE*.md`, `DECISION-LOG*.md`...) để biết đây có thực sự là
  project chạy theo chương trình AI Transformation hay không. Nếu hoàn toàn
  không có dấu hiệu nào (không file nào khớp pattern artefact của chương
  trình), hỏi lại người dùng trước khi gọi agent — tránh audit nhầm một
  project không áp dụng chuẩn này.
- Chưa rõ project này đi theo **fast-track 3 giờ** hay **tự học đầy đủ
  [0]-[10]** → hỏi người dùng (ảnh hưởng mục nào tính N-A hợp lệ); nếu
  người dùng không biết, để agent tự suy ra từ artefact có mặt và nói rõ
  giả định đã dùng trong báo cáo.

## Bước 2 — Giao cho agent chấm chuẩn

Gọi agent `ai-transformation:standard-auditor`, giao đúng phạm vi đã xác
định ở Bước 1 kèm thông tin fast-track/tự học đầy đủ nếu đã biết, yêu cầu
trả về báo cáo đầy đủ theo định dạng đã định nghĩa trong agent (theo 11
bước Build Playbook, governance Delegation Map, 3 luật cứng, Decision Log,
RTM/telemetry, 3 cổng Viva mini).

## Bước 3 — Trình lại kết quả

Không rút gọn làm mất bằng chứng cụ thể của từng mục MISSING/vi phạm — đây
là phần người dùng cần để biết chính xác phải sửa gì. Có thể tóm tắt phần
mở đầu, nhưng bảng PASS/MISSING/N-A và mục "Việc cần làm trước khi coi là
đạt chuẩn" phải giữ nguyên từ agent.

## Nguyên tắc an toàn

- Không tự tạo/sửa artefact để "lấp" mục MISSING — đây là skill chỉ đọc và
  báo cáo, giống agent nó điều phối.
- Không tự kết luận project "đạt chuẩn" nếu agent báo còn mục MISSING hoặc
  vi phạm governance nghiêm trọng — chỉ agent/người dùng mới có quyền chốt
  điều đó sau khi đã xử lý xong các mục đó.

## Kết quả bàn giao

Sau khi agent trả báo cáo, trình nguyên báo cáo cho người dùng, kèm một
dòng tóm tắt ở đầu:

```
Đối chiếu tiêu chuẩn AI Transformation cho <phạm vi>: <n> PASS · <n> MISSING
· <n> N-A · <n> vi phạm governance nghiêm trọng (nếu có).

<toàn bộ báo cáo từ standard-auditor>
```
