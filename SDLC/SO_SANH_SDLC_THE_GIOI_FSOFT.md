# So sánh: Quy trình SDLC chuẩn thế giới vs. Quy trình sản xuất tại FSoft

Tài liệu này so sánh trực tiếp các mô hình SDLC chuẩn phổ biến trên thế giới
với quy trình sản xuất phần mềm thực tế tại FPT Software (FSoft). Chi tiết
đầy đủ về từng bên xem tại
[`QUY_TRINH_SAN_XUAT_PHAN_MEM.md`](./QUY_TRINH_SAN_XUAT_PHAN_MEM.md) (Phần A
và Phần B).

## 1. Bảng so sánh tổng quan

| Khía cạnh | SDLC chuẩn thế giới | FSoft (FPT Software) |
|---|---|---|
| **Khung tham chiếu** | ISO/IEC/IEEE 12207 (process reference), không bắt buộc mô hình cụ thể | CMMI Level 5 v2.0 (2023) + TMMi Level 5 + ISO/IEC 27001:2013 — có chứng chỉ đánh giá độc lập (KPMG) |
| **Mô hình triển khai** | Tùy tổ chức chọn: Waterfall, V-Model, Iterative, Spiral, Agile, DevOps — không có chuẩn "một mô hình đúng cho tất cả" | Kết hợp song song **V-Model** (dự án fix-price, khách Nhật) và **Agile/Scrum** (dự án sản phẩm số, khách Âu-Mỹ) tùy hợp đồng |
| **Số giai đoạn cốt lõi** | 6 giai đoạn: Yêu cầu → Thiết kế → Phát triển → Kiểm thử → Triển khai → Bảo trì (mọi mô hình đều xoay quanh bộ này) | 5 khâu sản xuất: Thu thập & phân tích yêu cầu → Thiết kế hệ thống → Phát triển → Kiểm thử → Triển khai & bảo trì (gộp triển khai + bảo trì) |
| **Ai thực hiện mỗi giai đoạn** | Linh hoạt theo mô hình: Agile thường để một team nhỏ (cross-functional) tự xoay nhiều vai trò trong cùng sprint | Mỗi khâu gắn với **bộ phận chuyên trách riêng** (BA, Architect, Dev, QA/Tester độc lập, Deployment) — mô hình tổ chức theo chuyên môn hóa, đặc trưng outsourcing quy mô lớn |
| **Quản lý chất lượng** | Thường tích hợp vào từng team (ví dụ: "Definition of Done" trong Scrum); không bắt buộc bộ phận QA tách biệt | Khối **Quality Management** độc lập hoàn toàn khỏi khối **Production**, giám sát chất lượng xuyên suốt mọi dự án/khách hàng |
| **Cơ sở cải tiến quy trình** | Khác nhau theo tổ chức: retrospective (Agile), post-mortem, hoặc không chính thức | **FPT QMS**: Process Asset (5.000+ lessons learned) + Process Database (dữ liệu định lượng từ dự án thực tế) — đặc trưng CMMI cấp 5 "Optimizing": cải tiến dựa trên số liệu, không dựa cảm tính |
| **Tài liệu hóa** | Mức độ tùy mô hình: Waterfall/V-Model đòi hỏi tài liệu đầy đủ ở mỗi giai đoạn; Agile tối giản tài liệu, ưu tiên working software | Cao với dự án theo V-Model (khách hàng Nhật yêu cầu nghiệm thu theo tài liệu từng giai đoạn); thấp hơn với dự án Agile |
| **Tốc độ lặp/release** | Agile/DevOps: release liên tục (nhiều lần/ngày với CI/CD); Waterfall/V-Model: release theo mốc lớn, ít lặp | Tùy loại hợp đồng — dự án V-Model release theo milestone đã cam kết; dự án Agile release theo sprint |
| **Kiểm thử** | Mức độ độc lập giữa Dev và Test tùy tổ chức; nhiều team Agile để Dev tự viết và chạy test | Bộ phận **Testing độc lập** với Development — phù hợp chuẩn TMMi (test maturity được đánh giá riêng, không gộp vào năng lực Dev) |
| **Đối tượng khách hàng điển hình** | Đa dạng, không cố định theo mô hình | Chủ yếu khách hàng nước ngoài (Nhật, Mỹ, Âu) theo hình thức outsourcing/offshore — ảnh hưởng trực tiếp đến việc chọn V-Model hay Agile cho từng hợp đồng |

## 2. Điểm giống nhau

- **Cùng bộ giai đoạn cốt lõi**: cả hai đều đi qua thu thập yêu cầu → thiết
  kế → phát triển → kiểm thử → triển khai → bảo trì. FSoft không phát minh
  quy trình khác biệt, mà là một **cách triển khai cụ thể** của khung SDLC
  chuẩn thế giới, được chuẩn hóa theo CMMI.
- **Không theo tuyệt đối một mô hình**: cả thế giới và FSoft đều kết hợp
  nhiều mô hình (V-Model + Agile) tùy đặc điểm dự án, thay vì cứng nhắc theo
  một mô hình duy nhất.
- **Xu hướng tự động hóa và dữ liệu hóa**: thế giới hướng tới DevOps/CI-CD
  dựa trên dữ liệu vận hành; FSoft hướng tới "Optimizing" (CMMI cấp 5) dựa
  trên Process Database — cùng triết lý cải tiến liên tục bằng số liệu thực
  tế, chỉ khác công cụ/tên gọi.

## 3. Điểm khác biệt đáng chú ý

- **Chuyên môn hóa vs. đa năng hóa**: thế giới (đặc biệt cộng đồng Agile)
  có xu hướng để một team nhỏ, đa năng (full-stack) tự chịu trách nhiệm toàn
  bộ vòng đời tính năng. FSoft tổ chức theo **bộ phận chuyên trách** cho mỗi
  khâu (BA riêng, Dev riêng, QA riêng) — phù hợp để chuẩn hóa chất lượng
  trên quy mô hàng chục nghìn nhân sự và hàng nghìn dự án đồng thời, nhưng
  đổi lại tốc độ phản hồi mỗi vòng lặp thường chậm hơn một team Agile nhỏ.
- **QA độc lập bắt buộc**: nhiều tổ chức Agile phương Tây không có bộ phận
  test tách biệt; FSoft bắt buộc có do yêu cầu của TMMi.
- **Động lực chọn mô hình**: thế giới chọn mô hình theo đặc điểm *sản phẩm*
  (SaaS cần Agile/DevOps, hệ thống nhúng cần Waterfall...). FSoft chọn mô
  hình phần lớn theo đặc điểm *hợp đồng/khách hàng* (khách Nhật thường fix-
  price → V-Model; khách Âu-Mỹ thường Agile) — phản ánh bản chất công ty
  outsourcing/offshore.
- **Chứng chỉ hóa quy trình**: thế giới không bắt buộc tổ chức phải có
  chứng chỉ (CMMI/TMMi là lựa chọn). FSoft coi đây là lợi thế cạnh tranh
  chính khi đấu thầu dự án outsourcing quốc tế, nên đầu tư đạt và duy trì
  liên tục ở mức cao nhất (Level 5) từ năm 2002 đến nay.

## 4. Khi nào nên theo mô hình nào

| Tình huống | Nên nghiêng về |
|---|---|
| Startup/sản phẩm số, cần ra thị trường nhanh, scope thay đổi liên tục | Agile/DevOps (thế giới) |
| Dự án outsourcing fix-price, khách hàng yêu cầu nghiệm thu theo tài liệu | V-Model (cả thế giới và FSoft áp dụng) |
| Tổ chức quy mô lớn, nhiều dự án/khách hàng đồng thời, cần chuẩn hóa chất lượng xuyên suốt | Mô hình kiểu FSoft: QMS tập trung + bộ phận chuyên trách theo khâu |
| Team nhỏ, cần tốc độ và quyền tự quản cao | Agile với team cross-functional (ít chuyên môn hóa vai trò) |

## Nguồn tham khảo

- [FPT Software Re-appraised at CMMI Level 5 v2.0](https://fptsoftware.com/newsroom/news-and-press-releases/news/fpt-software-re-appraised-at-cmmi-level-5-v2-0)
- [FPT Software: TMMi Level 5 Certification Pioneer](https://fptsoftware.com/newsroom/news-and-press-releases/press-release/fpt-software-first-company-in-vietnam-to-achieve-tmmi-level-5)
- [FPT Software là công ty Việt Nam đầu tiên đạt CMMI level 5 V2.0](https://chungta.vn/cong-nghe/fpt-software-la-cong-ty-viet-nam-dau-tien-dat-cmmi-level-5-v2-0-1131603.html)
- [Knowledge Base: 'Tri kỷ' trên hành trình bứt phá năng suất dự án tại FPT](https://chungta.vn/nguoi-fpt/knowledge-base-tri-ky-tren-hanh-trinh-but-pha-nang-suat-du-an-tai-fpt-1139332.html)
