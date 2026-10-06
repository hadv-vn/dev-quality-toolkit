# Danh sách AI Agent & Ví dụ cách đặt prompt

Tài liệu này giới thiệu toàn bộ **45 agent** (plugin `developer`, version `0.4.0`)
trong `dev-quality-toolkit`, nhóm theo 6 giai đoạn SDLC đã mô tả tại
[`QUY_TRINH_SAN_XUAT_PHAN_MEM.md`](./QUY_TRINH_SAN_XUAT_PHAN_MEM.md). Mỗi agent
chỉ làm **một việc duy nhất** — khi gặp yêu cầu, hãy mô tả đúng việc cần làm,
Claude Code sẽ tự chọn agent phù hợp dựa trên nội dung prompt; không cần gọi
tên agent theo cú pháp đặc biệt.

> Cách dùng nhanh: nếu không chắc nên dùng agent nào, cứ mô tả vấn đề bằng
> ngôn ngữ tự nhiên như các ví dụ dưới đây — mô tả CÀNG CỤ THỂ (tên file,
> module, bối cảnh) thì agent càng làm đúng việc ngay từ lần đầu. Nếu vẫn phân
> vân giữa hai agent gần nhau, dùng skill `/developer:agent-advisor` — nó đọc
> trực tiếp danh sách agent đã đăng ký và ranh giới của từng agent để tư vấn,
> nên luôn đúng với hiện trạng repo kể cả khi tài liệu này chưa kịp cập nhật.

## Mục lục theo giai đoạn

| Giai đoạn | Số agent |
|---|---|
| 1. Thu thập & Phân tích yêu cầu | 2 |
| 2. Thiết kế | 13 |
| 3. Phát triển (Coding) | 11 + 1 skill |
| 4. Kiểm thử | 5 |
| 5. Triển khai | 5 |
| 6. Vận hành & Bảo trì | 7 |
| Xuyên suốt (quality gate & điều phối) | 2 + 2 skill |

---

## 1. Thu thập & Phân tích yêu cầu

### `requirements-analyst`
**Chức năng:** Làm rõ yêu cầu nghiệp vụ còn mơ hồ thành user story có cấu trúc kèm acceptance criteria rõ ràng, trước khi có bất kỳ thiết kế kỹ thuật nào.
**Ví dụ prompt:**
- "Sếp tôi muốn có tính năng 'thông báo cho khách hàng khi đơn hàng có vấn đề' nhưng nói còn rất mơ hồ, giúp tôi làm rõ thành user story."
- "Phân tích giúp yêu cầu này: cho phép người dùng tự export dữ liệu cá nhân, kèm acceptance criteria rõ ràng."

### `srs-writer`
**Chức năng:** Cấu trúc hóa một yêu cầu ĐÃ ĐƯỢC LÀM RÕ (output `requirements-analyst`) thành tài liệu Software Requirements Specification (SRS) theo tinh thần IEEE 830 rút gọn. Chỉ định dạng hóa lại, không tự đào sâu/làm rõ yêu cầu thay.
**Ví dụ prompt:** "requirements-analyst đã làm rõ xong yêu cầu export đơn hàng ra CSV, giúp tôi viết thành tài liệu SRS chính thức."

---

## 2. Thiết kế

### `system-architect`
**Chức năng:** Lập kế hoạch kiến trúc cho một tính năng/hệ thống lớn chưa tồn tại, so sánh trade-off giữa các phương án CHƯA chốt.
**Ví dụ prompt:**
- "Lên kế hoạch triển khai tính năng thông báo real-time, cân nhắc WebSocket hay polling."
- "Cần tách module báo cáo thành service riêng, giúp lên kế hoạch và trade-off cần cân nhắc."

### `high-level-designer`
**Chức năng:** Tài liệu hóa chính thức High-Level Design (sơ đồ thành phần, trách nhiệm, luồng giao tiếp, deployment view, phase breakdown) SAU KHI phương án kiến trúc đã được chốt — không so sánh phương án (đó là `system-architect`).
**Ví dụ prompt:** "system-architect đã đề xuất 2 phương án, tụi tôi chọn phương án tách service Thông báo riêng, giúp tôi viết HLD chính thức."

### `poc-evaluator`
**Chức năng:** Đánh giá PoC/spike kỹ thuật ĐÃ được thực hiện (kiểm chứng công nghệ/rủi ro trước khi chốt phương án), viết PoC Report kèm khuyến nghị go/no-go. Không tự code PoC thay người dùng.
**Ví dụ prompt:** "Đã code thử spike dùng WebSocket cho real-time notification, giúp đánh giá kết quả và viết PoC report."

### `adr-writer`
**Chức năng:** Ghi lại một quyết định kỹ thuật/kiến trúc đã chốt thành Architecture Decision Record theo template chuẩn.
**Ví dụ prompt:**
- "Ghi lại quyết định chọn Redis làm cache layer thành ADR, tụi tôi đã họp và chốt hôm qua."

### `threat-modeler`
**Chức năng:** Phân tích rủi ro bảo mật theo STRIDE cho một kiến trúc/luồng nghiệp vụ sắp xây, ngay ở bước thiết kế, trước khi có code.
**Ví dụ prompt:**
- "Trước khi code, giúp tôi threat model luồng thanh toán mới: client gọi API tạo order, service order gọi service payment qua message queue."
- "Phân tích STRIDE cho thiết kế API upload file người dùng sắp triển khai."

### `low-level-designer`
**Chức năng:** Chi tiết hóa HLD/phương án đã chốt thành Low-Level Design — class/module, method signature, sequence diagram (gồm luồng lỗi), pseudocode — trước khi viết code thật.
**Ví dụ prompt:** "HLD đã chốt dùng message queue cho luồng xử lý đơn hàng, giúp thiết kế chi tiết class/sequence cho module OrderProcessor."

### `api-designer`
**Chức năng:** Thiết kế endpoint REST/GraphQL mới, nhất quán với convention hiện có trong dự án.
**Ví dụ prompt:**
- "Thiết kế giúp endpoint REST cho tính năng đặt lại mật khẩu, theo convention hiện có."
- "Cần thêm mutation GraphQL để hủy đơn hàng, thiết kế schema nhất quán với phần còn lại."

### `data-modeler`
**Chức năng:** Thiết kế MỚI mô hình dữ liệu/ERD (bảng, cột, index, constraint, chiến lược migration) khi CHƯA có migration file nào — ngược chiều với `db-schema-reviewer`.
**Ví dụ prompt:** "Cần thiết kế schema cho tính năng giỏ hàng mới, chưa có migration nào, giúp dựng ERD và chiến lược migration."

### `db-schema-reviewer`
**Chức năng:** Review migration/schema database ĐÃ ĐƯỢC VIẾT RA — index, chuẩn hóa, constraint, an toàn khi chạy trên production.
**Ví dụ prompt:**
- "Review giúp migration mới thêm bảng orders xem index và constraint đã ổn chưa."
- "File migration này chạy trên production có an toàn không, có gây lock table không?"

### `ui-ux-designer`
**Chức năng:** Đặc tả thiết kế giao diện mới (wireframe dạng cấu trúc text + mermaid, luồng màn hình, quy tắc validate) trước khi code UI. Không tạo file ảnh/Figma thật.
**Ví dụ prompt:** "Thiết kế giúp luồng màn hình đặt lại mật khẩu: nhập email, nhập OTP, đặt mật khẩu mới, kèm quy tắc validate."

### `test-plan-writer`
**Chức năng:** Soạn Test Plan (phạm vi, cấp độ kiểm thử, loại kiểm thử, môi trường, tiêu chí vào/ra) TRƯỚC KHI viết test case/test code thật.
**Ví dụ prompt:** "SRS tính năng thanh toán đã rõ, giúp soạn Test Plan trước khi team bắt đầu viết test case."

### `project-estimator`
**Chức năng:** Ước lượng effort kỹ thuật (person-day, kèm best/likely/worst case) cho một yêu cầu đã được làm rõ, dựa trên độ phức tạp code và lịch sử commit thực tế.
**Ví dụ prompt:**
- "Yêu cầu đã rõ: thêm tính năng export đơn hàng ra CSV, ước lượng giúp effort cần bao nhiêu ngày."
- "Dựa vào lịch sử sửa module thanh toán trước đây, ước lượng effort cho việc thêm cổng thanh toán mới."

### `wbs-writer`
**Chức năng:** Cấu trúc hóa phân rã công việc + ước lượng ĐÃ CÓ (output `project-estimator`) thành Work Breakdown Structure phân cấp Phase → Deliverable → Task → Subtask.
**Ví dụ prompt:** "project-estimator đã ước lượng xong effort cho tính năng export CSV, giúp tôi dựng thành WBS phân cấp."

---

## 3. Phát triển (Coding)

### `android-commit-reviewer`
**Chức năng:** Review commit/diff Android (Kotlin/Java, Gradle, Compose, Manifest) trước khi merge.
**Ví dụ prompt:** "Review giúp commit vừa rồi sửa màn hình login bằng Kotlin coroutine."

### `qt-cpp-commit-reviewer`
**Chức năng:** Review commit/diff Qt/C++ — an toàn bộ nhớ, ownership parent-child, signal-slot, thread-safety.
**Ví dụ prompt:** "Review giúp commit abc123 sửa lại QThread worker trong module camera."

### `python-pep8-security-reviewer`
**Chức năng:** Review code Python theo PEP8 + rủi ro bảo mật OWASP trước khi merge.
**Ví dụ prompt:** "Review giúp file scripts/import_data.py xem có vấn đề PEP8 và bảo mật gì không."

### `architecture-reviewer`
**Chức năng:** Đánh giá thiết kế kiến trúc code hiện có — coupling, layering, SOLID, circular dependency, god object.
**Ví dụ prompt:** "Đánh giá kiến trúc giúp module services/ xem có vi phạm layering hay coupling chặt quá không."

### `refactor-assistant`
**Chức năng:** Refactor an toàn (behavior-preserving) — extract method, loại trùng lặp, tách god object — có kiểm tra test trước/sau.
**Ví dụ prompt:** "Refactor giúp function xử lý đơn hàng trong order.py đang quá dài và lồng nhau nhiều if."

### `test-writer`
**Chức năng:** Viết unit test cho code hiện có, theo đúng framework/convention dự án đã dùng.
**Ví dụ prompt:** "Viết unit test cho function tính giá giỏ hàng trong cart.py."

### `dependency-auditor`
**Chức năng:** Rà soát package bên thứ 3: lỗi thời/không maintain, CVE đã biết, license rủi ro.
**Ví dụ prompt:** "Rà soát giúp package.json xem có CVE hay license rủi ro không."

### `dependency-upgrader`
**Chức năng:** Thực thi nâng cấp version package/framework cụ thể, xử lý breaking change, chạy test xác nhận không regression.
**Ví dụ prompt:** "Nâng cấp giúp Express từ 4 lên 5, xử lý luôn breaking change nếu có."

### `tech-debt-tracker`
**Chức năng:** Quét và ưu tiên hóa nợ kỹ thuật toàn repo (TODO/FIXME, dead code, API deprecated, test bị skip) thành backlog.
**Ví dụ prompt:** "Quét giúp toàn bộ dự án xem nợ kỹ thuật đang ở đâu, cái nào nên xử lý trước."

### `api-doc-generator`
**Chức năng:** Sinh/cập nhật tài liệu API từ code thực tế (OpenAPI/Swagger, docstring/JSDoc/Javadoc).
**Ví dụ prompt:** "Sinh OpenAPI spec cho các endpoint trong routes/order.js."

### `pr-description-writer`
**Chức năng:** Viết mô tả Pull Request dựa trên diff giữa nhánh và base branch.
**Ví dụ prompt:** "Viết giúp mô tả PR cho nhánh feature/payment-retry so với main."

### Skill `/developer:commit`
**Chức năng:** Viết commit message theo convention của dự án rồi tạo commit sau khi người dùng xác nhận.
**Ví dụ prompt:** `/developer:commit`

---

## 4. Kiểm thử

### `e2e-test-runner`
**Chức năng:** Viết và/hoặc chạy integration/E2E test cho một luồng nghiệp vụ hoặc API cụ thể.
**Ví dụ prompt:** "Viết integration test cho API tạo đơn hàng, cần test cả trường hợp kho hết hàng."

### `test-coverage-analyzer`
**Chức năng:** Phân tích coverage report để chỉ ra vùng code thiếu test và nên ưu tiên viết ở đâu trước.
**Ví dụ prompt:** "Phân tích coverage giúp module payment/ xem chỗ nào chưa có test và nên ưu tiên viết ở đâu trước."

### `flaky-test-detector`
**Chức năng:** Tìm nguyên nhân gốc và sửa test đã tồn tại nhưng lúc pass lúc fail dù code không đổi.
**Ví dụ prompt:** "Test này lúc pass lúc fail trong CI, giúp tôi tìm nguyên nhân và sửa."

### `security-auditor`
**Chức năng:** Audit lỗ hổng bảo mật trong code đã viết — injection, lỗi auth/phân quyền, rò rỉ secret, OWASP Top 10.
**Ví dụ prompt:** "Audit bảo mật giúp thư mục services/auth/ trước khi release."

### `performance-profiler`
**Chức năng:** Phân tích hiệu năng — bottleneck thuật toán, query chậm, N+1 query, memory leak.
**Ví dụ prompt:** "Profile giúp module services/reports/ xem có bottleneck hay query chậm không."

---

## 5. Triển khai

### `docker-optimizer`
**Chức năng:** Tối ưu Dockerfile theo 3 trục: kích thước image, layer caching, bảo mật (non-root, pin version).
**Ví dụ prompt:** "Tối ưu giúp Dockerfile của service api, image đang nặng 1.2GB."

### `iac-reviewer`
**Chức năng:** Review Terraform/K8s/CloudFormation/Helm trước khi apply — IAM quá rộng, network exposure, secret hardcode.
**Ví dụ prompt:** "Review giúp Terraform trong thư mục infra/ xem có security group nào mở quá rộng không."

### `ci-fixer`
**Chức năng:** Chẩn đoán và sửa trực tiếp pipeline CI đang fail, không làm CI "pass giả".
**Ví dụ prompt:** "CI đang fail ở bước build, đây là log lỗi, sửa giúp."

### `deployment-validator`
**Chức năng:** Kiểm tra cấu hình pre-flight trước khi deploy — env var, secret hardcode, health check, resource limit.
**Ví dụ prompt:** "Kiểm tra giúp cấu hình trước khi deploy service payment lên staging."

### `release-manager`
**Chức năng:** Lập kế hoạch & checklist go/no-go, thứ tự deploy, kế hoạch rollback cho một lần release cụ thể (không tự thực hiện deploy).
**Ví dụ prompt:**
- "Chuẩn bị release v2.3.0 giúp tôi, gồm checklist go/no-go và kế hoạch rollback."
- "Lập kế hoạch điều phối deploy bản v1.5.0 lên production, có migration DB kèm theo."

---

## 6. Vận hành & Bảo trì

### `incident-commander`
**Chức năng:** Điều phối phản ứng khi sự cố production ĐANG DIỄN RA — xác định severity, checklist hành động ngay, bằng chứng cần thu thập (không tự thực hiện khắc phục).
**Ví dụ prompt:**
- "Production đang down, error rate tăng vọt 5 phút trước, giúp tôi xác định mức độ nghiêm trọng và việc cần làm ngay."
- "API thanh toán đang trả lỗi 500 hàng loạt, cần quyết định rollback hay fix forward ngay."

### `log-analyzer`
**Chức năng:** Phân tích một tập log production diện rộng để tìm pattern bất thường (error spike, retry loop, rò rỉ PII/secret).
**Ví dụ prompt:** "Phân tích giúp file log production này xem có pattern lỗi bất thường nào không."

### `root-cause-analyzer`
**Chức năng:** Truy nguyên nguyên nhân gốc của một sự cố/stack trace/crash log cụ thể qua call chain và git blame.
**Ví dụ prompt:** "Đây là stack trace NullPointerException từ production, giúp tôi tìm nguyên nhân gốc."

### `changelog-writer`
**Chức năng:** Tổng hợp CHANGELOG từ lịch sử commit/PR giữa hai mốc, chuẩn bị cho một bản release.
**Ví dụ prompt:** "Tổng hợp CHANGELOG từ tag v1.2.0 tới HEAD trước khi release v1.3.0."

### `onboarding-guide`
**Chức năng:** Giải thích tổng quan codebase, kiến trúc, cách chạy dự án cho developer mới — qua hội thoại, không viết file.
**Ví dụ prompt:** "Tôi mới vào dự án, giải thích giúp cấu trúc tổng quan và cách chạy dự án này."

### `docs-reviewer`
**Chức năng:** Review chất lượng tài liệu Markdown/README — lỗi chính tả, link nội bộ hỏng, cấu trúc heading không nhất quán.
**Ví dụ prompt:** "Review giúp tôi các file README trong thư mục docs/ xem có lỗi chính tả hay link hỏng không."

### `doc-writer`
**Chức năng:** Viết mới hoặc cập nhật README, hướng dẫn cài đặt/sử dụng, CONTRIBUTING, tài liệu nội bộ.
**Ví dụ prompt:** "Viết README cho module payment/ mới thêm."

---

## Xuyên suốt — Quality gate & điều phối

### `qms-compliance-checker`
**Chức năng:** Đối chiếu một dự án/tính năng với checklist quy trình chất lượng nội bộ kiểu CMMI (ADR, test coverage, security audit, changelog...), chỉ ra cổng chất lượng nào đã qua/còn thiếu. Chỉ kiểm tra SỰ TỒN TẠI artifact, không nối liên kết chi tiết từng yêu cầu (đó là `rtm-manager`).
**Ví dụ prompt:**
- "Kiểm tra giúp tính năng thanh toán mới này đã đủ hồ sơ theo quy trình chất lượng chưa — ADR, test, security audit, changelog."
- "Trước khi đóng sprint, đối chiếu giúp dự án này với checklist quality gate nội bộ."

### `rtm-manager`
**Chức năng:** Tạo mới/cập nhật Requirements Traceability Matrix — nối TỪNG ID yêu cầu với thiết kế, code/PR, test case và kết quả test, chỉ ghi nhận liên kết có bằng chứng thực tế (Grep được).
**Ví dụ prompt:** "SRS tính năng đặt hàng đã có ID REQ-ORD-001 đến REQ-ORD-010, khởi tạo RTM giúp tôi."

### Skill `/developer:pre-merge`
**Chức năng:** Điều phối các reviewer theo đúng stack công nghệ của diff, gộp kết quả thành một checklist PASS/WARN/FAIL duy nhất trước khi merge.
**Ví dụ prompt:** `/developer:pre-merge`

### Skill `/developer:agent-advisor`
**Chức năng:** Tư vấn nên dùng agent nào trong plugin cho một việc cụ thể — đọc trực tiếp `plugin.json` + mô tả/ranh giới từng agent (luôn đúng hiện trạng, không dựa danh sách tĩnh), đối chiếu bảng phân biệt các cặp agent dễ nhầm, trả về agent (hoặc chuỗi agent) phù hợp kèm prompt mẫu.
**Ví dụ prompt:** `/developer:agent-advisor` "Tôi cần thiết kế lại luồng thanh toán, không biết nên bắt đầu từ agent nào."

---

## Mẹo đặt prompt hiệu quả

1. **Nêu rõ file/module cụ thể** thay vì mô tả chung ("review giúp file `order.py`" tốt hơn "review code giúp").
2. **Nêu rõ giai đoạn/bối cảnh** khi dễ nhầm giữa hai agent gần nhau — ví dụ nói rõ "trước khi code" để vào `threat-modeler` thay vì `security-auditor` (agent đó chỉ soát code đã viết).
3. **Với agent chỉ phân tích/báo cáo** (phần lớn agent ở Phần 2, 4, 6 và `qms-compliance-checker`), đừng kỳ vọng agent tự sửa file — nếu cần sửa, nối thêm yêu cầu dùng agent hành động tương ứng (ví dụ: `security-auditor` phát hiện lỗ hổng → tự sửa thủ công hoặc giao việc rõ ràng, vì agent này không có quyền Write/Edit).
4. **Một prompt — một agent.** Nếu công việc trải qua nhiều giai đoạn (ví dụ "làm rõ yêu cầu rồi thiết kế luôn"), nên tách thành nhiều lượt hỏi tuần tự để đúng agent chuyên trách từng bước, tránh một agent lấn sang phạm vi agent khác.
