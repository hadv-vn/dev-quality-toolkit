# Bảng chú giải thuật ngữ SDLC

Tài liệu này định nghĩa các từ khóa/từ viết tắt thường gặp trong quy trình sản
xuất phần mềm (SDLC), dùng làm tài liệu tra cứu chung cho nhóm — ví dụ khi gặp
**SRS** (Software Requirements Specification) hay **WBS** (Work Breakdown
Structure) trong tài liệu dự án, họp hành, hoặc trao đổi với khách hàng.

Các thuật ngữ được nhóm theo 6 giai đoạn SDLC đã mô tả tại
[`QUY_TRINH_SAN_XUAT_PHAN_MEM.md`](./QUY_TRINH_SAN_XUAT_PHAN_MEM.md), cộng
thêm nhóm "Quản lý dự án & vai trò" và "Chuẩn/khung chất lượng" áp dụng xuyên
suốt. Ở mỗi thuật ngữ có agent tương ứng trong toolkit, tài liệu ghi chú luôn
agent đó (xem đầy đủ tại
[`DANH_SACH_AI_AGENT_VA_VI_DU_PROMPT.md`](./DANH_SACH_AI_AGENT_VA_VI_DU_PROMPT.md)).

> Cách dùng: Ctrl+F theo từ viết tắt (ví dụ "SRS") để nhảy tới định nghĩa.
> Bảng tra nhanh dưới đây liệt kê toàn bộ thuật ngữ theo thứ tự alphabet kèm
> nhóm tương ứng, để biết thuật ngữ nằm ở phần nào.

---

## Bảng tra nhanh (alphabet)

| Thuật ngữ | Tên đầy đủ | Nhóm |
|---|---|---|
| ADR | Architecture Decision Record | Thiết kế |
| Baseline | — | Thiết kế |
| BRD | Business Requirements Document | Yêu cầu |
| CD | Continuous Delivery / Continuous Deployment | Triển khai |
| CI | Continuous Integration | Phát triển |
| CMMI | Capability Maturity Model Integration | Chuẩn chất lượng |
| CR | Change Request | Quản lý dự án |
| DoD | Definition of Done | Phát triển |
| DoR | Definition of Ready | Yêu cầu |
| ERD | Entity-Relationship Diagram | Thiết kế |
| FRD/FRS | Functional Requirements Document/Specification | Yêu cầu |
| HLD | High-Level Design | Thiết kế |
| IaC | Infrastructure as Code | Triển khai |
| IEEE 830 / ISO 29148 | Chuẩn đặc tả yêu cầu phần mềm | Chuẩn chất lượng |
| ISO/IEC 27001 | Chuẩn quản lý an toàn thông tin | Chuẩn chất lượng |
| ISO/IEC/IEEE 12207 | Chuẩn tiến trình vòng đời phần mềm | Chuẩn chất lượng |
| KPI | Key Performance Indicator | Quản lý dự án |
| LLD | Low-Level Design | Thiết kế |
| MTTR/MTTD | Mean Time To Repair/Detect | Vận hành |
| MVP | Minimum Viable Product | Thiết kế |
| NFR | Non-Functional Requirement | Yêu cầu |
| PoC | Proof of Concept | Thiết kế |
| Postmortem | — | Vận hành |
| PRD | Product Requirements Document | Yêu cầu |
| QA vs QC | Quality Assurance vs Quality Control | Quản lý dự án |
| RCA | Root Cause Analysis | Vận hành |
| Regression Test | — | Kiểm thử |
| RTM | Requirements Traceability Matrix | Yêu cầu |
| SIT | System Integration Test | Kiểm thử |
| SLA | Service Level Agreement | Triển khai/Vận hành |
| SLO/SLI | Service Level Objective/Indicator | Vận hành |
| Smoke Test | — | Kiểm thử |
| SOW | Statement of Work | Yêu cầu |
| SRS | Software Requirements Specification | Yêu cầu |
| STLC | Software Testing Life Cycle | Kiểm thử |
| TDD (nghĩa 1) | Test-Driven Development | Phát triển |
| TDD (nghĩa 2) | Technical Design Document | Thiết kế |
| TMMi | Test Maturity Model Integration | Chuẩn chất lượng |
| UAT | User Acceptance Test | Kiểm thử |
| UT | Unit Test | Kiểm thử |
| Use Case | — | Yêu cầu |
| User Story | — | Yêu cầu |
| UML | Unified Modeling Language | Thiết kế |
| WBS | Work Breakdown Structure | Thiết kế/Quản lý dự án |

---

## 1. Thu thập & Phân tích yêu cầu

### BRD — Business Requirements Document
Tài liệu mô tả **yêu cầu nghiệp vụ** ở mức cao (bài toán cần giải quyết, mục
tiêu kinh doanh), chưa đi vào chi tiết kỹ thuật. Thường do khách hàng/BA viết
trước khi có SRS.

### SRS — Software Requirements Specification
Tài liệu **đặc tả yêu cầu phần mềm** đầy đủ nhất trong giai đoạn thu thập yêu
cầu: mô tả chức năng (functional requirement), ràng buộc phi chức năng (NFR —
hiệu năng, bảo mật, khả dụng...), giao diện hệ thống, và các ràng buộc khác.
Thường tuân theo chuẩn **IEEE 830** hoặc bản kế thừa **ISO/IEC/IEEE 29148**.
SRS là nền để từ đó thiết kế kỹ thuật (HLD/LLD) và test case được xây dựng,
và là văn bản dùng để khách hàng nghiệm thu phạm vi.
**Agent liên quan trong toolkit:** chưa có agent tạo SRS đầy đủ; gần nhất là
`requirements-analyst` (làm rõ yêu cầu → user story + acceptance criteria,
tương đương phần "functional requirement" của SRS, chưa cover NFR/giao diện
hệ thống theo chuẩn IEEE 830 đầy đủ).

### FRD/FRS — Functional Requirements Document/Specification
Tập con của SRS, chỉ tập trung vào **yêu cầu chức năng** (hệ thống phải làm
gì), không bao gồm NFR. Một số tổ chức dùng FRD thay cho SRS khi dự án nhỏ.

### PRD — Product Requirements Document
Tài liệu phổ biến trong mô hình Agile/sản phẩm số, do Product Owner/PM viết,
mô tả **vấn đề người dùng cần giải quyết**, mục tiêu sản phẩm, và tiêu chí
thành công — ít hình thức hơn SRS, thường đi kèm user story thay vì đặc tả
chi tiết từng chức năng.

### NFR — Non-Functional Requirement
Yêu cầu **phi chức năng**: hiệu năng, bảo mật, khả dụng (availability), khả
chịu tải, khả năng mở rộng, tuân thủ pháp lý... Dễ bị bỏ qua khi thu thập yêu
cầu nhưng là nguyên nhân phổ biến gây rework ở giai đoạn sau nếu bỏ sót.

### Use Case
Mô tả một **luồng tương tác cụ thể** giữa actor (người dùng/hệ thống khác) và
hệ thống để đạt một mục tiêu, gồm luồng chính (main flow) và các luồng ngoại
lệ (alternative/exception flow). Chi tiết hơn user story, phổ biến trong dự án
theo V-Model/chuẩn tài liệu đầy đủ.

### User Story
Mô tả yêu cầu ngắn gọn theo mẫu "Là [vai trò], tôi muốn [việc], để [giá trị]",
phổ biến trong Agile/Scrum. Luôn đi kèm **Acceptance Criteria** để biết khi
nào story được coi là hoàn thành đúng.
**Agent liên quan:** `requirements-analyst`.

### DoR — Definition of Ready
Checklist điều kiện một user story/task phải đạt **trước khi** được đưa vào
sprint để làm (ví dụ: đã có acceptance criteria, đã ước lượng được, không còn
phụ thuộc chưa rõ).

### RTM — Requirements Traceability Matrix
Ma trận **truy xuất yêu cầu**, nối từng yêu cầu (SRS) tới thiết kế, code, và
test case tương ứng — đảm bảo không yêu cầu nào bị bỏ sót hoặc không được
kiểm thử. Bắt buộc trong các chuẩn như V-Model, CMMI cấp cao, dự án y tế/tài
chính cần traceability.

### SOW — Statement of Work
Văn bản hợp đồng mô tả **phạm vi công việc**, deliverable, timeline, và điều
khoản nghiệm thu giữa bên cung cấp dịch vụ (ví dụ công ty outsourcing) và
khách hàng.

---

## 2. Thiết kế

### WBS — Work Breakdown Structure
**Cấu trúc phân rã công việc**: chia một dự án/tính năng lớn thành các work
package nhỏ hơn, có thể giao việc và ước lượng độc lập, thường trình bày theo
dạng cây (deliverable → sub-deliverable → task). WBS là đầu vào để lập lịch
(Gantt chart), phân bổ nguồn lực, và ước lượng effort tổng thể — khác với
backlog Agile ở chỗ WBS thường cố định từ đầu dự án (phù hợp Waterfall/
V-Model/dự án fix-price), còn backlog liên tục tái sắp xếp.
**Agent liên quan trong toolkit:** chưa có agent tạo WBS đúng định dạng cây
work package; gần nhất là `system-architect` (chia phase triển khai) và
`project-estimator` (ước lượng effort person-day cho từng phần việc đã rõ).

### HLD — High-Level Design
Thiết kế **mức cao**: kiến trúc tổng thể, các module/service chính, luồng dữ
liệu giữa chúng — chưa đi vào chi tiết class/function. Tương đương đầu ra của
`system-architect` trong toolkit.

### LLD — Low-Level Design
Thiết kế **mức chi tiết**: class diagram, function signature, thuật toán cụ
thể cho từng module đã xác định ở HLD — là bước ngay trước khi code.

### TDD (nghĩa 2) — Technical Design Document
Tài liệu thiết kế kỹ thuật tổng hợp HLD + LLD cho một tính năng/hệ thống,
dùng để review thiết kế trước khi code. *Lưu ý:* viết tắt TDD này **khác
hoàn toàn** với TDD = Test-Driven Development (xem mục Phát triển) — cần xem
ngữ cảnh để phân biệt.

### ADR — Architecture Decision Record
Bản ghi ngắn một **quyết định kiến trúc** đã chốt: bối cảnh, các phương án
đã xét, quyết định cuối, và hệ quả — giúp không phải tranh luận lại từ đầu.
**Agent liên quan:** `adr-writer`.

### ERD — Entity-Relationship Diagram
Sơ đồ mô tả các **thực thể dữ liệu** và quan hệ giữa chúng (1-1, 1-n, n-n),
dùng để thiết kế schema database.
**Agent liên quan:** `db-schema-reviewer` (review schema/migration, không
tự vẽ ERD).

### UML — Unified Modeling Language
Ngôn ngữ mô hình hóa chuẩn dùng để vẽ class diagram, sequence diagram, use
case diagram... trong thiết kế hệ thống hướng đối tượng.

### PoC — Proof of Concept
Bản dựng nhanh, phạm vi hẹp, để **kiểm chứng tính khả thi kỹ thuật** của một
ý tưởng/công nghệ trước khi đầu tư xây dựng đầy đủ — không nhằm chạy production.

### MVP — Minimum Viable Product
Phiên bản sản phẩm **tối thiểu nhưng dùng được**, chứa đủ tính năng cốt lõi để
đưa ra thị trường/người dùng thật nhằm thu thập phản hồi sớm, khác PoC ở chỗ
MVP hướng tới người dùng thật, không chỉ kiểm chứng kỹ thuật nội bộ.

### Baseline
Phiên bản tài liệu/thiết kế/kế hoạch đã được **chốt và phê duyệt**, dùng làm
mốc so sánh khi có thay đổi (change request) sau này.

### Milestone
Một **điểm mốc quan trọng** trong timeline dự án (ví dụ: hoàn tất thiết kế,
go-live), dùng để theo dõi tiến độ — khác deliverable ở chỗ milestone là một
thời điểm, deliverable là một sản phẩm cụ thể bàn giao.

---

## 3. Phát triển (Coding)

### TDD (nghĩa 1) — Test-Driven Development
Phương pháp viết **test trước khi viết code** (red → green → refactor), đảm
bảo code luôn có test bảo vệ ngay từ đầu. *Lưu ý:* khác với TDD = Technical
Design Document (xem mục Thiết kế).

### CI — Continuous Integration
Thực hành **tích hợp code liên tục** vào nhánh chính nhiều lần/ngày, mỗi lần
tự động build + chạy test để phát hiện lỗi sớm.

### Code Review
Quá trình **đồng nghiệp xem lại code** trước khi merge, nhằm phát hiện lỗi,
đảm bảo tuân thủ convention, và chia sẻ kiến thức trong team.
**Agent liên quan:** các reviewer theo stack (`android-commit-reviewer`,
`qt-cpp-commit-reviewer`, `python-pep8-security-reviewer`) và
`architecture-reviewer`.

### DoD — Definition of Done
Checklist điều kiện một task/story phải đạt để được coi là **hoàn thành**
(ví dụ: code đã review, có test, đã merge, đã deploy lên staging) — tương tự
DoR nhưng áp dụng ở cuối công việc thay vì đầu.

### Technical Debt
**Nợ kỹ thuật**: các thỏa hiệp kỹ thuật (code tạm, thiếu test, dùng API
deprecated...) chấp nhận để đi nhanh hơn trong ngắn hạn, nhưng tích lũy chi
phí bảo trì về sau nếu không xử lý.
**Agent liên quan:** `tech-debt-tracker` (quét & ưu tiên hóa),
`refactor-assistant` (xử lý thật).

---

## 4. Kiểm thử (Testing)

### STLC — Software Testing Life Cycle
Vòng đời kiểm thử phần mềm: phân tích yêu cầu test → lập kế hoạch test → thiết
kế test case → chuẩn bị môi trường → thực thi → đóng chu kỳ test — chạy song
song với SDLC (rõ nhất ở V-Model).

### UT — Unit Test
Kiểm thử **từng hàm/class riêng lẻ**, mock hết dependency, chạy nhanh, do
dev tự viết.
**Agent liên quan:** `test-writer`.

### SIT — System Integration Test
Kiểm thử **tích hợp giữa nhiều module/service** đã ghép lại thành một hệ
thống, sau khi từng phần đã qua unit test.
**Agent liên quan:** `e2e-test-runner`.

### UAT — User Acceptance Test
Kiểm thử **nghiệm thu bởi người dùng/khách hàng thật** (hoặc đại diện), xác
nhận phần mềm đáp ứng đúng yêu cầu nghiệp vụ trước khi chấp nhận bàn giao —
là bước kiểm thử cuối cùng trước go-live trong nhiều dự án outsourcing.

### Smoke Test
Bộ test **rất nhỏ, chạy nhanh** sau mỗi lần build/deploy để xác nhận hệ thống
"còn sống" và các luồng cơ bản nhất không vỡ, trước khi chạy bộ test đầy đủ.

### Regression Test
Kiểm thử lại các chức năng **đã hoạt động đúng trước đó**, nhằm đảm bảo thay
đổi mới (feature/fix) không làm hỏng chức năng cũ.

---

## 5. Triển khai (Deployment)

### CD — Continuous Delivery / Continuous Deployment
**Continuous Delivery**: code luôn ở trạng thái sẵn sàng deploy production,
nhưng việc deploy thật cần một bước approve (thường là người). **Continuous
Deployment**: tự động deploy production ngay khi qua hết pipeline, không cần
approve thủ công — hai khái niệm hay bị nhầm vì cùng viết tắt CD.

### IaC — Infrastructure as Code
Quản lý hạ tầng (server, network, K8s cluster...) bằng **code/cấu hình**
(Terraform, CloudFormation, Helm...) thay vì thao tác tay qua console, giúp
hạ tầng có thể version hóa, review, và tái lập.
**Agent liên quan:** `iac-reviewer`.

### SLA — Service Level Agreement
**Thỏa thuận mức độ dịch vụ** giữa bên cung cấp và khách hàng, cam kết các
chỉ số cụ thể (uptime, thời gian phản hồi hỗ trợ...), thường có điều khoản
phạt (penalty) nếu không đạt.

---

## 6. Vận hành & Bảo trì

### SLO/SLI — Service Level Objective/Indicator
**SLI** là chỉ số đo được thực tế (ví dụ: % request thành công). **SLO** là
mục tiêu nội bộ đặt ra cho SLI đó (ví dụ: SLI "uptime" đạt SLO "99.9%/tháng").
SLA (ở mục Triển khai) là cam kết SLO đó với khách hàng, thường kèm ràng buộc
hợp đồng.

### RCA — Root Cause Analysis
Quá trình truy tìm **nguyên nhân gốc** của một sự cố, không chỉ dừng ở triệu
chứng bề mặt.
**Agent liên quan:** `root-cause-analyzer` (một sự cố cụ thể),
`log-analyzer` (pattern trên log diện rộng).

### Postmortem
Báo cáo **rút kinh nghiệm sau sự cố** (incident): dòng thời gian, nguyên nhân
gốc (RCA), tác động, và hành động khắc phục/ngăn ngừa tái diễn — văn hóa
"blameless postmortem" (không đổ lỗi cá nhân) phổ biến trong DevOps/SRE.

### MTTR/MTTD — Mean Time To Repair/Detect
**MTTD**: thời gian trung bình để **phát hiện** sự cố. **MTTR**: thời gian
trung bình để **khắc phục** sự cố sau khi phát hiện — hai chỉ số đo năng lực
vận hành của team.

---

## 7. Quản lý dự án & vai trò (xuyên suốt)

### CR — Change Request
Đề xuất **thay đổi phạm vi/yêu cầu** so với baseline đã chốt, cần được đánh
giá tác động (effort, timeline, chi phí) và phê duyệt trước khi áp dụng.

### KPI — Key Performance Indicator
Chỉ số đo lường **hiệu quả công việc/quy trình** (ví dụ: defect rate, thời
gian release, năng suất) — ở tổ chức CMMI cấp cao, KPI được thu thập định
lượng qua nhiều dự án để cải tiến quy trình (xem Process Database tại
[`QUY_TRINH_SAN_XUAT_PHAN_MEM.md`](./QUY_TRINH_SAN_XUAT_PHAN_MEM.md)).

### QA vs QC — Quality Assurance vs Quality Control
**QA** (đảm bảo chất lượng): tập trung vào **quy trình** — xây dựng/giám sát
quy trình để lỗi không xảy ra từ đầu (phòng ngừa). **QC** (kiểm soát chất
lượng): tập trung vào **sản phẩm** — kiểm tra/test sản phẩm đã làm ra để tìm
lỗi (phát hiện). Hai khái niệm hay bị dùng lẫn; trong thực tế một bộ phận
"QA" ở nhiều công ty thực chất đang làm công việc QC (testing).

---

## 8. Chuẩn & khung tham chiếu chất lượng

### CMMI — Capability Maturity Model Integration
Mô hình đánh giá **độ trưởng thành quy trình** của tổ chức, 5 cấp độ (cấp 5 —
"Optimizing" — tối ưu liên tục dựa trên dữ liệu định lượng). Không quy định
mô hình SDLC cụ thể, chỉ đánh giá quy trình có được định nghĩa, đo lường, và
cải tiến tốt đến đâu.

### TMMi — Test Maturity Model Integration
Tương tự CMMI nhưng chỉ đánh giá **độ trưởng thành của quy trình kiểm thử**.

### ISO/IEC/IEEE 12207
Chuẩn quốc tế định nghĩa các **tiến trình trong vòng đời phần mềm** (process
reference model), không bắt buộc một mô hình SDLC cụ thể.

### IEEE 830 / ISO/IEC/IEEE 29148
Chuẩn **đặc tả yêu cầu phần mềm (SRS)** — ISO/IEC/IEEE 29148 là bản kế thừa,
mở rộng của IEEE 830 cũ, bao gồm cả quy trình kỹ thuật yêu cầu (requirements
engineering), không chỉ cấu trúc tài liệu.

### ISO/IEC 27001
Chuẩn quốc tế về **hệ thống quản lý an toàn thông tin** (ISMS), thường đi
kèm SDLC ở các dự án có yêu cầu bảo mật/tuân thủ cao (tài chính, y tế, chính
phủ).

---

## Ghi chú về trùng tên viết tắt

Một số viết tắt trong SDLC bị dùng cho **nhiều khái niệm khác nhau** tùy
ngữ cảnh — cần đọc kỹ ngữ cảnh trước khi hiểu nhầm:

| Viết tắt | Nghĩa 1 | Nghĩa 2 |
|---|---|---|
| TDD | Test-Driven Development (phát triển) | Technical Design Document (thiết kế) |
| CD | Continuous Delivery (có approve) | Continuous Deployment (tự động hoàn toàn) |
| QA | Quality Assurance (quy trình, đúng nghĩa gốc) | Trong nhiều công ty dùng để chỉ team testing (thực chất là QC) |
