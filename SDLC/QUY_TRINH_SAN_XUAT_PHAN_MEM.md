# Quy trình sản xuất phần mềm (SDLC)

Tài liệu này mô tả quy trình sản xuất phần mềm theo 6 giai đoạn chuẩn, kèm theo
các hoạt động chất lượng xuyên suốt. Ở mỗi giai đoạn, tài liệu chỉ ra agent
tương ứng trong bộ `dev-quality-toolkit` (plugin `developer`) có thể hỗ trợ,
để nhóm vừa hiểu quy trình, vừa biết dùng công cụ nào vào lúc nào.

Tài liệu gồm 3 phần: (A) các mô hình SDLC chuẩn phổ biến trên thế giới, (B)
quy trình sản xuất phần mềm thực tế tại FPT Software (FSoft) — một trong các
công ty đạt CMMI Level 5, và (C) quy trình 6 giai đoạn kèm agent hỗ trợ trong
toolkit này. Xem thêm file [`SO_SANH_SDLC_THE_GIOI_FSOFT.md`](./SO_SANH_SDLC_THE_GIOI_FSOFT.md)
để so sánh trực tiếp hai quy trình, và file
[`QUY_TRINH_CHI_TIET.md`](./QUY_TRINH_CHI_TIET.md) cho bản đặc tả chi tiết
từng giai đoạn (vai trò/RACI, điều kiện vào/ra, quality gate, template,
checklist).

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

## Phần C — Quy trình 6 giai đoạn & Agent hỗ trợ trong dev-quality-toolkit

Phần dưới đây áp dụng bộ khung 6 giai đoạn chuẩn (tương thích với cả mô hình
thế giới ở Phần A và thực tế FSoft ở Phần B) vào bộ agent cụ thể có sẵn trong
`dev-quality-toolkit`, để nhóm biết dùng agent nào ở bước nào.

## Tổng quan

```
1. Thu thập & Phân tích yêu cầu
        │
        ▼
2. Thiết kế (kiến trúc, API, dữ liệu)
        │
        ▼
3. Phát triển (coding)  ──────┐
        │                     │  (lặp lại trong mỗi sprint/iteration)
        ▼                     │
4. Kiểm thử (testing)  ───────┘
        │
        ▼
5. Triển khai (deployment)
        │
        ▼
6. Vận hành & Bảo trì (operations & maintenance)
```

Phần mềm hiện đại hiếm khi đi qua 6 giai đoạn này một lần rồi kết thúc. Thực tế
đây là một vòng lặp: mỗi tính năng mới, mỗi bản sửa lỗi đều đi qua lại từ bước 2
đến bước 6, với tốc độ nhanh dần nhờ CI/CD và tự động hóa kiểm thử.

---

## 1. Thu thập & Phân tích yêu cầu

**Mục tiêu:** Hiểu rõ bài toán cần giải quyết trước khi viết bất kỳ dòng code
nào.

**Hoạt động chính:**
- Làm rõ yêu cầu nghiệp vụ với người dùng/khách hàng/stakeholder.
- Viết user story, use case, hoặc đặc tả chức năng.
- Xác định ràng buộc: hiệu năng, bảo mật, tuân thủ pháp lý, ngân sách, thời hạn.
- Ước lượng quy mô công việc, chia nhỏ thành các phần có thể triển khai độc lập.

**Đầu ra:** Tài liệu yêu cầu (PRD/spec), danh sách user story đã ưu tiên hóa.

**Sai lầm thường gặp:** Bỏ qua giai đoạn này hoặc làm quá sơ sài dẫn đến việc
phải làm lại (rework) ở các giai đoạn sau — đây là nguyên nhân tốn kém nhất
trong toàn bộ quy trình.

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Làm rõ yêu cầu nghiệp vụ còn mơ hồ thành user story + acceptance criteria, ước lượng quy mô thô và đề xuất chia nhỏ | `requirements-analyst` |

---

## 2. Thiết kế

**Mục tiêu:** Chuyển yêu cầu thành bản thiết kế kỹ thuật — kiến trúc hệ thống,
API, mô hình dữ liệu — trước khi code.

**Hoạt động chính:**
- Thiết kế kiến trúc tổng thể: chọn công nghệ, phân tách module/service, luồng
  dữ liệu.
- Thiết kế API (REST/GraphQL): resource, method, request/response, mã lỗi.
- Thiết kế schema cơ sở dữ liệu: bảng, index, ràng buộc, chuẩn hóa dữ liệu.
- Ghi lại các quyết định kiến trúc quan trọng (ADR) để sau này không phải
  tranh luận lại từ đầu.

**Đầu ra:** Sơ đồ kiến trúc, đặc tả API, migration/schema, các ADR.

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Lập kế hoạch kiến trúc cho tính năng/hệ thống lớn, so sánh trade-off | `system-architect` |
| Tài liệu hóa HLD chính thức sau khi phương án kiến trúc đã chốt | `high-level-designer` |
| Chi tiết hóa HLD thành LLD (class, sequence, pseudocode) trước khi code | `low-level-designer` |
| Thiết kế endpoint REST/GraphQL mới, nhất quán với convention hiện có | `api-designer` |
| Review migration/schema database trước khi áp dụng | `db-schema-reviewer` |
| Ghi lại một quyết định kiến trúc đã chốt thành ADR | `adr-writer` |
| Threat modeling (STRIDE) cho kiến trúc/luồng nghiệp vụ sắp xây, trước khi có code | `threat-modeler` |
| Ước lượng effort kỹ thuật (person-day, best/likely/worst) cho yêu cầu đã rõ, dựa trên lịch sử commit | `project-estimator` |

---

## 3. Phát triển (Coding)

**Mục tiêu:** Viết code đúng với thiết kế, đúng chuẩn, dễ bảo trì.

**Hoạt động chính:**
- Viết code theo coding convention của dự án.
- Viết unit test đi kèm (TDD hoặc viết ngay sau khi code).
- Review code trước khi merge (code review).
- Refactor khi phát hiện code trùng lặp, quá phức tạp, hoặc vi phạm nguyên tắc
  thiết kế.
- Quản lý dependency bên thứ ba: cập nhật, kiểm tra lỗ hổng.

**Đầu ra:** Code đã merge vào nhánh chính, có test đi kèm, đã qua review.

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
| Viết commit message theo convention dự án | skill `/developer:commit` |
| Viết mô tả Pull Request từ diff | `pr-description-writer` |

---

## 4. Kiểm thử (Testing)

**Mục tiêu:** Phát hiện lỗi trước khi đến tay người dùng; xác nhận phần mềm
hoạt động đúng như kỳ vọng.

**Các cấp độ kiểm thử:**
- **Unit test** — kiểm tra từng hàm/class riêng lẻ, mock hết dependency, chạy
  nhanh.
- **Integration/E2E test** — kiểm tra luồng nghiệp vụ thật qua nhiều thành
  phần (API, database, service khác).
- **Kiểm thử bảo mật** — rà soát injection, lỗi xác thực/phân quyền, rò rỉ
  secret.
- **Kiểm thử hiệu năng** — tìm bottleneck, N+1 query, memory leak.

**Đầu ra:** Báo cáo coverage, test suite tự động, danh sách lỗi đã/chưa sửa.

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Viết/chạy integration hoặc E2E test cho một luồng nghiệp vụ | `e2e-test-runner` |
| Phân tích coverage, chỉ ra vùng code thiếu test cần ưu tiên | `test-coverage-analyzer` |
| Tìm nguyên nhân và sửa test lúc pass lúc fail (flaky test) | `flaky-test-detector` |
| Audit lỗ hổng bảo mật (injection, auth, rò rỉ secret, OWASP Top 10) | `security-auditor` |
| Profile hiệu năng: bottleneck, query chậm, N+1, memory leak | `performance-profiler` |

---

## 5. Triển khai (Deployment)

**Mục tiêu:** Đưa phần mềm đã kiểm thử vào môi trường production một cách an
toàn, có thể lặp lại.

**Hoạt động chính:**
- Đóng gói ứng dụng (container hóa, build artifact).
- Chuẩn bị hạ tầng (Infrastructure as Code).
- Chạy pipeline CI/CD: build → test → deploy.
- Kiểm tra cấu hình trước khi deploy (pre-flight check): env var, secret,
  health check, resource limit.

**Đầu ra:** Phần mềm đang chạy ở production, pipeline CI/CD ổn định.

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Tối ưu Dockerfile: kích thước image, cache layer, bảo mật | `docker-optimizer` |
| Review Terraform/K8s/Helm trước khi apply — IAM, network, secret | `iac-reviewer` |
| Chẩn đoán và sửa pipeline CI đang fail | `ci-fixer` |
| Kiểm tra cấu hình trước khi deploy (env var, health check, secret) | `deployment-validator` |
| Lập checklist go/no-go + kế hoạch rollback cho một lần release cụ thể | `release-manager` |

---

## 6. Vận hành & Bảo trì (Operations & Maintenance)

**Mục tiêu:** Giữ phần mềm chạy ổn định, phát hiện và xử lý sự cố nhanh, liên
tục cải thiện.

**Hoạt động chính:**
- Giám sát log và metric production.
- Điều tra sự cố (incident) khi có lỗi/crash xảy ra.
- Vá lỗi, phát hành bản cập nhật (patch/hotfix).
- Tổng hợp changelog cho mỗi lần phát hành.
- Hướng dẫn thành viên mới làm quen với codebase.

**Đầu ra:** Hệ thống ổn định, sự cố được xử lý đúng nguyên nhân gốc, tài liệu
luôn cập nhật.

**Agent hỗ trợ trong toolkit:**
| Việc cần làm | Agent |
|---|---|
| Điều phối phản ứng khi sự cố production ĐANG DIỄN RA: severity, việc cần làm ngay, bằng chứng cần giữ | `incident-commander` |
| Phân tích pattern bất thường trên diện rộng log production | `log-analyzer` |
| Truy nguyên nguyên nhân gốc của một sự cố/stack trace cụ thể | `root-cause-analyzer` |
| Tổng hợp CHANGELOG từ lịch sử commit/PR giữa hai mốc release | `changelog-writer` |
| Giải thích tổng quan codebase/kiến trúc cho người mới | `onboarding-guide` |
| Review chất lượng tài liệu Markdown/README | `docs-reviewer` |
| Viết mới/cập nhật README, hướng dẫn cài đặt, tài liệu nội bộ | `doc-writer` |

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

---

## Tóm tắt nhanh — chọn công cụ theo tình huống

| Tôi đang... | Nên dùng |
|---|---|
| Lên kế hoạch cho một tính năng lớn chưa có | `system-architect` |
| Chuẩn bị merge một PR | agent review theo stack + `pr-description-writer` |
| Code chạy chậm hoặc nghi ngờ leak | `performance-profiler` |
| Nghi ngờ lỗ hổng bảo mật trong code đã viết | `security-auditor` |
| Cần soát rủi ro bảo mật TRƯỚC khi code, ở bước thiết kế | `threat-modeler` |
| Cần số effort cụ thể (person-day) cho yêu cầu đã rõ | `project-estimator` |
| Chuẩn bị release | `changelog-writer` → `release-manager` → `deployment-validator` |
| Production đang down/lỗi NGAY BÂY GIỜ, cần quyết định ngay | `incident-commander` |
| Production đã ổn định, cần tìm nguyên nhân gốc | `log-analyzer` → `root-cause-analyzer` |
| Codebase có nhiều nợ kỹ thuật không biết bắt đầu từ đâu | `tech-debt-tracker` |
| Thành viên mới cần hiểu dự án | `onboarding-guide` |
| Yêu cầu nghiệp vụ còn mơ hồ, cần user story + acceptance criteria rõ ràng | `requirements-analyst` |
| Cần kiểm tra một tính năng đã đủ hồ sơ theo quy trình chất lượng chưa | `qms-compliance-checker` |
