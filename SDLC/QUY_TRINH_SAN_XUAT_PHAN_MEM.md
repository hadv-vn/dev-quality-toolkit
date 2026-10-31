# Quy trình sản xuất phần mềm (SDLC)

Tài liệu này mô tả quy trình sản xuất phần mềm theo 7 giai đoạn chuẩn, kèm theo
các hoạt động chất lượng xuyên suốt. Ở mỗi giai đoạn, tài liệu chỉ ra agent
tương ứng trong bộ `dev-quality-toolkit` (plugin `developer`) có thể hỗ trợ,
và skill điều phối (`/developer:<tên-skill>`) tự chọn đúng agent cần dùng cho
giai đoạn đó, để nhóm vừa hiểu quy trình, vừa biết dùng công cụ nào vào lúc
nào.

Tài liệu gồm 3 phần: (A) các mô hình SDLC chuẩn phổ biến trên thế giới, (B)
quy trình sản xuất phần mềm thực tế tại FPT Software (FSoft) — một trong các
công ty đạt CMMI Level 5, và (C) quy trình 7 giai đoạn kèm agent hỗ trợ và
skill điều phối trong toolkit này. Xem thêm file
[`SO_SANH_SDLC_THE_GIOI_FSOFT.md`](./SO_SANH_SDLC_THE_GIOI_FSOFT.md) để so
sánh trực tiếp hai quy trình, và file
[`QUY_TRINH_CHI_TIET.md`](./QUY_TRINH_CHI_TIET.md) cho bản đặc tả chi tiết
từng giai đoạn (vai trò/RACI, điều kiện vào/ra, quality gate, template,
checklist) — lưu ý file đó vẫn theo khung 6 giai đoạn cũ, chưa đồng bộ với
khung 7 giai đoạn ở Phần C dưới đây.

---

## Phần A — Các mô hình SDLC chuẩn trên thế giới

SDLC (Software Development Life Cycle) không phải một quy trình cố định mà là
một **tập khung tham chiếu**. Mọi mô hình đều xoay quanh cùng một bộ giai
đoạn cốt lõi (thu thập yêu cầu → thiết kế → phát triển → kiểm thử → triển
khai → bảo trì), khác nhau ở **cách sắp xếp và lặp lại** các giai đoạn đó.

### Các chuẩn/khung tham chiếu phổ biến

- **ISO/IEC/IEEE 12207** — chuẩn quốc tế định nghĩa các tiến trình trong vòng
  đời phần mềm (process reference model), không bắt buộc mô hình cụ thể.
- **CMMI (Capability Maturity Model Integration)** — mô hình đánh giá *độ
  trưởng thành* của tổ chức trong việc quản lý quy trình (5 cấp độ, cấp 5 là
  "Optimizing" — tối ưu hóa liên tục dựa trên dữ liệu định lượng).
- **TMMi (Test Maturity Model Integration)** — tương tự CMMI nhưng tập trung
  riêng vào độ trưởng thành của quy trình kiểm thử.
- **ISO/IEC 27001** — chuẩn quản lý an toàn thông tin, thường đi kèm SDLC ở
  các dự án có yêu cầu bảo mật/tuân thủ cao.
- **IEEE 830 / ISO/IEC/IEEE 29148** — chuẩn đặc tả yêu cầu phần mềm (SRS).

### Các mô hình triển khai SDLC phổ biến

| Mô hình | Đặc điểm | Khi nào phù hợp |
|---|---|---|
| **Waterfall (thác nước)** | Tuyến tính, mỗi giai đoạn hoàn tất mới sang giai đoạn sau, hầu như không lặp lại | Yêu cầu đã rõ và ổn định, ít thay đổi (hệ thống nhúng, hợp đồng fix-price) |
| **V-Model** | Mỗi giai đoạn phát triển có một giai đoạn kiểm thử tương ứng (verification & validation song hành) | Dự án cần tài liệu đầy đủ, truy xuất được (traceability) — phổ biến ở dự án outsourcing cho khách hàng Nhật/Âu, y tế, tài chính |
| **Iterative (lặp)** | Chia nhỏ thành nhiều vòng lặp, mỗi vòng ra một phiên bản hoàn thiện hơn | Yêu cầu chưa hoàn toàn rõ nhưng cần sản phẩm dùng được sớm |
| **Spiral (xoắn ốc)** | Kết hợp iterative với đánh giá rủi ro ở mỗi vòng | Dự án lớn, rủi ro cao, cần kiểm soát rủi ro chặt (hàng không, quốc phòng) |
| **Agile (Scrum/Kanban/XP)** | Phát triển theo sprint ngắn (1-4 tuần), ưu tiên phản hồi nhanh, thay đổi linh hoạt | Sản phẩm số, yêu cầu thay đổi liên tục, cần ra thị trường nhanh |
| **DevOps / Continuous Delivery** | Xóa nhòa ranh giới dev–ops, tự động hóa CI/CD, release liên tục nhiều lần/ngày | Sản phẩm SaaS/web-scale, cần tốc độ release cao và phản hồi production nhanh |

Xu hướng thế giới hiện nay: các tổ chức lớn thường **kết hợp** nhiều mô hình
(ví dụ Agile ở cấp team + stage-gate/V-Model ở cấp quản lý danh mục dự án)
thay vì theo tuyệt đối một mô hình duy nhất.

---

## Phần B — Quy trình sản xuất phần mềm tại FPT Software (FSoft)

FPT Software (FSoft) là công ty phần mềm Việt Nam đạt chứng chỉ **CMMI Level
5** sớm và liên tục tái đánh giá qua nhiều phiên bản: CMM4 (2002 — đầu tiên
Đông Nam Á), CMM5 (2004), CMMI5 (2006), CMMI5 v1.2 (2011), CMMI5 v1.3, và gần
nhất **CMMI Level 5 v2.0 (2023, đánh giá bởi KPMG)**. Ngoài ra FSoft còn là
công ty Việt Nam đầu tiên đạt **TMMi Level 5** (độ trưởng thành quy trình
kiểm thử) và chứng chỉ **ISO/IEC 27001:2013** về an toàn thông tin.

### Hệ thống quản lý chất lượng — FPT QMS

FSoft vận hành quy trình sản xuất dựa trên hệ thống **FPT QMS (Quality
Management System)**, gồm hai thành phần chính:

- **Process Asset** — kho lưu trữ hơn 5.000 "lessons learned" và best
  practice được tổng hợp từ hàng nghìn dự án thực tế, dùng để tra cứu khi bắt
  đầu dự án mới.
- **Process Database** — cơ sở dữ liệu định lượng từ các dự án đã triển khai
  (effort, defect rate, năng suất...), dùng để ước lượng và kiểm soát dự án
  mới dựa trên số liệu thực tế thay vì cảm tính.

Đây chính là đặc trưng của tổ chức đạt CMMI cấp 5 ("Optimizing"): cải tiến
quy trình liên tục dựa trên dữ liệu định lượng, không chỉ dựa vào kinh
nghiệm cá nhân.

### 5 khâu sản xuất chính

Quy trình sản xuất tại FSoft được tổ chức theo 5 khâu, mỗi khâu gắn với một
bộ phận/vai trò chuyên trách (khác với mô hình Agile phương Tây thường để
một team nhỏ tự xoay nhiều vai trò):

1. **Thu thập & phân tích yêu cầu (Requirement Collection & Analysis)** — do
   Business Analyst làm việc trực tiếp với khách hàng (phần lớn là khách
   hàng nước ngoài: Nhật, Mỹ, Âu).
2. **Thiết kế hệ thống (System Design)** — kiến trúc sư thiết kế giải pháp
   dựa trên đặc tả yêu cầu.
3. **Phát triển phần mềm (Software Development)** — lập trình viên code
   theo thiết kế và coding convention của dự án/khách hàng.
4. **Kiểm thử phần mềm (Software Testing)** — bộ phận QA/Tester độc lập,
   không phải chính Dev tự test (phù hợp chuẩn TMMi).
5. **Triển khai & bảo trì (Deployment & Maintenance)** — bàn giao, vận hành,
   hỗ trợ sau go-live.

### Mô hình triển khai: kết hợp V-Model và Agile

FSoft dùng **cả V-Model và Agile** tùy loại dự án:

- **V-Model** — cho các dự án fix-price/fix-scope, đặc biệt với khách hàng
  Nhật Bản yêu cầu tài liệu đầy đủ, quy trình nghiệm thu rõ ràng theo từng
  giai đoạn.
- **Agile/Scrum** — cho các dự án sản phẩm số, khách hàng Âu-Mỹ, cần lặp
  nhanh và thay đổi scope linh hoạt.

### Cơ cấu tổ chức hỗ trợ quy trình

FSoft tổ chức theo 9 khối chức năng: Business Development, **Production**
(trực tiếp làm dự án), **Quality Management** (giám sát chất lượng độc lập
với Production — là một "lớp kiểm soát" riêng chạy xuyên suốt mọi dự án),
Human Resource Management, Finance, Information Systems, Technology,
Support, và Shared Service Center (SSC). Việc tách riêng khối Quality
Management độc lập khỏi Production là điểm khác biệt đáng chú ý so với mô
hình Agile-team-tự-quản thuần túy, phản ánh đặc thù outsourcing quy mô lớn
cần kiểm soát chất lượng chuẩn hóa trên nhiều dự án/khách hàng cùng lúc.

---

## Phần C — Quy trình 7 giai đoạn & Agent hỗ trợ trong dev-quality-toolkit

Phần dưới đây áp dụng bộ khung 7 giai đoạn (tương thích với cả mô hình thế
giới ở Phần A và thực tế FSoft ở Phần B — chỉ khác là giai đoạn "Thu thập &
Phân tích yêu cầu" được tách thành 2 bước rõ ràng hơn: khám phá/lập kế hoạch
sơ bộ trước, rồi mới đặc tả yêu cầu chính thức) vào bộ agent cụ thể có sẵn
trong `dev-quality-toolkit`, để nhóm biết dùng agent/skill nào ở bước nào.

Mỗi giai đoạn có một **skill điều phối** (`/developer:<tên-skill>`) — tự chọn
đúng agent cần dùng theo nhu cầu thực tế của tình huống (không chạy cho đủ
bộ), chạy chúng, và tổng hợp kết quả. Có thể gọi trực tiếp từng agent nếu chỉ
cần một việc cụ thể, hoặc dùng skill điều phối khi cần một vòng xử lý đầy đủ
cho cả giai đoạn.

## Tổng quan

```
1. Discovery & Planning
        │
        ▼
2. Requirements Analysis
        │
        ▼
3. Architecture & Design (kiến trúc, API, dữ liệu, UI/UX)
        │
        ▼
4. Implementation (coding)  ──────┐
        │                         │  (lặp lại trong mỗi sprint/iteration)
        ▼                         │
5. Verification & Testing  ───────┘
        │
        ▼
6. Release & Deployment
        │
        ▼
7. Operation & Maintenance
```

Phần mềm hiện đại hiếm khi đi qua 7 giai đoạn này một lần rồi kết thúc. Thực tế
đây là một vòng lặp: mỗi tính năng mới, mỗi bản sửa lỗi đều đi qua lại từ bước 3
đến bước 7, với tốc độ nhanh dần nhờ CI/CD và tự động hóa kiểm thử.

---

## 1. Discovery & Planning

**Mục tiêu:** Khám phá vấn đề cần giải quyết, xác định mục tiêu, đối tượng
hưởng lợi và ràng buộc, rồi dựng khung kế hoạch sơ bộ — trước khi đặc tả yêu
cầu chi tiết.

**Hoạt động chính:**
- Làm rõ vấn đề/ý tưởng còn mơ hồ: vấn đề gì, cho ai, mục tiêu đo lường được
  là gì.
- Ghi nhận ràng buộc đã biết: ngân sách, thời hạn, công nghệ bắt buộc, tuân
  thủ pháp lý.
- Ước lượng quy mô THÔ (nhỏ/vừa/lớn) — chưa phải effort chi tiết.
- Dựng khung kế hoạch sơ bộ (WBS mức cao), đề xuất chia nhỏ nếu quy mô lớn.

**Đầu ra:** Vấn đề/mục tiêu đã rõ, quy mô thô, khung kế hoạch sơ bộ.

**Sai lầm thường gặp:** Nhảy thẳng vào thiết kế/code khi còn chưa hiểu đúng
vấn đề, hoặc ước lượng effort chi tiết quá sớm khi yêu cầu chưa rõ — đây là
nguyên nhân rework tốn kém nhất trong toàn bộ quy trình.

**Skill điều phối:** `/developer:discovery-planning`

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Làm rõ vấn đề/mục tiêu còn mơ hồ, ước lượng quy mô thô, đề xuất chia nhỏ | `requirements-analyst` |
| Dựng khung kế hoạch sơ bộ (WBS mức cao) từ các hạng mục ban đầu | `wbs-writer` |

---

## 2. Requirements Analysis

**Mục tiêu:** Phân tích và đặc tả yêu cầu đã khám phá ở giai đoạn trước thành
tài liệu chính thức, có thể truy xuất được (traceable) về sau.

**Hoạt động chính:**
- Làm rõ chi tiết user story/use case và acceptance criteria (nếu Discovery &
  Planning chưa đi đủ sâu).
- Cấu trúc hóa thành tài liệu Software Requirements Specification (SRS) theo
  tinh thần IEEE 830 rút gọn, có ID yêu cầu rõ ràng.
- Khởi tạo Requirements Traceability Matrix (RTM) nối từng ID yêu cầu, làm
  nền để cập nhật liên kết với thiết kế/code/test ở các giai đoạn sau.

**Đầu ra:** SRS, RTM khởi tạo (nếu dự án cần truy xuất theo chuẩn V-Model/
CMMI).

**Skill điều phối:** `/developer:requirements-analysis`

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Làm rõ yêu cầu còn mơ hồ thành user story + acceptance criteria | `requirements-analyst` |
| Cấu trúc hóa yêu cầu đã rõ thành SRS chính thức | `srs-writer` |
| Khởi tạo/cập nhật RTM nối yêu cầu ↔ thiết kế/code/test | `rtm-manager` |

---

## 3. Architecture & Design

**Mục tiêu:** Chuyển yêu cầu (SRS) thành bản thiết kế kỹ thuật — kiến trúc hệ
thống, API, mô hình dữ liệu, UI/UX — trước khi code.

**Hoạt động chính:**
- So sánh trade-off giữa các phương án kiến trúc còn chưa chốt; tài liệu hóa
  chính thức (HLD) sau khi đã chốt; chi tiết hóa thành LLD trước khi code.
- Thiết kế API (REST/GraphQL): resource, method, request/response, mã lỗi.
- Thiết kế schema cơ sở dữ liệu: bảng, index, ràng buộc, chuẩn hóa dữ liệu.
- Đặc tả giao diện người dùng: luồng màn hình, trạng thái, quy tắc validate.
- Rà soát rủi ro bảo mật ngay ở bước thiết kế (threat modeling).
- Ghi lại các quyết định kiến trúc quan trọng (ADR) để sau này không phải
  tranh luận lại từ đầu.
- Soạn Test Plan và ước lượng effort chi tiết dựa trên thiết kế đã rõ.

**Đầu ra:** Sơ đồ kiến trúc (HLD/LLD), đặc tả API, ERD/migration, wireframe
UI, các ADR, Test Plan.

**Skill điều phối:** `/developer:architecture-design`

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Lập kế hoạch kiến trúc cho tính năng/hệ thống lớn, so sánh trade-off | `system-architect` |
| Tài liệu hóa HLD chính thức sau khi phương án kiến trúc đã chốt | `high-level-designer` |
| Chi tiết hóa HLD thành LLD (class, sequence, pseudocode) trước khi code | `low-level-designer` |
| Thiết kế endpoint REST/GraphQL mới, nhất quán với convention hiện có | `api-designer` |
| Thiết kế mới mô hình dữ liệu/ERD trước khi có migration | `data-modeler` |
| Review migration/schema database đã viết ra trước khi áp dụng | `db-schema-reviewer` |
| Đặc tả wireframe/luồng màn hình trước khi code UI | `ui-ux-designer` |
| Threat modeling (STRIDE) cho kiến trúc/luồng nghiệp vụ sắp xây, trước khi có code | `threat-modeler` |
| Ghi lại một quyết định kiến trúc đã chốt thành ADR | `adr-writer` |
| Soạn Test Plan (phạm vi, cấp độ, tiêu chí vào/ra) trước khi viết test case thật | `test-plan-writer` |
| Đánh giá kết quả PoC/spike kỹ thuật đã thực hiện, viết PoC Report go/no-go | `poc-evaluator` |
| Ước lượng effort kỹ thuật (person-day, best/likely/worst) dựa trên thiết kế và lịch sử commit | `project-estimator` |
| Dựng WBS phân cấp chi tiết từ effort đã ước lượng | `wbs-writer` |

---

## 4. Implementation (Coding)

**Mục tiêu:** Viết code đúng với thiết kế, đúng chuẩn, dễ bảo trì.

**Hoạt động chính:**
- Viết code theo coding convention của dự án.
- Viết unit test đi kèm (TDD hoặc viết ngay sau khi code).
- Review code trước khi merge (code review).
- Refactor khi phát hiện code trùng lặp, quá phức tạp, hoặc vi phạm nguyên tắc
  thiết kế.
- Quản lý dependency bên thứ ba: cập nhật, kiểm tra lỗ hổng.

**Đầu ra:** Code đã merge vào nhánh chính, có test đi kèm, đã qua review.

**Skill điều phối:** `/developer:implementation` (phản hồi nhanh trong lúc
code) — khi đã xong và sắp merge, dùng `/developer:pre-merge` làm cổng kiểm
tra cuối (tổng hợp PASS/WARN/FAIL nghiêm ngặt hơn).

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Review commit/diff Android (Kotlin/Java/Compose) | `android-commit-reviewer` |
| Review commit/diff Qt/C++ | `qt-cpp-commit-reviewer` |
| Review code Python theo PEP8 + bảo mật OWASP | `python-pep8-security-reviewer` |
| Đánh giá kiến trúc code (coupling, layering, SOLID) | `architecture-reviewer` |
| Refactor an toàn, không đổi hành vi | `refactor-assistant` |
| Viết unit test cho code hiện có | `test-writer` |
| Rà soát package bên thứ ba: lỗi thời, CVE, license | `dependency-auditor` |
| Nâng cấp version package, xử lý breaking change | `dependency-upgrader` |
| Quét và ưu tiên hóa nợ kỹ thuật (TODO, code chết, API deprecated) | `tech-debt-tracker` |
| Sinh/cập nhật tài liệu API và docstring từ code | `api-doc-generator` |
| Viết commit message theo convention dự án | skill `/my-style:commit` |
| Viết mô tả Pull Request từ diff | `pr-description-writer` |

---

## 5. Verification & Testing

**Mục tiêu:** Phát hiện lỗi trước khi đến tay người dùng; xác nhận phần mềm
hoạt động đúng như kỳ vọng và đạt tiêu chí ra (exit criteria) của Test Plan.

**Các cấp độ kiểm thử:**
- **Unit test** — kiểm tra từng hàm/class riêng lẻ, mock hết dependency, chạy
  nhanh.
- **Integration/E2E test** — kiểm tra luồng nghiệp vụ thật qua nhiều thành
  phần (API, database, service khác).
- **Kiểm thử bảo mật** — rà soát injection, lỗi xác thực/phân quyền, rò rỉ
  secret.
- **Kiểm thử hiệu năng** — tìm bottleneck, N+1 query, memory leak.

**Đầu ra:** Báo cáo coverage, test suite tự động, danh sách lỗi đã/chưa sửa,
RTM cập nhật (nếu dự án có dùng).

**Skill điều phối:** `/developer:verification-testing`

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Viết/chạy integration hoặc E2E test cho một luồng nghiệp vụ | `e2e-test-runner` |
| Phân tích coverage, chỉ ra vùng code thiếu test cần ưu tiên | `test-coverage-analyzer` |
| Tìm nguyên nhân và sửa test lúc pass lúc fail (flaky test) | `flaky-test-detector` |
| Audit lỗ hổng bảo mật (injection, auth, rò rỉ secret, OWASP Top 10) | `security-auditor` |
| Profile hiệu năng: bottleneck, query chậm, N+1, memory leak | `performance-profiler` |
| Nối test case/kết quả test với ID yêu cầu trong RTM | `rtm-manager` |

---

## 6. Release & Deployment

**Mục tiêu:** Đưa phần mềm đã kiểm thử vào môi trường production một cách an
toàn, có thể lặp lại.

**Hoạt động chính:**
- Tổng hợp changelog cho bản phát hành.
- Đóng gói ứng dụng (container hóa, build artifact).
- Chuẩn bị hạ tầng (Infrastructure as Code).
- Chạy pipeline CI/CD: build → test → deploy.
- Kiểm tra cấu hình trước khi deploy (pre-flight check): env var, secret,
  health check, resource limit.
- Lập checklist go/no-go và kế hoạch rollback.

**Đầu ra:** Changelog, phần mềm đang chạy ở production, pipeline CI/CD ổn
định.

**Skill điều phối:** `/developer:release-deployment`

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Tổng hợp CHANGELOG từ lịch sử commit/PR giữa hai mốc release | `changelog-writer` |
| Tối ưu Dockerfile: kích thước image, cache layer, bảo mật | `docker-optimizer` |
| Review Terraform/K8s/Helm trước khi apply — IAM, network, secret | `iac-reviewer` |
| Chẩn đoán và sửa pipeline CI đang fail | `ci-fixer` |
| Kiểm tra cấu hình trước khi deploy (env var, health check, secret) | `deployment-validator` |
| Lập checklist go/no-go + kế hoạch rollback cho một lần release cụ thể | `release-manager` |

---

## 7. Operation & Maintenance

**Mục tiêu:** Giữ phần mềm chạy ổn định, phát hiện và xử lý sự cố nhanh, liên
tục cải thiện.

**Hoạt động chính:**
- Giám sát log và metric production.
- Điều tra sự cố (incident) khi có lỗi/crash xảy ra — ưu tiên tuyệt đối khi
  sự cố ĐANG DIỄN RA real-time.
- Vá lỗi, phát hành bản cập nhật (patch/hotfix), ghi nhận vào changelog.
- Dọn nợ kỹ thuật, nâng cấp dependency lỗi thời tích lũy theo thời gian.
- Hướng dẫn thành viên mới làm quen với codebase, giữ tài liệu luôn cập nhật.
- Định kỳ đối chiếu quality gate (ADR, coverage, security audit, changelog...).

**Đầu ra:** Hệ thống ổn định, sự cố được xử lý đúng nguyên nhân gốc, tài liệu
luôn cập nhật.

**Skill điều phối:** `/developer:operation-maintenance`

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Điều phối phản ứng khi sự cố production ĐANG DIỄN RA: severity, việc cần làm ngay, bằng chứng cần giữ | `incident-commander` |
| Phân tích pattern bất thường trên diện rộng log production | `log-analyzer` |
| Truy nguyên nguyên nhân gốc của một sự cố/stack trace cụ thể | `root-cause-analyzer` |
| Ghi nhận bản hotfix/patch vào CHANGELOG | `changelog-writer` |
| Quét và ưu tiên hóa nợ kỹ thuật tích lũy (TODO, code chết, API deprecated) | `tech-debt-tracker` |
| Nâng cấp version package/framework đã lỗi thời hoặc có CVE | `dependency-upgrader` |
| Giải thích tổng quan codebase/kiến trúc cho người mới | `onboarding-guide` |
| Review chất lượng tài liệu Markdown/README | `docs-reviewer` |
| Viết mới/cập nhật README, hướng dẫn cài đặt, tài liệu nội bộ | `doc-writer` |
| Đối chiếu quality gate định kỳ (ADR, test coverage, security audit, changelog...) | `qms-compliance-checker` |

---

## Hoạt động xuyên suốt toàn bộ quy trình

Một số hoạt động không thuộc riêng một giai đoạn nào mà chạy xuyên suốt:

- **Quản lý phiên bản (version control):** mọi thay đổi đi qua Git, có commit
  message rõ ràng, nhánh làm việc tách biệt khỏi nhánh chính.
- **Code review:** mọi thay đổi code đều được review trước khi merge — không
  phải một giai đoạn riêng mà là một "cổng chất lượng" lặp lại ở mỗi lần thay
  đổi.
- **Tự động hóa (CI/CD):** build, test, lint, scan bảo mật chạy tự động mỗi
  khi có commit/PR mới, giảm phụ thuộc vào việc nhớ thực hiện thủ công.
- **Quản lý tài liệu:** ADR, API doc, changelog, README được cập nhật đồng
  thời với code, không để "nợ tài liệu" tích lũy.
- **Bảo mật (security by design):** rà soát bảo mật không chỉ ở cuối mà lồng
  vào từ giai đoạn thiết kế (threat modeling — `threat-modeler`) đến phát
  triển (secure coding) và vận hành (giám sát).
- **Quality gate / đối chiếu quy trình (kiểu CMMI):** định kỳ đối chiếu một
  dự án/tính năng với checklist hồ sơ bắt buộc theo từng giai đoạn (ADR, test
  coverage, security audit, changelog...) bằng `qms-compliance-checker`, để
  phát hiện sớm cổng chất lượng nào đang bị bỏ qua — tương tự vai trò khối
  Quality Management độc lập tại các tổ chức đạt CMMI Level 5 như FSoft.
- **Tư vấn chọn agent:** khi không chắc nên dùng agent/skill nào cho một việc
  cụ thể, dùng `/developer:agent-advisor` — nó đọc trực tiếp danh sách agent
  đã đăng ký và ranh giới từng agent, luôn đúng với hiện trạng repo.

---

## Skill điều phối theo giai đoạn

Mỗi skill dưới đây tự chọn đúng agent cần dùng cho giai đoạn tương ứng (không
chạy cho đủ bộ) và gợi ý skill của giai đoạn kế tiếp:

| Giai đoạn | Skill |
|---|---|
| 1. Discovery & Planning | `/developer:discovery-planning` |
| 2. Requirements Analysis | `/developer:requirements-analysis` |
| 3. Architecture & Design | `/developer:architecture-design` |
| 4. Implementation | `/developer:implementation` |
| 5. Verification & Testing | `/developer:verification-testing` |
| 6. Release & Deployment | `/developer:release-deployment` |
| 7. Operation & Maintenance | `/developer:operation-maintenance` |
| Xuyên suốt — commit | `/my-style:commit` |
| Xuyên suốt — cổng kiểm tra trước merge | `/developer:pre-merge` |
| Xuyên suốt — tư vấn chọn agent | `/developer:agent-advisor` |

---

## Tóm tắt nhanh — chọn công cụ theo tình huống

| Tôi đang... | Nên dùng |
|---|---|
| Có một ý tưởng còn rất mơ hồ, chưa biết bắt đầu từ đâu | `/developer:discovery-planning` |
| Ý tưởng đã rõ, cần đặc tả thành SRS chính thức | `/developer:requirements-analysis` |
| Lên kế hoạch cho một tính năng lớn chưa có | `system-architect` (hoặc `/developer:architecture-design`) |
| Đang code, cần một vòng kiểm tra nhanh | `/developer:implementation` |
| Chuẩn bị merge một PR | `/developer:pre-merge` |
| Code chạy chậm hoặc nghi ngờ leak | `performance-profiler` |
| Nghi ngờ lỗ hổng bảo mật trong code đã viết | `security-auditor` |
| Cần soát rủi ro bảo mật TRƯỚC khi code, ở bước thiết kế | `threat-modeler` |
| Cần số effort cụ thể (person-day) cho yêu cầu đã rõ | `project-estimator` |
| Chuẩn bị release | `/developer:release-deployment` (`changelog-writer` → `release-manager` → `deployment-validator`) |
| Production đang down/lỗi NGAY BÂY GIỜ, cần quyết định ngay | `incident-commander` (hoặc `/developer:operation-maintenance`) |
| Production đã ổn định, cần tìm nguyên nhân gốc | `log-analyzer` → `root-cause-analyzer` |
| Codebase có nhiều nợ kỹ thuật không biết bắt đầu từ đâu | `tech-debt-tracker` |
| Thành viên mới cần hiểu dự án | `onboarding-guide` |
| Yêu cầu nghiệp vụ còn mơ hồ, cần user story + acceptance criteria rõ ràng | `requirements-analyst` |
| Cần kiểm tra một tính năng đã đủ hồ sơ theo quy trình chất lượng chưa | `qms-compliance-checker` |
| Không chắc nên dùng agent nào | `/developer:agent-advisor` |
