---
name: slide-design
description: >
  Thiết kế slide bài giảng PowerPoint theo cấu trúc cố định 7 phần (Trò chơi
  khởi động - Gợi mở - Tên bài học - Mục tiêu đạt được - Khám phá nội dung -
  Luyện tập - Vận dụng), bám sát khung 4 hoạt động của Công văn 5512. Cần 2
  input: (1) tên bài học, (2) đường link sách/tài liệu hoặc folder tham khảo.
  Dùng khi người dùng yêu cầu soạn slide bài giảng cho môn GDCD/GDKTPL.
argument-hint: "[tên bài học] [link hoặc folder tài liệu tham khảo]"
tools: Read, Write, Glob, Grep, PowerShell, WebFetch, WebSearch
---

# Thiết kế slide bài giảng (7 phần theo CV 5512)

## Input bắt buộc

1. **Tên bài học**: môn, lớp, bộ sách (Kết nối tri thức/Chân trời sáng tạo/
   Cánh diều...), tên bài/chủ đề cụ thể. Thiếu thông tin nào → hỏi lại, không
   tự đoán bộ sách.
2. **Nguồn tham khảo**: link sách/tài liệu (web) hoặc đường dẫn folder chứa
   tài liệu (local). Nếu người dùng không cung cấp, hỏi trước khi làm tiếp —
   không tự soạn nội dung từ trí nhớ khi có thể tra nguồn thật.

## Quy trình

1. **Thu thập input.** Xác nhận đủ 2 input bắt buộc ở trên. Thiếu → dừng,
   hỏi cụ thể cái gì còn thiếu (không hỏi dồn những gì đã có).

2. **Tra nguồn tham khảo.**
   - Link web → `WebFetch` lấy đúng nội dung bài học (không suy diễn ngoài
     nguồn). Không fetch được → báo lỗi rõ, hỏi người dùng link khác hoặc
     dán nội dung trực tiếp.
   - Folder local → `Glob` tìm file liên quan đến tên bài (theo số bài/tên
     chủ đề), `Read` nội dung. Nhiều file khớp → hỏi người dùng chọn đúng
     file trước khi đọc hết.
   - Ghi lại: yêu cầu cần đạt, nội dung chính, ví dụ/tình huống trong nguồn —
     dùng làm căn cứ duy nhất cho nội dung slide, không bịa thêm kiến thức
     ngoài nguồn.

3. **Xác định Mục tiêu đạt được** (yêu cầu cần đạt): Kiến thức - Năng lực -
   Phẩm chất, lấy từ nguồn tham khảo; nếu nguồn không nêu rõ, tra theo
   Chương trình GDPT 2018 và nói rõ đây là phần bổ sung ngoài nguồn gốc.

4. **Soạn outline đủ 7 phần, đúng thứ tự, không bỏ phần nào:**

   | # | Phần | Nội dung slide |
   |---|------|-----------------|
   | 1 | Trò chơi khởi động đầu giờ | Game ngắn (đoán hình, ô chữ, ai nhanh hơn, tình huống nhanh...) liên quan trực tiếp đến bài học, tạo hứng thú, không lan man. |
   | 2 | Gợi mở | 1-2 câu hỏi/tình huống nối từ kết quả trò chơi sang vấn đề chính của bài, dẫn vào Tên bài học. |
   | 3 | Tên bài học | Slide tiêu đề: tên bài, môn, lớp. |
   | 4 | Mục tiêu đạt được | Gạch đầu dòng ngắn gọn yêu cầu cần đạt (kiến thức - năng lực - phẩm chất), viết ở góc nhìn học sinh ("Em sẽ..."). |
   | 5 | Khám phá nội dung | Chia theo đơn vị kiến thức trong nguồn tham khảo, mỗi đơn vị 1-2 slide, ít chữ, gợi ý hình ảnh/sơ đồ, có câu hỏi dẫn dắt. |
   | 6 | Luyện tập | Câu hỏi/bài tập áp dụng ngay nội dung vừa học, bám đúng Mục tiêu ở phần 4. |
   | 7 | Vận dụng | Liên hệ thực tế đời sống học sinh hoặc nhiệm vụ về nhà, mở rộng ngoài lớp học. |

   Mỗi slide trong outline ghi rõ: **tiêu đề slide**, **nội dung/bullet**,
   **gợi ý hình ảnh/minh họa**, **ghi chú cho giáo viên** (nếu cần dẫn dắt
   thêm lời nói, không hiện trên slide).

5. **Trình outline cho người dùng duyệt trước khi xuất file** — đặc biệt
   phần Trò chơi khởi động (vì đây là phần sáng tạo, dễ cần chỉnh theo ý
   giáo viên) và Mục tiêu đạt được (vì ảnh hưởng toàn bộ các phần sau).

6. **Xuất file PowerPoint** (sau khi outline được duyệt), theo đúng chuẩn
   kỹ thuật đã dùng trong agent `gdcd-expert`:
   - Dùng `python-pptx` (kiểm tra có sẵn bằng `pip list`, thiếu thì
     `pip install python-pptx`).
   - Layout đơn giản, nhất quán (theme màu, font); mỗi slide một ý chính.
   - Đặt tên file: `BaiGiang_<Môn><Lớp>_<TênBài>_<NămHọc>.pptx`.
   - Mở lại file sau khi tạo để xác nhận đọc được và khớp outline.

7. **Tự kiểm tra trước khi giao:**
   - [ ] Đủ đúng 7 phần, đúng thứ tự, không phần nào trống.
   - [ ] Trò chơi khởi động liên quan trực tiếp đến nội dung bài (không phải
     game chung chung lắp vào bài nào cũng được).
   - [ ] Mục tiêu đạt được khớp với nội dung Khám phá, câu hỏi Luyện tập, và
     tình huống Vận dụng (không có mục tiêu bị bỏ rơi không slide nào đáp
     ứng).
   - [ ] Nội dung Khám phá đúng với nguồn tham khảo đã tra ở bước 2, không
     bịa thêm kiến thức ngoài nguồn.
   - [ ] Mỗi slide ít chữ, không viết thành đoạn văn.

8. **Báo kết quả**: đường dẫn file đã tạo + tóm tắt outline 7 phần (không
   dán lại toàn bộ nội dung slide trong câu trả lời).

## Ghi chú

- Đây là skill con, bổ trợ cho phần "Soạn slide bài giảng" trong agent
  `gdcd-expert` — dùng khi người dùng muốn áp đúng cấu trúc 7 phần này thay
  vì outline slide chung của agent.
- Không tự chọn bộ sách hoặc lớp khi người dùng chưa nói rõ.
- Nếu đồng thời được yêu cầu soạn giáo án (KHBD) đầy đủ, soạn giáo án trước
  theo quy trình của agent `gdcd-expert`, slide theo skill này phải bám đúng
  giáo án đã soạn.
