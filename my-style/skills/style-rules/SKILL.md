---
name: style-rules
description: >
  Nội dung chuẩn, cố định của 9 trường phái triết lý lập trình (taste/cấu
  trúc dữ liệu, tập trung sâu, đơn giản tối đa, TDD từng bước nhỏ, refactor
  liên tục, code để đọc, ước lượng bằng số, code như nghệ thuật, convention
  over configuration). Luôn được nạp như tài liệu nền khi plugin
  `my-style` được kích hoạt — không cần gọi lệnh. Skill `init` dùng đúng
  nội dung này làm nguồn duy nhất khi soạn file rule cho một project cụ thể,
  để nội dung không bị viết lại khác nhau giữa các lần chạy.
disable-model-invocation: true
---

# 9 trường phái "taste" lập trình — nội dung chuẩn

> Đây là NGUỒN DUY NHẤT (single source of truth) cho nội dung 9 nguyên tắc.
> Skill `my-style:init` và agent `init-project` phải lấy đúng nội dung
> này khi soạn file rule — không tự diễn giải lại khác đi, chỉ được thêm
> phần "Áp dụng vào project này" cụ thể theo stack thực tế bên dưới mỗi mục.

## 1. "Taste" và cấu trúc dữ liệu — Linus Torvalds (Linux, Git)

Developer kém lo về code, developer giỏi lo về cấu trúc dữ liệu và quan hệ
giữa chúng. "Taste" là viết code sao cho trường hợp đặc biệt (edge case)
biến mất, thay vì thêm nhiều `if` để xử lý từng trường hợp riêng. Thẳng
thắn trong review, giữ chuẩn mực cao, không ngại nói thẳng khi thiết kế tệ.

## 2. Tập trung sâu và thực dụng — John Carmack (Doom, Quake)

Làm việc theo những khoảng tập trung dài, đào sâu đến tận gốc vấn đề thay vì
vá lỗi hời hợt. Chạy từng bước code trong debugger để hiểu chính xác máy
đang làm gì, không đoán. Ưu tiên code đơn giản, dễ đoán, hạn chế trạng thái
thay đổi lung tung (mutable state) — đặc biệt quan trọng ở nơi hiệu năng và
sự ổn định là tối quan trọng.

## 3. Đơn giản tối đa — Ken Thompson & Rob Pike (Unix, Go)

Triết lý Unix: mỗi chương trình làm một việc và làm thật tốt, rồi ghép các
chương trình nhỏ lại với nhau. "Rõ ràng hơn khôn lỏi" (clear is better than
clever) — Go được thiết kế ít tính năng một cách có chủ đích, không thêm
cơ chế chỉ vì nó khả thi.

## 4. Test và bước nhỏ — Kent Beck (TDD, Extreme Programming)

Viết test trước, code sau, rồi refactor. "Make it work, make it right, make
it fast" — đúng theo thứ tự đó, không nhảy cóc sang tối ưu khi chưa đúng và
chưa rõ ràng. Thay đổi code theo từng bước nhỏ, an toàn, luôn giữ code ở
trạng thái chạy được giữa các bước.

## 5. Refactor liên tục — Martin Fowler

Coi code như vườn cây cần chăm sóc thường xuyên, nhận diện "code smell" để
dọn dẹp ngay khi thấy, không để tích tụ. "Ai cũng viết được code máy hiểu.
Developer giỏi viết code con người hiểu."

## 6. Code là để đọc — Donald Knuth & Guido van Rossum

"Literate programming": viết chương trình như một bài văn giải thích cho
người đọc. "Tối ưu hóa sớm là gốc rễ của mọi tội lỗi" (premature
optimization is the root of all evil) — đừng tối ưu trước khi đo. Python
đặt "Readability counts" làm giá trị cốt lõi.

## 7. Ước lượng bằng con số — Jeff Dean (Google)

Trước khi thiết kế, ước lượng nhanh trên giấy (back-of-the-envelope) về độ
trễ, băng thông, bộ nhớ. Thuộc các con số cơ bản (đọc RAM, đọc SSD, round-trip
mạng mất bao lâu...) để biết ngay thiết kế nào khả thi trước khi code.

## 8. Code như nghệ thuật — Salvatore Sanfilippo "antirez" (Redis)

Code có cá tính và có thẩm mỹ, không chỉ là công cụ vô hồn. Viết comment để
giải thích TẠI SAO, không phải chỉ làm gì (cái "làm gì" đã nằm trong code).
Dám bỏ bớt tính năng để giữ thiết kế gọn, thay vì ôm đồm mọi yêu cầu.

## 9. Quy ước thay cho cấu hình — David Heinemeier Hansson (Ruby on Rails)

Convention over configuration: theo quy ước chung thì không cần cấu hình
từng thứ một. Ưu tiên niềm vui và năng suất của developer, chọn giải pháp
đơn giản (ví dụ "majestic monolith") thay vì kiến trúc phức tạp chỉ vì đang
thịnh hành.
