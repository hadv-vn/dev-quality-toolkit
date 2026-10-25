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

## Mẫu slide bắt buộc

Mọi slide tạo ra PHẢI theo đúng mẫu thiết kế đã dựng sẵn trong
`teacher/templates/`, không tự vẽ shape/màu/font mới:

- `teacher/templates/theme.json` — bảng màu, font (`Cambria`), danh sách
  icon, và mô tả 7 khuôn slide (`layouts`) cùng khi nào dùng khuôn nào.
- `teacher/templates/slide_template.pptx` — file nguồn chứa 7 slide mẫu
  (cover, divider, cards_2x2, icon_list, compare_quote, dark_checklist,
  closing) đã đúng màu/font/icon/bố cục thương hiệu.
- `teacher/templates/pptx_helpers.py` — hàm dùng lại: `duplicate_slide()`
  (nhân bản 1 slide mẫu), `set_text()` (điền chữ vào placeholder theo tên,
  giữ nguyên định dạng), `set_icon()` (đổi icon theo tên trong
  `theme.json["icons"]`), `delete_template_slides()` (xoá 7 slide mẫu gốc
  trước khi lưu file cuối).
- `teacher/templates/assets/icons/*.png` — icon dùng cho `set_icon()`.

KHÔNG dùng `python-pptx` để tự vẽ shape/màu từ đầu cho slide bài giảng.
Luôn `Presentation(h.TEMPLATE_PATH)` rồi `duplicate_slide()` + `set_text()`
+ `set_icon()` theo đúng tên placeholder trong `theme.json`.

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

   | # | Phần | Nội dung slide | Khuôn trong `theme.json["layouts"]` |
   |---|------|-----------------|--------------------------------------|
   | 1 | Trò chơi khởi động đầu giờ | Game ngắn (đoán hình, ô chữ, ai nhanh hơn, tình huống nhanh...) liên quan trực tiếp đến bài học, tạo hứng thú, không lan man. | `cards_2x2` (luật chơi/câu hỏi) hoặc `divider` |
   | 2 | Gợi mở | 1-2 câu hỏi/tình huống nối từ kết quả trò chơi sang vấn đề chính của bài, dẫn vào Tên bài học. | `divider` |
   | 3 | Tên bài học | Slide tiêu đề: tên bài, môn, lớp. | `cover` |
   | 4 | Mục tiêu đạt được | Gạch đầu dòng ngắn gọn yêu cầu cần đạt (kiến thức - năng lực - phẩm chất), viết ở góc nhìn học sinh ("Em sẽ..."). | `cards_2x2` hoặc `icon_list` |
   | 5 | Khám phá nội dung | Chia theo đơn vị kiến thức trong nguồn tham khảo, mỗi đơn vị 1-2 slide, ít chữ, gợi ý hình ảnh/sơ đồ, có câu hỏi dẫn dắt. | `icon_list` và/hoặc `compare_quote`, lặp lại nhiều slide nếu nhiều đơn vị kiến thức |
   | 6 | Luyện tập | Câu hỏi/bài tập áp dụng ngay nội dung vừa học, bám đúng Mục tiêu ở phần 4. | `cards_2x2` hoặc `dark_checklist` |
   | 7 | Vận dụng | Liên hệ thực tế đời sống học sinh hoặc nhiệm vụ về nhà, mở rộng ngoài lớp học. | `closing` |

   Mỗi slide trong outline ghi rõ: **tiêu đề slide**, **nội dung/bullet**,
   **gợi ý hình ảnh/minh họa**, **ghi chú cho giáo viên** (nếu cần dẫn dắt
   thêm lời nói, không hiện trên slide).

5. **Trình outline cho người dùng duyệt trước khi xuất file** — đặc biệt
   phần Trò chơi khởi động (vì đây là phần sáng tạo, dễ cần chỉnh theo ý
   giáo viên) và Mục tiêu đạt được (vì ảnh hưởng toàn bộ các phần sau).

6. **Xuất file PowerPoint** (sau khi outline được duyệt), LUÔN theo mẫu
   trong `teacher/templates/` (xem "Mẫu slide bắt buộc" ở trên), không tự
   vẽ shape/màu mới:
   - Kiểm tra có `python-pptx` (`pip list`, thiếu thì
     `pip install python-pptx`).
   - Viết script Python: `sys.path.insert(0, ".../teacher/templates")`,
     `import pptx_helpers as h`, `prs = Presentation(h.TEMPLATE_PATH)`.
   - Với mỗi slide trong outline: `h.duplicate_slide(prs, h.LAYOUT["<khuôn>"])`
     theo đúng khuôn đã chọn ở bảng trên, rồi `h.set_text(slide, "<tên
     placeholder>", "<nội dung>")` cho từng placeholder (xem danh sách
     placeholder của từng khuôn trong `theme.json["layouts"][...]["placeholders"]`),
     và `h.set_icon(slide, "<tên placeholder icon>", "<tên icon>")` nếu khuôn
     có icon (danh sách icon hợp lệ trong `theme.json["icons"]`).
   - Sau khi nhân bản và điền xong TẤT CẢ slide, gọi `h.delete_template_slides(prs)`
     một lần duy nhất ở cuối, rồi `prs.save(...)`.
   - Đặt tên file: `BaiGiang_<Môn><Lớp>_<TênBài>_<NămHọc>.pptx`, lưu vào
     thư mục làm việc của người dùng (không lưu đè lên `slide_template.pptx`).
   - Mở lại file sau khi tạo để xác nhận đọc được, không còn placeholder
     `[[...]]` nào sót lại, và khớp outline.

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
   - [ ] Mọi slide đều nhân bản từ `slide_template.pptx` qua `pptx_helpers.py`,
     không có shape/màu tự vẽ ngoài mẫu; không còn placeholder `[[...]]` nào
     sót lại trong file cuối.

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
