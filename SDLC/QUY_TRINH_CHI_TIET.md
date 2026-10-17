# Quy trình sản xuất phần mềm — Đặc tả chi tiết

Tài liệu này là **bản đặc tả chi tiết, có thể áp dụng trực tiếp** của quy
trình sản xuất phần mềm. Nếu
[`QUY_TRINH_SAN_XUAT_PHAN_MEM.md`](./QUY_TRINH_SAN_XUAT_PHAN_MEM.md) trả lời
câu hỏi *"quy trình gồm những giai đoạn nào?"*, thì tài liệu này trả lời
*"ở mỗi giai đoạn, ai làm gì, theo thứ tự nào, cần đầu vào gì, phải ra được
sản phẩm gì, và khi nào thì được coi là xong để chuyển sang bước tiếp theo?"*.

**Tài liệu liên quan:**

| Tài liệu | Dùng để |
|---|---|
| [`QUY_TRINH_SAN_XUAT_PHAN_MEM.md`](./QUY_TRINH_SAN_XUAT_PHAN_MEM.md) | Tổng quan mô hình SDLC thế giới, FSoft, và 7 giai đoạn |
| [`SO_SANH_SDLC_THE_GIOI_FSOFT.md`](./SO_SANH_SDLC_THE_GIOI_FSOFT.md) | So sánh SDLC chuẩn thế giới với quy trình FSoft |
| [`THUAT_NGU_SDLC.md`](./THUAT_NGU_SDLC.md) | Tra cứu thuật ngữ, từ viết tắt (SRS, WBS, RTM, UAT...) |
| [`DANH_SACH_AI_AGENT_VA_VI_DU_PROMPT.md`](./DANH_SACH_AI_AGENT_VA_VI_DU_PROMPT.md) | Danh sách agent và prompt mẫu |

---

## Mục lục

- [Phần I — Nguyên tắc chung](#phần-i--nguyên-tắc-chung)
  - [1. Phạm vi và cách đọc tài liệu](#1-phạm-vi-và-cách-đọc-tài-liệu)
  - [2. Vai trò và trách nhiệm](#2-vai-trò-và-trách-nhiệm)
  - [3. Sơ đồ quy trình và các cổng chất lượng](#3-sơ-đồ-quy-trình-và-các-cổng-chất-lượng)
- [Phần II — Các giai đoạn chi tiết](#phần-ii--các-giai-đoạn-chi-tiết)
  - [Giai đoạn 1 — Discovery & Planning (Khởi tạo & lập kế hoạch dự án)](#giai-đoạn-1--discovery--planning-khởi-tạo--lập-kế-hoạch-dự-án)
  - [Giai đoạn 2 — Requirements Analysis (Thu thập & phân tích yêu cầu)](#giai-đoạn-2--requirements-analysis-thu-thập--phân-tích-yêu-cầu)
  - [Giai đoạn 3 — Architecture & Design (Thiết kế)](#giai-đoạn-3--architecture--design-thiết-kế)
  - [Giai đoạn 4 — Implementation (Phát triển)](#giai-đoạn-4--implementation-phát-triển)
  - [Giai đoạn 5 — Verification & Testing (Kiểm thử)](#giai-đoạn-5--verification--testing-kiểm-thử)
  - [Giai đoạn 6 — Release & Deployment (Phát hành & triển khai)](#giai-đoạn-6--release--deployment-phát-hành--triển-khai)
  - [Giai đoạn 7 — Operation & Maintenance (Vận hành & bảo trì)](#giai-đoạn-7--operation--maintenance-vận-hành--bảo-trì)
  - [Phụ lục — Đóng dự án (ngoài khung 7 giai đoạn)](#phụ-lục--đóng-dự-án-ngoài-khung-7-giai-đoạn)
- [Phần III — Các quy trình hỗ trợ xuyên suốt](#phần-iii--các-quy-trình-hỗ-trợ-xuyên-suốt)
- [Phần IV — Áp dụng theo mô hình dự án](#phần-iv--áp-dụng-theo-mô-hình-dự-án)
- [Phần V — Danh mục tài liệu, template và checklist](#phần-v--danh-mục-tài-liệu-template-và-checklist)

> **Lưu ý về đánh số:** tài liệu này dùng khung **7 giai đoạn** (đồng bộ với
> [`QUY_TRINH_SAN_XUAT_PHAN_MEM.md`](./QUY_TRINH_SAN_XUAT_PHAN_MEM.md)), cộng
> thêm một mục Phụ lục "Đóng dự án" cho dự án có mốc kết thúc rõ ràng (fix-
> price/outsourcing) — mục này nằm ngoài vòng lặp 7 giai đoạn lặp lại theo
> từng tính năng/release. Mã **gate (G0–G7)** giữ nguyên như bản gốc và
> KHÔNG đổi theo số giai đoạn mới (ví dụ G0 vẫn là gate cuối giai đoạn 1 mới,
> G7 vẫn là gate của Phụ lục) — tra `Giai đoạn N` theo tên mới, tra `Gate GN`
> theo đúng ký hiệu đã dùng trong toàn tài liệu.

---

# Phần I — Nguyên tắc chung

## 1. Phạm vi và cách đọc tài liệu

### 1.1. Phạm vi áp dụng

- Áp dụng cho mọi dự án phát triển phần mềm mới, phát triển thêm tính năng
  (enhancement) và bảo trì (maintenance).
- Áp dụng được cho cả mô hình **V-Model/Waterfall** (dự án fix-price, cần
  tài liệu đầy đủ) lẫn **Agile/Scrum** (dự án sản phẩm, scope linh hoạt).
  Cách điều chỉnh cho từng mô hình nằm ở [Phần IV](#phần-iv--áp-dụng-theo-mô-hình-dự-án).
- Dự án nhỏ được phép **cắt giảm (tailoring)** theo quy tắc ở
  [mục 17](#17-tailoring--điều-chỉnh-quy-trình-theo-quy-mô); mọi cắt giảm
  phải được ghi lại trong Kế hoạch dự án.

### 1.2. Khung mô tả mỗi giai đoạn (ETVX)

Mỗi giai đoạn trong Phần II được mô tả theo khung **ETVX**, khung phổ biến
khi định nghĩa quy trình ở các tổ chức theo CMMI:

| Thành phần | Ý nghĩa | Câu hỏi trả lời |
|---|---|---|
| **E — Entry criteria** | Điều kiện vào | Cần có gì mới được bắt đầu? |
| **T — Tasks** | Các bước công việc | Làm gì, ai làm, theo thứ tự nào? |
| **V — Verification** | Kiểm tra/review | Làm sao biết làm đúng? |
| **X — Exit criteria** | Điều kiện ra | Khi nào được coi là xong? |

Ngoài ra mỗi giai đoạn có thêm: **Mục tiêu**, **Đầu ra (artifact)**, **Chỉ
số đo lường**, **Rủi ro thường gặp**, và **Agent hỗ trợ** trong toolkit.

### 1.3. Nguyên tắc cốt lõi

1. **Không có gì "xong" khi chưa được review.** Mọi sản phẩm (tài liệu, code,
   test case, cấu hình) đều phải qua ít nhất một lượt review trước khi được
   baseline hoặc merge.
2. **Phát hiện lỗi càng sớm càng rẻ.** Lỗi yêu cầu phát hiện ở production có
   thể tốn chi phí sửa gấp nhiều lần so với phát hiện ngay lúc review yêu cầu.
   Vì vậy quy trình đặt nhiều điểm review ở giai đoạn đầu.
3. **Truy xuất được (traceability).** Mỗi yêu cầu phải truy được tới thiết
   kế, code, test case và kết quả test tương ứng (qua RTM).
4. **Thay đổi có kiểm soát.** Sau khi baseline, mọi thay đổi phải đi qua quy
   trình Change Request ([mục 10](#10-quản-lý-thay-đổi-change-management)).
5. **Quyết định dựa trên dữ liệu.** Ước lượng, lập kế hoạch và đánh giá chất
   lượng dựa trên số liệu đo được (effort thực tế, defect density...),
   không dựa trên cảm tính.
6. **Tự động hóa những gì lặp lại.** Build, test, lint, scan bảo mật,
   deploy phải chạy tự động qua CI/CD, không phụ thuộc vào trí nhớ của người.

---

## 2. Vai trò và trách nhiệm

### 2.1. Danh sách vai trò

Một người có thể kiêm nhiều vai trò ở dự án nhỏ, nhưng **người review không
được trùng với người tạo ra sản phẩm** được review.

| Vai trò | Viết tắt | Trách nhiệm chính |
|---|---|---|
| Khách hàng / Stakeholder | KH | Cung cấp yêu cầu, phê duyệt phạm vi, nghiệm thu (UAT) |
| Product Owner | PO | (Agile) Sở hữu và ưu tiên Product Backlog, đại diện tiếng nói khách hàng |
| Project Manager | PM | Lập kế hoạch, theo dõi tiến độ/chi phí/rủi ro, điều phối nguồn lực, báo cáo |
| Business Analyst | BA | Thu thập, phân tích, đặc tả yêu cầu; quản lý RTM; làm cầu nối KH–team |
| Solution/System Architect | SA | Thiết kế kiến trúc tổng thể (HLD), chọn công nghệ, quyết định kỹ thuật lớn |
| Technical Lead | TL | Thiết kế chi tiết (LLD), dẫn dắt kỹ thuật cho team Dev, review code, đảm bảo coding standard |
| Developer | DEV | Viết code, unit test, sửa lỗi, tham gia review chéo |
| Test Lead | TLE | Lập Test Plan, quản lý hoạt động kiểm thử, báo cáo chất lượng |
| Tester / QC | QC | Thiết kế test case, thực thi test, ghi nhận và theo dõi defect |
| DevOps / Release Engineer | OPS | Hạ tầng, CI/CD, môi trường, đóng gói và triển khai |
| Quality Assurance (quy trình) | SQA | Độc lập với team dự án: audit tuân thủ quy trình, kiểm tra quality gate, thu thập số liệu |
| Configuration Manager | CM | Quản lý repository, branching, baseline, version (thường do TL/OPS kiêm) |
| Support / Operation | SUP | Vận hành production, tiếp nhận sự cố, hỗ trợ người dùng sau go-live |

> **Lưu ý QA vs QC:** trong tài liệu này, **SQA** là vai trò đảm bảo
> *quy trình* (phòng ngừa), còn **QC/Tester** là vai trò kiểm tra *sản phẩm*
> (phát hiện). Xem [`THUAT_NGU_SDLC.md`](./THUAT_NGU_SDLC.md#qa-vs-qc--quality-assurance-vs-quality-control).

### 2.2. Ma trận RACI theo giai đoạn

**R** = Responsible (người thực hiện), **A** = Accountable (người chịu trách
nhiệm cuối, phê duyệt — mỗi dòng chỉ có một A), **C** = Consulted (được hỏi ý
kiến), **I** = Informed (được thông báo).

| Hoạt động | KH | PM | BA | SA | TL | DEV | TLE/QC | OPS | SQA |
|---|---|---|---|---|---|---|---|---|---|
| Kế hoạch dự án | C | **A/R** | C | C | C | I | C | C | C |
| Đặc tả yêu cầu (SRS) | C | I | **A/R** | C | C | I | C | I | I |
| Phê duyệt yêu cầu | **A** | R | R | I | I | I | I | I | I |
| Thiết kế kiến trúc (HLD) | I | I | C | **A/R** | C | I | I | C | I |
| Thiết kế chi tiết (LLD) | — | I | C | C | **A/R** | R | I | I | I |
| Kế hoạch kiểm thử | I | C | C | I | C | I | **A/R** | C | I |
| Lập trình & unit test | — | I | I | C | **A** | R | I | I | — |
| Code review | — | — | — | C | **A/R** | R | — | — | — |
| Kiểm thử hệ thống (SIT) | I | I | C | I | C | C | **A/R** | C | I |
| UAT | **A/R** | R | R | I | I | C | C | I | I |
| Phát hành & triển khai | I | **A** | I | C | C | C | C | R | I |
| Xử lý sự cố production | I | **A** | I | C | R | R | C | R | I |
| Audit quy trình / quality gate | I | C | C | C | C | I | C | I | **A/R** |
| Đóng dự án & bài học kinh nghiệm | C | **A/R** | R | R | R | R | R | R | C |

---

## 3. Sơ đồ quy trình và các cổng chất lượng

### 3.1. Sơ đồ tổng thể

```
 ┌───────────────────────────┐
 │ 1. Discovery & Planning    │──[G0: Phê duyệt khởi động dự án]
 └─────────────┬──────────────┘
               ▼
 ┌───────────────────────────┐
 │ 2. Requirements Analysis   │──[G1: Baseline yêu cầu (SRS/Backlog)]
 └─────────────┬──────────────┘
               ▼
 ┌───────────────────────────┐
 │ 3. Architecture & Design   │──[G2: Baseline thiết kế]
 │    (HLD→LLD)                │
 └─────────────┬──────────────┘
               ▼
 ┌───────────────────────────┐  ◄── lặp theo sprint/iteration ──┐
 │ 4. Implementation           │──[G3: Code complete]              │
 └─────────────┬──────────────┘                                    │
               ▼                                                  │
 ┌───────────────────────────┐                                    │
 │ 5. Verification & Testing  │──[G4: Test exit / sẵn sàng UAT] ───┘
 └─────────────┬──────────────┘
               ▼
 ┌───────────────────────────┐
 │ 6. Release & Deployment    │──[G5: Go/No-go]──[G6: Go-live xác nhận]
 │    (gồm UAT)                │
 └─────────────┬──────────────┘
               ▼
 ┌───────────────────────────┐
 │ 7. Operation & Maintenance │──► yêu cầu mới / bug ──► quay lại giai đoạn 2 hoặc 4
 └─────────────┬──────────────┘
               ▼
 ┌───────────────────────────┐
 │ Phụ lục. Đóng dự án         │──[G7: Nghiệm thu & đóng dự án]
 └───────────────────────────┘

 Xuyên suốt: Quản lý dự án · Quản lý cấu hình · Quản lý thay đổi ·
             Quản lý rủi ro · Quản lý defect · Review · Đo lường · Audit SQA
```

### 3.2. Các cổng chất lượng (quality gate)

Mỗi gate là một **điểm quyết định chính thức**: chỉ đi tiếp khi tất cả tiêu
chí đạt, hoặc khi người có thẩm quyền chấp nhận rủi ro **bằng văn bản** (ghi
rõ tiêu chí nào chưa đạt, lý do, kế hoạch khắc phục).

| Gate | Thời điểm | Người phê duyệt | Tiêu chí chính | Agent/skill hỗ trợ kiểm tra |
|---|---|---|---|---|
| **G0** | Cuối giai đoạn 1 (Discovery & Planning) | Ban lãnh đạo / Sponsor | Có hợp đồng/SOW, kế hoạch dự án, nguồn lực, rủi ro ban đầu | `/developer:discovery-planning` |
| **G1** | Cuối giai đoạn 2 (Requirements Analysis) | KH + PM | SRS/Backlog đã review, KH ký duyệt, RTM khởi tạo | `requirements-analyst`, `/developer:requirements-analysis` |
| **G2** | Cuối giai đoạn 3 (Architecture & Design) | SA + PM (+ KH nếu hợp đồng yêu cầu) | HLD/LLD đã review, ADR cho quyết định lớn, threat model, Test Plan | `qms-compliance-checker`, `threat-modeler`, `/developer:architecture-design` |
| **G3** | Cuối giai đoạn 4 (Implementation) | TL | Code đã review và merge, unit test đạt ngưỡng, CI xanh | các reviewer theo stack, `test-coverage-analyzer`, `/developer:pre-merge` |
| **G4** | Cuối giai đoạn 5 (Verification & Testing) | Test Lead + PM | Test case đã chạy đủ, không còn defect Critical/High mở, báo cáo test | `qms-compliance-checker`, `/developer:verification-testing` |
| **G5** | Trước triển khai production (trong giai đoạn 6) | PM (+ KH) | UAT đạt, release note, kế hoạch rollback, pre-flight check đạt | `release-manager`, `deployment-validator`, `/developer:release-deployment` |
| **G6** | Sau triển khai (chuyển sang giai đoạn 7) | PM + OPS | Smoke test production đạt, monitoring bình thường trong thời gian theo dõi | `log-analyzer`, `/developer:operation-maintenance` |
| **G7** | Kết thúc dự án (Phụ lục — Đóng dự án) | Sponsor + KH | Biên bản nghiệm thu, bàn giao đủ tài liệu, báo cáo đóng dự án | `qms-compliance-checker` |

---

# Phần II — Các giai đoạn chi tiết

## Giai đoạn 1 — Discovery & Planning (Khởi tạo & lập kế hoạch dự án)

**Mục tiêu:** Xác định dự án có nên làm không, làm trong phạm vi nào, với
nguồn lực/ngân sách/thời gian nào, và cách quản lý ra sao.

**Skill điều phối:** `/developer:discovery-planning`

### E — Điều kiện vào
- Có đề nghị/yêu cầu dự án từ khách hàng hoặc nội bộ (RFP, ý tưởng sản
  phẩm, đơn đặt hàng).
- Có người được giao vai trò PM (hoặc người phụ trách khởi tạo).

### T — Các bước công việc

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 0.1 | Phân tích khả thi | PM, SA, BA | Đánh giá khả thi kỹ thuật (có cần PoC?), khả thi nguồn lực, khả thi tài chính |
| 0.2 | Ước lượng sơ bộ | PM, SA | Ước lượng quy mô thô (top-down hoặc theo dự án tương tự), ra khoảng chi phí/thời gian |
| 0.3 | Chốt hợp đồng / SOW | PM, KH | Thống nhất phạm vi, deliverable, mốc thời gian, điều kiện nghiệm thu, SLA (nếu có) |
| 0.4 | Chọn mô hình quy trình | PM, SQA | V-Model hay Agile hay kết hợp; tailoring quy trình theo quy mô ([mục 17](#17-tailoring--điều-chỉnh-quy-trình-theo-quy-mô)) |
| 0.5 | Lập WBS và lịch | PM, TL | Phân rã công việc, ước lượng chi tiết, lập lịch, xác định milestone |
| 0.6 | Lập Kế hoạch dự án | PM | Tổng hợp tài liệu Project Plan (xem cấu trúc bên dưới) |
| 0.7 | Lập kế hoạch quản lý cấu hình | CM | Repository, branching strategy, quy tắc đặt version, danh sách configuration item |
| 0.8 | Nhận diện rủi ro ban đầu | PM, cả team | Lập Risk Register với xác suất, tác động, biện pháp |
| 0.9 | Chuẩn bị môi trường | OPS | Repository, CI cơ bản, công cụ quản lý task/defect, môi trường dev |
| 0.10 | Kick-off | PM | Họp khởi động nội bộ và với khách hàng: mục tiêu, phạm vi, vai trò, kênh liên lạc, lịch báo cáo |

**Cấu trúc Kế hoạch dự án (Project Plan) tối thiểu:**
1. Mục tiêu và phạm vi (trong phạm vi / ngoài phạm vi)
2. Deliverable và milestone
3. Mô hình quy trình và các tailoring đã áp dụng
4. Tổ chức dự án: vai trò, người phụ trách, RACI
5. Ước lượng (effort, quy mô) và lịch
6. Kế hoạch nguồn lực và đào tạo
7. Kế hoạch quản lý rủi ro
8. Kế hoạch quản lý cấu hình
9. Kế hoạch chất lượng: các gate, mục tiêu chất lượng (ví dụ defect density
   mục tiêu), lịch review/audit
10. Kế hoạch giao tiếp: họp định kỳ, báo cáo, kênh escalation
11. Môi trường và công cụ

### V — Kiểm tra
- SQA review Project Plan về tính đầy đủ so với quy trình.
- Senior management/Sponsor review ước lượng và rủi ro.

### X — Điều kiện ra (Gate G0)
- [ ] Hợp đồng/SOW đã ký hoặc quyết định khởi động nội bộ đã duyệt
- [ ] Project Plan đã review và phê duyệt (baseline v1.0)
- [ ] Đã phân công đủ vai trò chủ chốt (PM, BA, SA/TL, Test Lead)
- [ ] Risk Register đã khởi tạo
- [ ] Repository và công cụ quản lý dự án đã sẵn sàng
- [ ] Đã họp kick-off

### Đầu ra
SOW/hợp đồng, Project Plan, WBS, lịch dự án, Risk Register, Configuration
Management Plan, biên bản kick-off.

### Chỉ số đo lường
Effort ước lượng (person-day), số rủi ro ban đầu theo mức độ, ngày bắt đầu/kết
thúc dự kiến từng milestone (làm baseline để đo schedule variance về sau).

### Rủi ro thường gặp
- Ước lượng theo cảm tính, bị ép theo deadline thương mại → kế hoạch không
  khả thi ngay từ đầu.
- Phạm vi "ngoài phạm vi" không được ghi rõ → tranh chấp khi nghiệm thu.

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| Ước lượng effort kỹ thuật (best/likely/worst) cho phần việc đã rõ | `project-estimator` |
| Phân tích phương án kiến trúc khi cần đánh giá khả thi | `system-architect` |

---

## Giai đoạn 2 — Requirements Analysis (Thu thập & phân tích yêu cầu)

**Mục tiêu:** Hiểu đúng, đủ và thống nhất với khách hàng về việc hệ thống
**phải làm gì** (yêu cầu chức năng) và **phải đạt chất lượng thế nào** (yêu
cầu phi chức năng), trước khi thiết kế.

**Skill điều phối:** `/developer:requirements-analysis`

### E — Điều kiện vào
- Gate G0 đã qua.
- Đã xác định được stakeholder và người có thẩm quyền phê duyệt yêu cầu phía
  khách hàng.

### T — Các bước công việc

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 1.1 | Xác định stakeholder | BA, PM | Liệt kê ai dùng hệ thống, ai quyết định, ai bị ảnh hưởng; mức độ ảnh hưởng của từng người |
| 1.2 | Thu thập yêu cầu (elicitation) | BA | Phỏng vấn, workshop, khảo sát, quan sát nghiệp vụ, phân tích tài liệu/hệ thống cũ |
| 1.3 | Phân tích và mô hình hóa | BA | Use case, user story, sơ đồ luồng nghiệp vụ (BPMN/activity), mô hình dữ liệu nghiệp vụ, prototype/wireframe |
| 1.4 | Xác định yêu cầu phi chức năng | BA, SA | Hiệu năng, bảo mật, khả dụng, khả năng mở rộng, tương thích, pháp lý, khả năng bảo trì — **mỗi NFR phải đo được** |
| 1.5 | Đặc tả yêu cầu | BA | Viết SRS (V-Model) hoặc Product Backlog với user story + acceptance criteria (Agile) |
| 1.6 | Ưu tiên hóa | BA, PO/KH | MoSCoW (Must/Should/Could/Won't) hoặc theo giá trị nghiệp vụ |
| 1.7 | Review yêu cầu | BA, SA, TL, Test Lead | Review nội bộ: đầy đủ, nhất quán, không mơ hồ, kiểm thử được, khả thi |
| 1.8 | Xác nhận với khách hàng | BA, KH | Walkthrough SRS/backlog với KH, thu thập ý kiến, chỉnh sửa |
| 1.9 | Lập RTM | BA | Gán ID cho từng yêu cầu, khởi tạo ma trận truy xuất |
| 1.10 | Baseline yêu cầu | BA, CM | KH ký duyệt, đánh version, từ đây mọi thay đổi đi qua CR |

**Tiêu chí của một yêu cầu tốt** (theo tinh thần ISO/IEC/IEEE 29148):

| Tiêu chí | Câu hỏi kiểm tra | Ví dụ xấu → tốt |
|---|---|---|
| Rõ ràng, không mơ hồ | Chỉ hiểu được một cách? | "Hệ thống phải nhanh" → "API tìm kiếm trả kết quả ≤ 500 ms ở p95 với 200 người dùng đồng thời" |
| Kiểm thử được | Viết được test case để chứng minh đạt/không đạt? | "Giao diện thân thiện" → "Người dùng mới hoàn tất đặt hàng trong ≤ 5 bước" |
| Đầy đủ | Đã có luồng lỗi, giá trị biên, quyền truy cập? | Thiếu: "nếu thanh toán thất bại thì sao?" |
| Nhất quán | Không mâu thuẫn với yêu cầu khác? | Hai yêu cầu quy định timeout khác nhau |
| Khả thi | Làm được với công nghệ, ngân sách, thời gian hiện có? | — |
| Truy xuất được | Có ID duy nhất, biết nguồn gốc từ đâu? | REQ-ORD-012 ← workshop ngày 12/03 |
| Cần thiết | Bỏ đi thì có thiếu giá trị nghiệp vụ không? | Tính năng "cho đẹp" không ai yêu cầu |

### V — Kiểm tra
- Review nội bộ có ghi nhận (review record): số lỗi tìm được, phân loại, trạng
  thái xử lý.
- Test Lead tham gia review để đảm bảo yêu cầu **kiểm thử được** — đây là
  điểm khởi đầu của V-Model (yêu cầu ↔ kiểm thử nghiệm thu).
- KH xác nhận bằng văn bản (email, chữ ký, phê duyệt trên công cụ).

### X — Điều kiện ra (Gate G1)
- [ ] SRS hoặc Product Backlog (ít nhất phần cho release đầu) đã hoàn thành
- [ ] Mỗi yêu cầu có ID, độ ưu tiên, acceptance criteria
- [ ] NFR đã được định lượng
- [ ] Đã review nội bộ, mọi lỗi review đã đóng
- [ ] KH đã phê duyệt; yêu cầu đã baseline
- [ ] RTM đã khởi tạo
- [ ] Danh sách vấn đề còn mở (open issue) có người phụ trách và hạn xử lý

### Đầu ra
BRD (nếu có), SRS hoặc Product Backlog, use case/user story, prototype/wireframe,
glossary nghiệp vụ, RTM, review record, biên bản xác nhận yêu cầu.

### Chỉ số đo lường
- Số yêu cầu (theo loại), số lỗi tìm được khi review yêu cầu.
- **Requirement stability** = số yêu cầu thay đổi sau baseline / tổng số yêu
  cầu — theo dõi suốt dự án.

### Rủi ro thường gặp
- Chỉ ghi luồng chính (happy path), bỏ sót luồng lỗi và ngoại lệ.
- Bỏ sót NFR → phát hiện muộn ở kiểm thử hiệu năng hoặc production.
- KH "đồng ý miệng" không có xác nhận → tranh chấp phạm vi về sau.

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| Làm rõ yêu cầu mơ hồ thành user story + acceptance criteria, ước lượng quy mô thô | `requirements-analyst` |

---

## Giai đoạn 3 — Architecture & Design (Thiết kế)

**Mục tiêu:** Chuyển yêu cầu đã baseline thành giải pháp kỹ thuật: kiến
trúc tổng thể (HLD), thiết kế chi tiết từng module (LLD), API contract, mô
hình dữ liệu, thiết kế bảo mật — đủ để developer code mà không phải tự đoán.

**Skill điều phối:** `/developer:architecture-design`

Giai đoạn này chia làm 3 bước con theo thứ tự: **2A. Kiến trúc & HLD** →
**2B. Thiết kế chi tiết (LLD, API, DB)** → **2C. Lập kế hoạch kiểm thử**
(chạy song song với 2B).

### E — Điều kiện vào
- Gate G1 đã qua (ít nhất phần yêu cầu cho phạm vi đang thiết kế).
- NFR đã định lượng (làm cơ sở chọn kiến trúc).

### T — Các bước công việc

**2A. Kiến trúc và High-Level Design**

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 2.1 | Phân tích kiến trúc | SA | Xác định các yếu tố ảnh hưởng kiến trúc: NFR, ràng buộc kỹ thuật, tích hợp với hệ thống ngoài |
| 2.2 | Đề xuất phương án | SA | Ít nhất 2 phương án cho quyết định lớn, so sánh trade-off (chi phí, hiệu năng, độ phức tạp, rủi ro) |
| 2.3 | PoC (nếu cần) | SA, DEV | Kiểm chứng công nghệ/điểm rủi ro kỹ thuật cao trước khi chốt |
| 2.4 | Chốt phương án và ghi ADR | SA | Mỗi quyết định kiến trúc quan trọng có một ADR |
| 2.5 | Viết HLD | SA | Sơ đồ thành phần, trách nhiệm từng thành phần, luồng giao tiếp, deployment view, công nghệ, chia phase |
| 2.6 | Threat modeling | SA, chuyên gia bảo mật | Phân tích STRIDE trên luồng dữ liệu, xác định biện pháp bảo mật cần đưa vào thiết kế |
| 2.7 | Review HLD | SA, TL, OPS, Test Lead | Review chính thức, ghi nhận lỗi |

**2B. Thiết kế chi tiết**

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 2.8 | Thiết kế API | TL, SA | Endpoint/resource, method, request/response, mã lỗi, versioning, xác thực/phân quyền, pagination |
| 2.9 | Thiết kế dữ liệu | TL | ERD, schema, index, constraint, chiến lược migration, dữ liệu khởi tạo |
| 2.10 | Viết LLD | TL, DEV | Class/module, trách nhiệm, method signature, sequence diagram (gồm luồng lỗi), xử lý exception, pseudocode thuật toán phức tạp |
| 2.11 | Thiết kế giao diện (nếu có) | UI/UX, BA | Mockup chi tiết, luồng màn hình, quy tắc validate |
| 2.12 | Review LLD | TL, DEV, SA | Review chính thức |
| 2.13 | Cập nhật RTM | BA, TL | Nối yêu cầu → thành phần thiết kế |

**2C. Lập kế hoạch kiểm thử**

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 2.14 | Viết Test Plan | Test Lead | Phạm vi test, cấp độ test, loại test, môi trường, dữ liệu test, tiêu chí vào/ra, lịch, rủi ro kiểm thử |
| 2.15 | Chiến lược test tự động | Test Lead, TL | Phần nào tự động (unit/API/UI), công cụ, tích hợp CI |
| 2.16 | Review và phê duyệt Test Plan | PM, TL, BA | — |

**Cấu trúc HLD tối thiểu:**
1. Bối cảnh và mục tiêu, tham chiếu SRS
2. Sơ đồ ngữ cảnh (context diagram) — hệ thống và các hệ thống ngoài
3. Sơ đồ thành phần và trách nhiệm từng thành phần
4. Luồng giao tiếp chính giữa các thành phần
5. Mô hình dữ liệu tổng quan
6. Deployment view (môi trường, hạ tầng, network)
7. Cách đáp ứng từng NFR (hiệu năng, bảo mật, khả dụng, mở rộng)
8. Danh sách ADR liên quan
9. Rủi ro kỹ thuật và giả định
10. Chia phase triển khai

**Cấu trúc LLD tối thiểu (cho mỗi module):**
1. Phạm vi module, tham chiếu HLD
2. Class/module diagram và trách nhiệm
3. Interface/method signature (mức khái niệm)
4. Sequence diagram cho luồng chính và luồng lỗi
5. Cấu trúc dữ liệu nội bộ, schema liên quan
6. Chiến lược xử lý lỗi, logging, retry, transaction
7. Pseudocode cho thuật toán phức tạp
8. Lưu ý về hiệu năng, concurrency, bảo mật

### V — Kiểm tra
- Review HLD/LLD chính thức có review record.
- Checklist review thiết kế: đáp ứng đủ yêu cầu trong RTM? Mọi NFR có cách
  đáp ứng? Có single point of failure? Luồng lỗi đã thiết kế? Có kiểm thử
  được? Đã tính đến migration dữ liệu và rollback?
- Review schema/migration trước khi áp dụng.

### X — Điều kiện ra (Gate G2)
- [ ] HLD đã review và baseline
- [ ] LLD cho các module trong phạm vi sprint/phase đầu đã review
- [ ] API spec và schema đã review
- [ ] Mỗi quyết định kiến trúc lớn có ADR
- [ ] Threat model đã hoàn thành, biện pháp bảo mật đã đưa vào thiết kế
- [ ] Test Plan đã phê duyệt
- [ ] RTM cập nhật: yêu cầu → thiết kế
- [ ] Ước lượng chi tiết đã cập nhật lại dựa trên thiết kế (nếu lệch nhiều so với kế hoạch → báo PM xử lý)

### Đầu ra
HLD, LLD, ADR, API specification (OpenAPI/GraphQL schema), ERD/schema,
threat model, PoC report (nếu có), Test Plan, RTM cập nhật, review record.

### Chỉ số đo lường
Số lỗi tìm được khi review thiết kế, effort thiết kế thực tế so với ước lượng.

### Rủi ro thường gặp
- Bỏ qua thiết kế ở dự án "gấp" → developer tự quyết kiến trúc, không nhất quán.
- Thiết kế quá chi tiết cho phần còn thay đổi nhiều → lãng phí.
- Không thiết kế luồng lỗi, retry, idempotency → bug khó tái hiện ở production.

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| So sánh phương án kiến trúc kèm trade-off khi kiến trúc chưa chốt | `system-architect` |
| Tài liệu hóa HLD sau khi phương án đã chốt | `high-level-designer` |
| Chi tiết hóa HLD thành LLD (class, sequence, pseudocode) | `low-level-designer` |
| Thiết kế API REST/GraphQL mới | `api-designer` |
| Review schema/migration | `db-schema-reviewer` |
| Ghi ADR cho quyết định đã chốt | `adr-writer` |
| Threat modeling theo STRIDE | `threat-modeler` |
| Ước lượng lại effort dựa trên thiết kế | `project-estimator` |

---

## Giai đoạn 4 — Implementation (Phát triển)

**Mục tiêu:** Hiện thực hóa thiết kế thành code chạy được, đúng chuẩn, có
test bảo vệ, đã qua review, và tích hợp liên tục vào nhánh chính.

**Skill điều phối:** `/developer:implementation` (phản hồi nhanh trong lúc
code) — khi sắp merge, dùng `/developer:pre-merge` làm cổng kiểm tra cuối.

### E — Điều kiện vào
- Gate G2 đã qua cho phạm vi sắp code (hoặc story đã đạt **Definition of
  Ready** trong Agile — xem [checklist DoR](#231-definition-of-ready-dor)).
- Coding convention của dự án đã được ban hành.
- Môi trường dev, repository, CI đã sẵn sàng.

### T — Các bước công việc (cho mỗi task/story)

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 3.1 | Nhận task và hiểu yêu cầu | DEV | Đọc yêu cầu, acceptance criteria, LLD liên quan; hỏi lại BA/TL nếu chưa rõ — **không tự đoán** |
| 3.2 | Tạo nhánh làm việc | DEV | Từ nhánh chính theo quy ước đặt tên (ví dụ `feature/ORD-123-export-csv`) |
| 3.3 | Viết code và unit test | DEV | Theo coding convention; TDD hoặc viết test ngay sau code; xử lý luồng lỗi, log, validate input |
| 3.4 | Tự kiểm tra (self-review) | DEV | Chạy test cục bộ, lint, format; tự đọc lại diff; đối chiếu checklist code review |
| 3.5 | Commit | DEV | Commit nhỏ, message theo convention, có tham chiếu ID task |
| 3.6 | Tạo Pull Request | DEV | Mô tả: thay đổi gì, vì sao, cách test, ảnh hưởng, screenshot (nếu UI) |
| 3.7 | CI tự động | — | Build, unit test, lint, phân tích tĩnh, scan bảo mật/dependency, đo coverage |
| 3.8 | Code review | TL, DEV khác | Ít nhất 1 reviewer (code nhạy cảm như thanh toán/bảo mật: 2 reviewer); xem [checklist code review](#233-checklist-code-review) |
| 3.9 | Sửa theo review | DEV | Phản hồi từng comment; lặp lại 3.7–3.8 tới khi được approve |
| 3.10 | Merge | DEV/TL | Chỉ merge khi CI xanh và đủ approve; xóa nhánh sau merge |
| 3.11 | Deploy lên môi trường dev/integration | CI/CD | Tự động sau merge |
| 3.12 | Cập nhật trạng thái và RTM | DEV, BA | Task chuyển trạng thái; RTM nối yêu cầu → code/PR |

**Quy tắc lập trình bắt buộc:**
- Không commit secret (password, token, key) vào repository dưới mọi hình thức.
- Không merge code làm giảm coverage dưới ngưỡng của dự án mà không có lý do
  được TL chấp thuận.
- Không bỏ qua (skip/disable) test đang fail để merge cho kịp.
- Code chưa hoàn thiện nhưng cần merge phải ẩn sau **feature flag**.
- Mọi thay đổi schema phải đi qua migration script có review, có khả năng
  rollback.
- Thêm dependency mới phải kiểm tra license và lỗ hổng đã biết.

### V — Kiểm tra
- Code review cho **100% thay đổi** trước khi merge.
- CI tự động là cổng bắt buộc (branch protection không cho merge khi CI đỏ).
- Phân tích tĩnh và scan bảo mật trong CI.
- Định kỳ (ví dụ cuối sprint): review kiến trúc code, quét nợ kỹ thuật.

### X — Điều kiện ra (Gate G3 — Code complete)
- [ ] Toàn bộ task trong phạm vi đã merge vào nhánh chính
- [ ] CI xanh trên nhánh chính
- [ ] Unit test coverage đạt ngưỡng dự án đã đặt trong kế hoạch chất lượng
- [ ] Không còn comment review chưa xử lý
- [ ] Không có lỗ hổng bảo mật mức Critical/High từ scan chưa xử lý hoặc chưa được chấp nhận rủi ro
- [ ] Tài liệu kỹ thuật liên quan (API doc, README, ADR) đã cập nhật
- [ ] Build đã deploy thành công lên môi trường test

### Đầu ra
Source code, unit test, PR và review record, build artifact, API doc/docstring,
báo cáo CI (test, coverage, scan), RTM cập nhật.

### Chỉ số đo lường
- Năng suất (quy mô / effort), effort thực tế so với ước lượng.
- Số lỗi tìm được qua code review, thời gian từ mở PR tới merge.
- Unit test coverage, tỷ lệ build CI thất bại.

### Rủi ro thường gặp
- PR quá lớn → review hời hợt. Khuyến nghị chia PR nhỏ, dễ review.
- "Chạy được trên máy tôi" → thiếu môi trường chuẩn, thiếu CI.
- Tích lũy nợ kỹ thuật không được ghi nhận.

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| Review diff Android / Qt-C++ / Python | `android-commit-reviewer`, `qt-cpp-commit-reviewer`, `python-pep8-security-reviewer` |
| Đánh giá kiến trúc code (coupling, layering, SOLID) | `architecture-reviewer` |
| Viết unit test | `test-writer` |
| Refactor an toàn | `refactor-assistant` |
| Rà soát / nâng cấp dependency | `dependency-auditor`, `dependency-upgrader` |
| Quét nợ kỹ thuật | `tech-debt-tracker` |
| Sinh API doc, docstring | `api-doc-generator` |
| Commit message, mô tả PR | skill `/developer:commit`, `pr-description-writer` |
| Kiểm tra trước khi merge | skill `/developer:pre-merge` |
| Sửa CI fail | `ci-fixer` |

---

## Giai đoạn 5 — Verification & Testing (Kiểm thử)

**Mục tiêu:** Xác minh (verification — làm **đúng** thiết kế) và xác nhận
(validation — làm **đúng thứ khách hàng cần**) phần mềm; phát hiện lỗi trước
khi tới người dùng; cung cấp thông tin khách quan về chất lượng để ra quyết
định phát hành.

**Skill điều phối:** `/developer:verification-testing`

### Các cấp độ kiểm thử (V-Model)

```
 Yêu cầu nghiệp vụ (SRS) ◄──────────────────────► Kiểm thử nghiệm thu (UAT)
      Thiết kế kiến trúc (HLD) ◄──────────► Kiểm thử hệ thống (System Test)
           Thiết kế chi tiết (LLD) ◄──► Kiểm thử tích hợp (Integration/SIT)
                          Code ◄──► Kiểm thử đơn vị (Unit Test)
```

| Cấp độ | Ai thực hiện | Đối chiếu với | Mục đích | Môi trường |
|---|---|---|---|---|
| Unit Test | DEV | LLD | Từng hàm/class đúng logic, mock dependency | Máy dev, CI |
| Integration Test / SIT | DEV, QC | LLD, HLD, API spec | Các module/service ghép lại giao tiếp đúng | Integration/Test |
| System Test | QC (độc lập) | SRS, HLD | Toàn hệ thống đúng yêu cầu chức năng và phi chức năng | Test/Staging |
| UAT | KH / người dùng | SRS, nghiệp vụ thực tế | Hệ thống đáp ứng nhu cầu nghiệp vụ, chấp nhận bàn giao | Staging/UAT |

### Các loại kiểm thử

| Loại | Nội dung | Khi nào |
|---|---|---|
| Functional | Đúng chức năng theo yêu cầu, gồm giá trị biên, dữ liệu sai, luồng lỗi | Mỗi bản build test |
| Regression | Chức năng cũ không bị hỏng bởi thay đổi mới | Mỗi bản build; nên tự động hóa tối đa |
| Smoke | Bộ test nhỏ xác nhận build "sống", luồng chính chạy | Ngay sau mỗi lần deploy |
| Performance / Load / Stress | Đáp ứng NFR hiệu năng, tìm điểm gãy | Trước release lớn, khi thay đổi kiến trúc |
| Security | Lỗ hổng OWASP, xác thực/phân quyền, rò rỉ dữ liệu | Mỗi release; pentest cho release lớn |
| Usability | Dễ dùng, đúng luồng thao tác | Theo prototype và bản build |
| Compatibility | Trình duyệt, OS, thiết bị, phiên bản | Theo ma trận tương thích trong Test Plan |
| Data migration | Dữ liệu chuyển đổi đúng, đủ, không mất | Khi có migration |
| Recovery / Failover | Hệ thống phục hồi sau lỗi, backup/restore hoạt động | Trước go-live hệ thống quan trọng |

### E — Điều kiện vào (cho System Test)
- Test Plan đã phê duyệt; test case đã được review.
- Gate G3 đã qua; build đã deploy lên môi trường test, smoke test đạt.
- Dữ liệu test và môi trường test sẵn sàng.
- Release note nội bộ cho bản build (danh sách tính năng/bug fix có trong build).

### T — Các bước công việc (theo STLC)

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 4.1 | Phân tích yêu cầu kiểm thử | Test Lead, QC | Xác định cái gì cần test từ SRS/user story/HLD; hỏi lại BA điểm chưa rõ |
| 4.2 | Thiết kế test case | QC | Kỹ thuật: phân vùng tương đương, giá trị biên, bảng quyết định, chuyển trạng thái, đoán lỗi; mỗi test case nối với ID yêu cầu |
| 4.3 | Review test case | Test Lead, BA | Đủ độ phủ yêu cầu? Expected result rõ ràng? |
| 4.4 | Chuẩn bị dữ liệu và môi trường | QC, OPS | Dữ liệu test (ẩn danh hóa nếu lấy từ production), tài khoản test, cấu hình |
| 4.5 | Viết test tự động | QC, DEV | API test, UI/E2E test cho luồng chính và regression |
| 4.6 | Thực thi test | QC | Chạy theo chu kỳ (test cycle), ghi kết quả Pass/Fail/Blocked cho từng case |
| 4.7 | Ghi nhận defect | QC | Theo mẫu [bug report](#225-template-bug-report), phân loại severity/priority |
| 4.8 | Sửa lỗi | DEV | Theo vòng đời defect ([mục 12](#12-quản-lý-defect)) |
| 4.9 | Retest và regression | QC | Kiểm tra lại lỗi đã sửa + regression vùng bị ảnh hưởng |
| 4.10 | Báo cáo test | Test Lead | Báo cáo hằng ngày/chu kỳ và báo cáo tổng kết (Test Summary Report) |
| 4.11 | Đóng chu kỳ test | Test Lead | Đánh giá tiêu chí ra, bài học rút ra |

### V — Kiểm tra
- Review test case trước khi thực thi.
- RTM cập nhật: yêu cầu → test case → kết quả; **mọi yêu cầu phải có ít nhất
  một test case**.
- SQA kiểm tra mẫu việc tuân thủ quy trình ghi nhận defect.

### X — Điều kiện ra (Gate G4)
- [ ] 100% test case đã lên kế hoạch được thực thi (hoặc có lý do được chấp thuận cho phần không chạy)
- [ ] Tỷ lệ pass đạt ngưỡng trong Test Plan
- [ ] Không còn defect **Critical/High** ở trạng thái mở; defect Medium/Low còn mở đã được PM/KH chấp nhận và có kế hoạch xử lý
- [ ] Kiểm thử NFR (hiệu năng, bảo mật) đã thực hiện và đạt
- [ ] Regression đã chạy trên bản build cuối
- [ ] Test Summary Report đã phát hành
- [ ] RTM đầy đủ: mọi yêu cầu đều có kết quả test

### Đầu ra
Test case/test suite, test script tự động, dữ liệu test, kết quả thực thi,
defect log, Test Summary Report, RTM hoàn chỉnh.

### Chỉ số đo lường

| Chỉ số | Công thức | Ý nghĩa |
|---|---|---|
| Test coverage theo yêu cầu | Số yêu cầu có test case / tổng số yêu cầu | Độ phủ kiểm thử |
| Test execution rate | Số case đã chạy / tổng số case | Tiến độ test |
| Pass rate | Số case pass / số case đã chạy | Mức ổn định sản phẩm |
| Defect density | Số defect / quy mô (KLOC, function point, story point) | Chất lượng sản phẩm |
| Defect removal efficiency (DRE) | Defect tìm trước release / (trước + sau release) | Hiệu quả kiểm thử |
| Defect reopen rate | Số defect bị mở lại / số defect đã sửa | Chất lượng sửa lỗi |
| Defect leakage | Defect lọt sang giai đoạn sau / tổng defect | Hiệu quả từng cấp kiểm thử |

### Rủi ro thường gặp
- Bị cắt thời gian test vì dev trễ → phát hành với chất lượng không rõ.
- Môi trường test khác production → lỗi chỉ xuất hiện khi go-live.
- Test case chỉ có happy path.
- Flaky test làm team mất niềm tin vào bộ test tự động.

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| Viết/chạy integration hoặc E2E test | `e2e-test-runner` |
| Phân tích coverage, chỉ vùng thiếu test | `test-coverage-analyzer` |
| Viết unit test bổ sung | `test-writer` |
| Xử lý flaky test | `flaky-test-detector` |
| Audit bảo mật code | `security-auditor` |
| Phân tích hiệu năng | `performance-profiler` |
| Truy nguyên nhân defect khó | `root-cause-analyzer` |

---

## Giai đoạn 6 — Release & Deployment (Phát hành & triển khai)

**Mục tiêu:** Đưa bản phần mềm đã kiểm thử vào production một cách an toàn,
có kiểm soát, có khả năng quay lui, và được khách hàng chấp nhận.

**Skill điều phối:** `/developer:release-deployment`

### E — Điều kiện vào
- Gate G4 đã qua.
- Môi trường staging/UAT giống production về cấu hình.

### T — Các bước công việc

**5A. Nghiệm thu người dùng (UAT)**

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 5.1 | Chuẩn bị UAT | BA, Test Lead | Kịch bản UAT theo nghiệp vụ thực tế, tài khoản, dữ liệu, hướng dẫn cho KH |
| 5.2 | Thực hiện UAT | KH, BA hỗ trợ | KH chạy kịch bản, ghi nhận vấn đề |
| 5.3 | Phân loại phản hồi UAT | BA, PM | Defect thật / thay đổi yêu cầu (→ CR) / hiểu nhầm cách dùng |
| 5.4 | Sửa lỗi và retest | DEV, QC | Theo vòng đời defect |
| 5.5 | Biên bản nghiệm thu UAT | KH, PM | KH xác nhận chấp nhận (có thể kèm danh sách lỗi tồn đọng được chấp nhận) |

**5B. Chuẩn bị phát hành**

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 5.6 | Chốt phạm vi release và version | PM, TL | Danh sách tính năng/bug fix; đặt version theo quy tắc (ví dụ Semantic Versioning) |
| 5.7 | Tạo release candidate | CM/OPS | Tag trên repository, build artifact bất biến (cùng artifact đi qua staging và production) |
| 5.8 | Viết release note và changelog | PM, TL | Cho người dùng (tính năng mới, thay đổi) và cho vận hành (cấu hình, migration, lưu ý) |
| 5.9 | Lập kế hoạch triển khai | OPS, TL | Thứ tự các bước, người thực hiện, thời gian, khung giờ bảo trì, chiến lược triển khai |
| 5.10 | Lập kế hoạch rollback | OPS, TL | Điều kiện kích hoạt rollback, các bước, thời gian dự kiến, xử lý migration dữ liệu |
| 5.11 | Pre-flight check | OPS | Biến môi trường, secret, health check, resource limit, cấu hình IaC, backup dữ liệu trước khi deploy |
| 5.12 | Thông báo | PM | Thông báo lịch triển khai, thời gian gián đoạn (nếu có) cho KH/người dùng/bộ phận support |
| 5.13 | Họp Go/No-go (Gate G5) | PM chủ trì | Đi qua [checklist go/no-go](#234-checklist-gono-go-phát-hành); quyết định bằng văn bản |

**5C. Triển khai**

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 5.14 | Backup | OPS | Backup database và cấu hình; xác nhận backup restore được |
| 5.15 | Triển khai | OPS (qua pipeline CD) | Theo kế hoạch; ghi log từng bước; không thao tác tay ngoài kế hoạch |
| 5.16 | Smoke test production | QC, OPS | Kiểm tra luồng chính, health check |
| 5.17 | Theo dõi sau triển khai | OPS, TL | Error rate, latency, tài nguyên, log trong khoảng thời gian theo dõi đã thống nhất |
| 5.18 | Xác nhận go-live (Gate G6) hoặc rollback | PM | Nếu chỉ số bất thường vượt ngưỡng → kích hoạt rollback theo kế hoạch |
| 5.19 | Bàn giao | PM, TL | Bàn giao tài liệu vận hành, hướng dẫn sử dụng, đào tạo người dùng/support |

**Các chiến lược triển khai:**

| Chiến lược | Cách làm | Ưu điểm | Nhược điểm |
|---|---|---|---|
| Big-bang / Recreate | Dừng bản cũ, chạy bản mới | Đơn giản | Có downtime, rủi ro cao |
| Rolling | Thay dần từng instance | Không downtime | Hai phiên bản chạy song song một thời gian |
| Blue-Green | Dựng môi trường mới song song, chuyển traffic một lần | Rollback nhanh (chuyển traffic lại) | Tốn gấp đôi hạ tầng trong lúc chuyển |
| Canary | Chuyển một phần nhỏ traffic sang bản mới, tăng dần | Phát hiện lỗi với ít người dùng bị ảnh hưởng | Cần monitoring tốt, phức tạp hơn |
| Feature flag | Deploy code nhưng bật tính năng theo cấu hình | Tách deploy khỏi release, tắt nhanh khi lỗi | Phải quản lý và dọn flag cũ |

### V — Kiểm tra
- Họp Go/No-go có biên bản.
- Pre-flight check có kết quả PASS/FAIL theo từng hạng mục.
- Smoke test production có kết quả ghi nhận.

### X — Điều kiện ra (Gate G6)
- [ ] Biên bản UAT đã ký
- [ ] Đã triển khai thành công, smoke test production đạt
- [ ] Monitoring ổn định trong thời gian theo dõi
- [ ] Release note đã phát hành, tag version đã tạo
- [ ] Tài liệu vận hành và hướng dẫn sử dụng đã bàn giao
- [ ] Bộ phận support đã được thông báo và đào tạo

### Đầu ra
Biên bản UAT, release note, changelog, deployment plan, rollback plan, biên
bản go/no-go, kết quả pre-flight check, deployment log, tài liệu vận hành,
hướng dẫn sử dụng.

### Chỉ số đo lường
Tần suất triển khai, tỷ lệ triển khai thất bại (phải rollback/hotfix), thời
gian từ commit tới production (lead time), số defect phát hiện trong UAT.

### Rủi ro thường gặp
- Không thử rollback trước → khi cần rollback thì không chạy được.
- Migration dữ liệu không đảo ngược được nhưng không được đánh dấu là điểm "không thể quay lui".
- Thao tác tay ngoài kế hoạch lúc triển khai.

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| Tổng hợp changelog | `changelog-writer` |
| Lập checklist go/no-go và kế hoạch rollback | `release-manager` |
| Pre-flight check cấu hình | `deployment-validator` |
| Review IaC trước khi apply | `iac-reviewer` |
| Tối ưu Dockerfile | `docker-optimizer` |
| Sửa pipeline CI/CD fail | `ci-fixer` |

---

## Giai đoạn 7 — Operation & Maintenance (Vận hành & bảo trì)

**Mục tiêu:** Giữ hệ thống chạy ổn định theo SLA/SLO, xử lý sự cố nhanh và
đúng nguyên nhân gốc, tiếp tục cải tiến phần mềm.

**Skill điều phối:** `/developer:operation-maintenance`

### Các loại bảo trì

| Loại | Mô tả | Ví dụ |
|---|---|---|
| Corrective (sửa lỗi) | Sửa defect phát hiện sau khi phát hành | Bug tính sai tiền |
| Adaptive (thích nghi) | Thích nghi với môi trường thay đổi | Nâng phiên bản OS, framework, đổi API bên thứ ba |
| Perfective (hoàn thiện) | Cải thiện hiệu năng, khả năng bảo trì, thêm tính năng nhỏ | Tối ưu query, refactor |
| Preventive (phòng ngừa) | Xử lý vấn đề tiềm ẩn trước khi gây lỗi | Trả nợ kỹ thuật, vá CVE, gia hạn chứng chỉ |

Mọi thay đổi trong giai đoạn bảo trì vẫn đi lại các giai đoạn 2→6 ở quy mô
nhỏ (yêu cầu → thiết kế nếu cần → code → test → release). **Hotfix** được
rút gọn quy trình nhưng **không được bỏ** code review, test hồi quy vùng ảnh
hưởng và ghi nhận.

### Giám sát

- Theo dõi SLI theo SLO đã cam kết: khả dụng, latency, error rate, throughput.
- Theo dõi tài nguyên: CPU, RAM, disk, kết nối DB, hàng đợi.
- Cảnh báo (alert) có ngưỡng rõ, có người trực nhận (on-call), tránh alert
  quá nhiều gây "nhờn".
- Log tập trung, không chứa dữ liệu nhạy cảm (PII, password, token).

### Quy trình xử lý sự cố (incident)

**Phân loại mức độ nghiêm trọng (gợi ý — mỗi dự án tự chốt theo SLA):**

| Mức | Định nghĩa | Ví dụ | Phản hồi |
|---|---|---|---|
| **SEV1** | Hệ thống ngừng hoạt động hoặc mất/rò rỉ dữ liệu, ảnh hưởng toàn bộ người dùng | Production down, lộ dữ liệu khách hàng | Ngay lập tức, huy động toàn lực, báo lãnh đạo và KH |
| **SEV2** | Chức năng chính bị lỗi, ảnh hưởng nhiều người dùng, chưa có cách vòng | Không thanh toán được | Khẩn cấp, trong giờ |
| **SEV3** | Chức năng phụ lỗi hoặc có cách vòng | Xuất báo cáo lỗi định dạng | Trong ngày làm việc |
| **SEV4** | Ảnh hưởng nhỏ, thẩm mỹ | Sai chính tả giao diện | Lên lịch xử lý |

**Các bước xử lý:**

| # | Bước | Mô tả |
|---|---|---|
| 6.1 | Phát hiện và tiếp nhận | Từ alert, người dùng báo, support; tạo ticket sự cố |
| 6.2 | Phân loại severity | Xác định mức, chỉ định Incident Commander (người điều phối) |
| 6.3 | Thông báo | Theo ma trận escalation: nội bộ, lãnh đạo, khách hàng |
| 6.4 | Thu thập bằng chứng | Lưu log, metric, trạng thái hệ thống **trước khi** khởi động lại/rollback để không mất dữ liệu điều tra |
| 6.5 | Khắc phục tạm thời (mitigate) | Ưu tiên khôi phục dịch vụ: rollback, tắt feature flag, scale, chuyển traffic |
| 6.6 | Xác nhận khôi phục | Chỉ số trở lại bình thường, người dùng xác nhận |
| 6.7 | Phân tích nguyên nhân gốc (RCA) | Sau khi ổn định: truy nguyên nhân gốc (5 Whys, fishbone), không dừng ở triệu chứng |
| 6.8 | Khắc phục triệt để | Fix qua quy trình chuẩn (có test, review) |
| 6.9 | Postmortem | Báo cáo theo [template](#227-template-postmortem), văn hóa **không đổ lỗi cá nhân**; action item có người phụ trách và hạn |
| 6.10 | Theo dõi action item | PM theo dõi tới khi đóng; cập nhật bài học vào kho kinh nghiệm |

### E / X
- **Vào:** Gate G6 đã qua; tài liệu vận hành đã bàn giao; on-call đã thiết lập.
- **Ra (cho mỗi sự cố):** dịch vụ khôi phục, RCA hoàn thành, postmortem phát
  hành (SEV1/SEV2), action item có người phụ trách.

### Đầu ra
Ticket sự cố, báo cáo RCA, postmortem, hotfix/patch release, báo cáo SLA định
kỳ, tài liệu vận hành cập nhật.

### Chỉ số đo lường
Uptime theo SLO, MTTD, MTTR, số sự cố theo severity, tỷ lệ sự cố lặp lại
(cùng nguyên nhân gốc), backlog bảo trì.

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| Điều phối khi sự cố đang diễn ra | `incident-commander` |
| Phân tích pattern trên log diện rộng | `log-analyzer` |
| Truy nguyên nhân gốc một sự cố cụ thể | `root-cause-analyzer` |
| Quét nợ kỹ thuật, ưu tiên hóa bảo trì phòng ngừa | `tech-debt-tracker` |
| Vá CVE dependency | `dependency-auditor` → `dependency-upgrader` |
| Hướng dẫn người mới tiếp quản hệ thống | `onboarding-guide` |
| Cập nhật tài liệu vận hành/README | `doc-writer` |

---

## Phụ lục — Đóng dự án (ngoài khung 7 giai đoạn)

> Mục này nằm **ngoài** vòng lặp 7 giai đoạn (giai đoạn 1-7 lặp lại theo từng
> tính năng/release); nó chỉ áp dụng một lần khi dự án có mốc **kết thúc
> chính thức** (phổ biến ở dự án fix-price/outsourcing). Dự án vận hành liên
> tục, không có mốc đóng (ví dụ sản phẩm SaaS nội bộ) có thể bỏ qua mục này.

**Mục tiêu:** Kết thúc dự án (hoặc một giai đoạn hợp đồng) có kiểm soát:
nghiệm thu, bàn giao đầy đủ, tổng kết số liệu và bài học để tổ chức làm
tốt hơn ở dự án sau.

### T — Các bước công việc

| # | Bước | Người thực hiện | Mô tả chi tiết |
|---|---|---|---|
| 7.1 | Nghiệm thu cuối | PM, KH | Đối chiếu deliverable với SOW, ký biên bản nghiệm thu |
| 7.2 | Bàn giao | PM, TL | Source code, tài liệu, tài khoản, quyền truy cập, kiến thức (knowledge transfer) |
| 7.3 | Thu hồi quyền truy cập | OPS, PM | Thu hồi quyền của thành viên không còn tham gia vào hệ thống KH |
| 7.4 | Lưu trữ | CM | Baseline cuối của mọi tài liệu và code; lưu trữ theo chính sách |
| 7.5 | Tổng kết số liệu | PM, SQA | Effort, lịch, chi phí, chất lượng thực tế so với kế hoạch; đưa vào cơ sở dữ liệu quy trình của tổ chức |
| 7.6 | Họp rút kinh nghiệm (lessons learned) | Cả team | Điều gì làm tốt, điều gì cần cải thiện, đề xuất cải tiến quy trình |
| 7.7 | Báo cáo đóng dự án | PM | Tổng hợp kết quả, số liệu, bài học, vấn đề tồn đọng |
| 7.8 | Giải phóng nguồn lực | PM | Đánh giá thành viên, chuyển nguồn lực |

### X — Điều kiện ra (Gate G7)
- [ ] Biên bản nghiệm thu cuối đã ký
- [ ] Bàn giao đủ theo danh mục cam kết
- [ ] Báo cáo đóng dự án và lessons learned đã phát hành
- [ ] Số liệu dự án đã đưa vào cơ sở dữ liệu của tổ chức
- [ ] Quyền truy cập đã thu hồi; tài liệu đã lưu trữ

### Agent hỗ trợ
| Việc | Agent |
|---|---|
| Đối chiếu hồ sơ dự án với checklist quality gate | `qms-compliance-checker` |
| Viết tài liệu bàn giao, README | `doc-writer` |
| Tổng hợp changelog toàn dự án | `changelog-writer` |

---

# Phần III — Các quy trình hỗ trợ xuyên suốt

## 8. Quản lý dự án (theo dõi và kiểm soát)

**Hoạt động định kỳ:**

| Hoạt động | Tần suất gợi ý | Nội dung |
|---|---|---|
| Họp nội bộ ngắn (daily) | Hằng ngày | Hôm qua làm gì, hôm nay làm gì, vướng mắc gì |
| Báo cáo tiến độ | Hằng tuần | Tiến độ so với kế hoạch, effort, rủi ro, vấn đề, quyết định cần KH |
| Rà soát rủi ro | Hằng tuần / mỗi sprint | Cập nhật Risk Register |
| Họp với khách hàng | Hằng tuần hoặc theo hợp đồng | Báo cáo, xác nhận, giải quyết vấn đề |
| Review milestone | Tại mỗi milestone | Đánh giá tổng thể, điều chỉnh kế hoạch |

**Chỉ số theo dõi:**

| Chỉ số | Công thức | Ngưỡng cảnh báo gợi ý |
|---|---|---|
| Effort variance | (Effort thực tế − Effort kế hoạch) / Effort kế hoạch | Vượt ±10–15% |
| Schedule variance | (Ngày hoàn thành thực tế − kế hoạch) / thời lượng kế hoạch | Trễ quá 10% |
| Requirement stability | Số yêu cầu thay đổi / tổng số yêu cầu | Tăng đột biến |
| Defect density | Số defect / quy mô | Vượt mục tiêu trong kế hoạch chất lượng |

Khi chỉ số vượt ngưỡng: PM phân tích nguyên nhân, đưa ra hành động khắc phục
(corrective action), theo dõi tới khi đóng; nếu cần thay đổi baseline kế
hoạch thì đi qua quy trình thay đổi.

## 9. Quản lý cấu hình (Configuration Management)

**Configuration item (CI)** là mọi sản phẩm cần quản lý phiên bản: tài liệu
(SRS, HLD, LLD, Test Plan...), source code, script build/deploy, cấu hình
môi trường, IaC, test case.

**Quy tắc:**
1. **Mọi CI nằm trong hệ thống quản lý phiên bản** (Git cho code/cấu hình;
   kho tài liệu có lịch sử phiên bản cho tài liệu).
2. **Branching strategy** được chốt trong CM Plan. Hai lựa chọn phổ biến:

   | Chiến lược | Mô tả | Phù hợp |
   |---|---|---|
   | Trunk-based | Nhánh ngắn hạn, merge vào `main` thường xuyên, dùng feature flag | Team có CI/CD mạnh, release liên tục |
   | Git Flow | `main`, `develop`, `feature/*`, `release/*`, `hotfix/*` | Release theo phiên bản, cần duy trì nhiều phiên bản |

3. **Nhánh chính được bảo vệ:** không push trực tiếp, bắt buộc PR + review +
   CI xanh.
4. **Đặt version theo Semantic Versioning** `MAJOR.MINOR.PATCH`: MAJOR khi
   thay đổi không tương thích ngược, MINOR khi thêm tính năng tương thích,
   PATCH khi sửa lỗi.
5. **Baseline** tại mỗi gate: tài liệu được đánh version (ví dụ v1.0), code
   được gắn tag. Thay đổi sau baseline đi qua quy trình thay đổi.
6. **Quy ước version tài liệu:** v0.x — bản nháp; v1.0 — bản baseline đầu
   tiên; v1.1, v1.2 — thay đổi nhỏ đã duyệt; v2.0 — thay đổi lớn.
   Mỗi tài liệu có **bảng lịch sử thay đổi** (ngày, version, người sửa, nội
   dung thay đổi, người duyệt).
7. **Audit cấu hình** trước mỗi release: build có tái lập được từ tag? Tài
   liệu có khớp với phiên bản code?

## 10. Quản lý thay đổi (Change Management)

Áp dụng cho mọi thay đổi với yêu cầu, thiết kế, kế hoạch **đã baseline**.

```
 Yêu cầu thay đổi ─► Ghi nhận CR ─► Phân tích tác động ─► Phê duyệt? ──không──► Đóng CR, thông báo
                                    (phạm vi, effort,        │
                                     lịch, chi phí, rủi ro)  có
                                                             ▼
                                         Cập nhật baseline (SRS, thiết kế, kế hoạch, RTM)
                                                             ▼
                                         Thực hiện qua các giai đoạn 3→6
                                                             ▼
                                              Xác minh và đóng CR
```

- **Người phân tích tác động:** BA (nghiệp vụ), SA/TL (kỹ thuật), Test Lead
  (kiểm thử), PM (lịch, chi phí).
- **Người phê duyệt:** theo mức tác động — thay đổi nhỏ trong nội bộ dự án do
  PM duyệt; thay đổi phạm vi/chi phí/lịch cam kết phải có KH duyệt (Change
  Control Board nếu dự án lớn).
- Trong Agile, thay đổi trong backlog chưa vào sprint **không cần CR** (PO tự
  sắp xếp); thay đổi phạm vi đã cam kết trong hợp đồng vẫn cần CR.
- Xem [template CR](#226-template-change-request).

## 11. Quản lý rủi ro

**Các bước:** Nhận diện → Phân tích (xác suất × tác động) → Lập kế hoạch ứng
phó → Theo dõi → Đóng.

**Ma trận mức rủi ro:**

| Xác suất \ Tác động | Thấp (1) | Trung bình (2) | Cao (3) |
|---|---|---|---|
| **Cao (3)** | 3 — Trung bình | 6 — Cao | 9 — Rất cao |
| **Trung bình (2)** | 2 — Thấp | 4 — Trung bình | 6 — Cao |
| **Thấp (1)** | 1 — Thấp | 2 — Thấp | 3 — Trung bình |

**Chiến lược ứng phó:** Tránh (đổi kế hoạch để loại bỏ rủi ro) · Giảm thiểu
(giảm xác suất/tác động) · Chuyển giao (bảo hiểm, hợp đồng, bên thứ ba) ·
Chấp nhận (có kế hoạch dự phòng — contingency plan).

**Risk Register — các cột tối thiểu:** ID, mô tả rủi ro (dạng "nếu… thì…"),
loại (kỹ thuật/nguồn lực/khách hàng/lịch...), xác suất, tác động, mức, chiến
lược ứng phó, hành động, người phụ trách, hạn, dấu hiệu kích hoạt, trạng thái.

**Rủi ro phổ biến cần xem xét ở mọi dự án:** yêu cầu không rõ/thay đổi nhiều,
công nghệ mới chưa có kinh nghiệm, phụ thuộc hệ thống bên thứ ba, thiếu hoặc
biến động nhân sự chủ chốt, ước lượng thiếu, môi trường test không sẵn sàng,
yêu cầu bảo mật/pháp lý (bảo vệ dữ liệu cá nhân).

## 12. Quản lý defect

### 12.1. Vòng đời defect

```
 New ─► Assigned ─► In Progress ─► Fixed ─► Retest ─► Closed
  │                                             │
  ├─► Rejected (không phải lỗi / trùng)         └─► Reopened ─► Assigned
  └─► Deferred (hoãn sang phiên bản sau, cần PM/KH đồng ý)
```

### 12.2. Severity và Priority

**Severity** (mức độ nghiêm trọng về kỹ thuật — QC đánh giá) khác với
**Priority** (độ ưu tiên sửa — PM/PO quyết định). Một lỗi sai logo công ty
trên trang chủ có severity thấp nhưng priority cao.

| Severity | Định nghĩa |
|---|---|
| Critical | Crash, mất dữ liệu, lỗ hổng bảo mật nghiêm trọng, chặn toàn bộ chức năng chính, không có cách vòng |
| High | Chức năng chính sai, có cách vòng nhưng khó |
| Medium | Chức năng phụ sai, hoặc chức năng chính sai nhưng có cách vòng dễ |
| Low | Giao diện, chính tả, gợi ý cải tiến nhỏ |

| Priority | Định nghĩa |
|---|---|
| P1 | Sửa ngay, chặn release/kiểm thử |
| P2 | Sửa trong phiên bản/sprint hiện tại |
| P3 | Sửa khi có thời gian, có thể hoãn |

### 12.3. Phân tích nguyên nhân defect

Định kỳ (cuối sprint/milestone), phân loại defect theo **nguồn gốc** (yêu
cầu, thiết kế, code, môi trường, dữ liệu) và **giai đoạn lọt** (lẽ ra phải
phát hiện ở đâu) để cải tiến đúng chỗ — ví dụ nếu nhiều defect bắt nguồn từ
yêu cầu thì tăng cường review yêu cầu, không phải tăng test.

## 13. Review và kiểm tra ngang hàng

| Loại review | Mức hình thức | Áp dụng cho |
|---|---|---|
| Inspection (thanh tra chính thức) | Cao: có người điều phối, checklist, ghi nhận số liệu | SRS, HLD, code nhạy cảm ở dự án yêu cầu cao |
| Walkthrough | Trung bình: tác giả trình bày, người khác góp ý | Trình bày yêu cầu/thiết kế cho KH, team |
| Peer review / Code review | Trung bình–thấp: qua PR | Toàn bộ code, test case |
| Desk check / self-review | Thấp: tác giả tự kiểm tra | Mọi sản phẩm trước khi gửi review |

**Review record tối thiểu:** sản phẩm được review (tên, version), người
review, ngày, thời gian bỏ ra, danh sách lỗi (vị trí, mô tả, mức độ, trạng
thái), kết luận (đạt / đạt có điều kiện / không đạt — cần review lại).

## 14. Đảm bảo chất lượng quy trình (SQA)

- SQA **độc lập** với team dự án (không báo cáo cho PM của dự án đó).
- **Audit định kỳ:** đối chiếu thực tế dự án với quy trình đã cam kết trong
  Project Plan — có làm review không, có baseline không, có RTM không...
- **Kiểm tra tại gate:** xác nhận hồ sơ cần có tại mỗi gate đã tồn tại.
- **Non-conformance (NC):** điểm không tuân thủ được ghi nhận, có hạn khắc
  phục; NC quá hạn được escalate lên quản lý cấp trên.
- Thu thập số liệu dự án cho cơ sở dữ liệu quy trình của tổ chức, phục vụ
  ước lượng và cải tiến (đặc trưng của CMMI cấp cao).

**Agent hỗ trợ:** `qms-compliance-checker` (kiểm tra sự tồn tại của hồ sơ
theo từng giai đoạn).

## 15. Bảo mật xuyên suốt (Secure SDLC)

| Giai đoạn | Hoạt động bảo mật | Agent |
|---|---|---|
| Yêu cầu | Xác định yêu cầu bảo mật, pháp lý (bảo vệ dữ liệu cá nhân), phân loại dữ liệu | `requirements-analyst` |
| Thiết kế | Threat modeling (STRIDE), thiết kế xác thực/phân quyền, mã hóa | `threat-modeler` |
| Phát triển | Secure coding, review bảo mật, scan tĩnh (SAST), scan secret, scan dependency (SCA) | `security-auditor`, `dependency-auditor`, reviewer theo stack |
| Kiểm thử | Kiểm thử bảo mật, scan động (DAST), pentest cho release lớn | `security-auditor` |
| Triển khai | Review IaC, quản lý secret, cấu hình an toàn, nguyên tắc quyền tối thiểu | `iac-reviewer`, `deployment-validator`, `docker-optimizer` |
| Vận hành | Giám sát, vá lỗ hổng định kỳ, xử lý sự cố bảo mật, kiểm tra log không rò rỉ dữ liệu | `log-analyzer`, `dependency-upgrader`, `incident-commander` |

## 16. Quản lý tài liệu

- Mỗi tài liệu có: tên, mã tài liệu, version, trạng thái (Draft/In
  review/Approved/Obsolete), tác giả, người duyệt, lịch sử thay đổi.
- Tài liệu "sống" cùng code (README, API doc, ADR) được cập nhật **trong cùng
  PR** với thay đổi code liên quan.
- Tài liệu lỗi thời phải được đánh dấu Obsolete hoặc xóa — tài liệu sai còn
  nguy hiểm hơn không có tài liệu.

---

# Phần IV — Áp dụng theo mô hình dự án

## 17. Tailoring — điều chỉnh quy trình theo quy mô

| Hạng mục | Dự án nhỏ (< 3 tháng, ≤ 5 người) | Dự án vừa | Dự án lớn / yêu cầu cao (y tế, tài chính, fix-price lớn) |
|---|---|---|---|
| Project Plan | Rút gọn 1–2 trang | Đầy đủ | Đầy đủ + kế hoạch con (CM Plan, Quality Plan riêng) |
| Yêu cầu | User story + acceptance criteria | SRS hoặc backlog chi tiết | SRS theo chuẩn ISO/IEC/IEEE 29148 |
| Thiết kế | HLD gọn + ADR cho quyết định lớn | HLD + LLD cho module phức tạp | HLD + LLD đầy đủ, inspection chính thức |
| RTM | Liên kết story ↔ PR ↔ test trên công cụ quản lý task | RTM dạng bảng | RTM đầy đủ, audit được |
| Review | Code review qua PR | + review yêu cầu/thiết kế | Inspection chính thức có số liệu |
| Kiểm thử | Unit + E2E luồng chính tự động | + System test độc lập | + Kiểm thử NFR đầy đủ, pentest, kiểm thử độc lập |
| Gate | G1, G3, G5 | Tất cả gate | Tất cả gate + KH phê duyệt tại G1, G2, G5 |
| SQA audit | Tự kiểm tra bằng checklist | Audit theo milestone | Audit định kỳ bởi SQA độc lập |

**Không được cắt giảm ở bất kỳ quy mô nào:** quản lý phiên bản, code review,
test tự động cho luồng chính, quản lý secret an toàn, kế hoạch rollback khi
triển khai production, xác nhận yêu cầu với khách hàng.

## 18. Áp dụng theo V-Model / Waterfall

- Các giai đoạn 2→6 diễn ra **tuần tự**, mỗi giai đoạn kết thúc bằng gate
  chính thức; thường KH nghiệm thu tài liệu tại G1, G2.
- Kế hoạch kiểm thử từng cấp được lập **song song** với giai đoạn phát triển
  tương ứng (xem sơ đồ ở [sơ đồ cấp độ kiểm thử](#các-cấp-độ-kiểm-thử-v-model)): Kế hoạch
  UAT lập khi có SRS, kế hoạch System Test lập khi có HLD, kế hoạch
  Integration Test lập khi có LLD.
- Thay đổi sau baseline đi qua CR chặt chẽ vì ảnh hưởng hợp đồng fix-price.
- Phù hợp: yêu cầu ổn định, KH yêu cầu tài liệu đầy đủ, dự án outsourcing
  fix-price.

## 19. Áp dụng theo Agile / Scrum

**Ánh xạ giai đoạn sang hoạt động Scrum:**

| Giai đoạn trong tài liệu này | Tương ứng trong Scrum |
|---|---|
| 1. Discovery & Planning | Sprint 0 / Inception: tầm nhìn sản phẩm, backlog ban đầu, kiến trúc nền, môi trường, Definition of Done |
| 2. Requirements Analysis | Product Backlog Refinement liên tục; story đạt DoR mới vào sprint |
| 3. Architecture & Design | Kiến trúc nền ở Sprint 0; thiết kế chi tiết "vừa đủ" trong refinement và đầu mỗi story |
| 4. Implementation + 5. Verification & Testing | Trong sprint: dev và test song song, tester là thành viên team; story chỉ "Done" khi đạt DoD |
| Gate G3/G4 | Definition of Done ở cấp story + Sprint Review |
| 6. Release & Deployment | Release sau một hoặc nhiều sprint (hoặc liên tục với CD); UAT có thể là Sprint Review với KH + UAT trước release lớn |
| 7. Operation & Maintenance | Bug production vào backlog với độ ưu tiên; sự cố SEV1/SEV2 xử lý ngay, không chờ sprint |
| Phụ lục. Đóng dự án / cải tiến | Sprint Retrospective (cải tiến liên tục) + tổng kết khi kết thúc dự án |

**Các sự kiện Scrum:**

| Sự kiện | Thời lượng gợi ý (sprint 2 tuần) | Đầu ra |
|---|---|---|
| Sprint Planning | ~2–4 giờ | Sprint Goal, Sprint Backlog |
| Daily Scrum | 15 phút/ngày | Kế hoạch trong ngày, vướng mắc cần gỡ |
| Backlog Refinement | Không quá ~10% thời gian sprint | Story đạt DoR cho 1–2 sprint tới |
| Sprint Review | ~1–2 giờ | Demo cho stakeholder, phản hồi, backlog cập nhật |
| Sprint Retrospective | ~1–1,5 giờ | Tối đa 1–3 hành động cải tiến cụ thể cho sprint sau |

**Lưu ý khi kết hợp Agile với yêu cầu tuân thủ (kiểu CMMI):** vẫn cần
traceability (story ↔ PR ↔ test), review record (PR review là bằng chứng),
ADR cho quyết định kiến trúc, số liệu đo lường (velocity, defect) — chỉ khác
hình thức ghi nhận, không bỏ bản chất.

## 20. Áp dụng theo DevOps / Continuous Delivery

**Pipeline CI/CD chuẩn:**

```
 Commit ─► Build ─► Unit test ─► Lint/SAST/Secret scan/SCA ─► Đóng gói artifact
        ─► Deploy Dev ─► Integration/API test ─► Deploy Staging ─► E2E + Smoke
        ─► [Phê duyệt (Continuous Delivery) | tự động (Continuous Deployment)]
        ─► Deploy Production (canary/blue-green) ─► Smoke test ─► Giám sát
```

- Gate G3–G6 được **tự động hóa** thành các bước của pipeline: pipeline
  dừng khi bất kỳ bước nào thất bại.
- Cùng một artifact (image/build) đi qua mọi môi trường, chỉ khác cấu hình.
- Đo 4 chỉ số DORA: tần suất triển khai, lead time cho thay đổi, tỷ lệ triển
  khai thất bại, thời gian khôi phục dịch vụ.

---

# Phần V — Danh mục tài liệu, template và checklist

## 21. Danh mục tài liệu (artifact) theo giai đoạn

| Tài liệu | Giai đoạn | Người lập | Người duyệt | Bắt buộc với |
|---|---|---|---|---|
| SOW / Hợp đồng | 1 | PM | KH, lãnh đạo | Tất cả |
| Project Plan | 1 | PM | Lãnh đạo, SQA | Tất cả (dự án nhỏ: rút gọn) |
| WBS, lịch dự án | 1 | PM, TL | PM | Vừa, lớn |
| Risk Register | 1 → Phụ lục | PM | — | Tất cả |
| CM Plan | 1 | CM | PM | Vừa, lớn |
| SRS / Product Backlog | 2 | BA / PO | KH | Tất cả |
| RTM | 2 → 5 | BA | PM | Vừa, lớn (nhỏ: liên kết trên công cụ) |
| HLD | 3 | SA | PM, TL | Tất cả |
| LLD | 3 | TL | SA | Vừa, lớn |
| ADR | 3 → 7 | SA, TL | SA | Tất cả (cho quyết định lớn) |
| API spec | 3 → 4 | TL | SA | Khi có API |
| Threat model | 3 | SA | — | Khi xử lý dữ liệu nhạy cảm/thanh toán/xác thực |
| Test Plan | 3 | Test Lead | PM | Vừa, lớn |
| Test case | 5 | QC | Test Lead | Tất cả |
| Review record | Mọi giai đoạn | Người review | — | Tất cả (PR là review record cho code) |
| Defect log | 5 → 7 | QC | — | Tất cả |
| Test Summary Report | 5 | Test Lead | PM | Vừa, lớn |
| Biên bản UAT | 6 | PM | KH | Tất cả dự án có KH |
| Release note, changelog | 6 | PM, TL | PM | Tất cả |
| Deployment & rollback plan | 6 | OPS | PM, TL | Tất cả |
| Tài liệu vận hành, hướng dẫn sử dụng | 6 | TL, BA | PM | Tất cả |
| Postmortem | 7 | TL/IC | PM | Sự cố SEV1/SEV2 |
| Báo cáo đóng dự án | Phụ lục | PM | Lãnh đạo | Tất cả |

## 22. Template

### 22.1. Template User Story

```
ID: <PROJ-123>
Tiêu đề: <ngắn gọn>

Là <vai trò người dùng>,
tôi muốn <hành động/chức năng>,
để <giá trị/lợi ích nhận được>.

Acceptance criteria (dạng Given/When/Then):
  AC1: Given <bối cảnh>, When <hành động>, Then <kết quả mong đợi>
  AC2: ... (gồm cả luồng lỗi và giá trị biên)

Yêu cầu phi chức năng liên quan: <hiệu năng, bảo mật...>
Ngoài phạm vi: <điều story này KHÔNG làm>
Phụ thuộc: <story/hệ thống khác>
Ưu tiên: <Must/Should/Could>      Ước lượng: <story point>
Thiết kế/mockup: <link>
```

### 22.2. Khung SRS (rút gọn theo ISO/IEC/IEEE 29148)

```
1. Giới thiệu
   1.1 Mục đích   1.2 Phạm vi   1.3 Thuật ngữ, viết tắt   1.4 Tài liệu tham chiếu
2. Mô tả tổng quan
   2.1 Bối cảnh sản phẩm   2.2 Chức năng chính   2.3 Đối tượng người dùng
   2.4 Ràng buộc   2.5 Giả định và phụ thuộc
3. Yêu cầu chức năng (mỗi yêu cầu: ID, mô tả, ưu tiên, nguồn, tiêu chí chấp nhận)
4. Yêu cầu giao diện (người dùng, phần cứng, phần mềm/hệ thống ngoài, giao tiếp)
5. Yêu cầu phi chức năng (hiệu năng, bảo mật, khả dụng, mở rộng, bảo trì, pháp lý)
6. Yêu cầu dữ liệu (thực thể, lưu trữ, giữ dữ liệu, migration)
7. Phụ lục (mô hình, prototype, vấn đề còn mở)
```

### 22.3. Template ADR

```
# ADR-<số>: <Tiêu đề quyết định>
Trạng thái: Proposed | Accepted | Deprecated | Superseded by ADR-<số>
Ngày: <yyyy-mm-dd>     Người quyết định: <...>

## Bối cảnh       — vấn đề, ràng buộc, yếu tố ảnh hưởng
## Các phương án  — mỗi phương án: mô tả, ưu, nhược
## Quyết định     — phương án được chọn và lý do
## Hệ quả         — tích cực, tiêu cực, việc cần làm tiếp theo
```

### 22.4. Template Test Case

| Trường | Nội dung |
|---|---|
| ID | TC-ORD-045 |
| Yêu cầu liên quan | REQ-ORD-012 |
| Tiêu đề | Xuất đơn hàng ra CSV khi không có đơn nào trong khoảng thời gian |
| Điều kiện tiên quyết | Đăng nhập vai trò Quản lý; không có đơn trong tháng 01/2026 |
| Dữ liệu test | Khoảng thời gian 01/01/2026–31/01/2026 |
| Các bước | 1. Vào màn hình Đơn hàng 2. Chọn khoảng thời gian 3. Bấm "Xuất CSV" |
| Kết quả mong đợi | Hiển thị thông báo "Không có dữ liệu", không tạo file rỗng |
| Loại / Mức ưu tiên | Functional – Negative / Cao |
| Kết quả thực tế / Trạng thái | (điền khi chạy) Pass / Fail / Blocked |

### 22.5. Template Bug Report

```
ID: BUG-<số>          Tiêu đề: <Hiện tượng> khi <điều kiện>
Môi trường: <test/staging/prod>, build/version <...>, trình duyệt/OS/thiết bị <...>
Severity: Critical|High|Medium|Low     Priority: P1|P2|P3
Yêu cầu / test case liên quan: <REQ-..., TC-...>

Các bước tái hiện:
  1. ...
  2. ...
Kết quả thực tế: <...>
Kết quả mong đợi: <...>
Tần suất: Luôn luôn | Thỉnh thoảng (x/y lần)
Bằng chứng: <screenshot, video, log, request/response — đã che dữ liệu nhạy cảm>
```

### 22.6. Template Change Request

| Trường | Nội dung |
|---|---|
| CR ID, ngày, người yêu cầu | |
| Mô tả thay đổi | Thay đổi gì, so với baseline nào (tài liệu + version) |
| Lý do | Vì sao cần thay đổi |
| Phân tích tác động | Yêu cầu/thiết kế/code/test bị ảnh hưởng; effort; lịch; chi phí; rủi ro |
| Phương án | Chấp nhận toàn bộ / một phần / hoãn / từ chối |
| Quyết định | Người duyệt, ngày, chữ ký/xác nhận |
| Theo dõi | Các task thực hiện, trạng thái, ngày đóng |

### 22.7. Template Postmortem

```
# Postmortem: <Tên sự cố> — <ngày>
Severity: SEV<n>     Thời gian ảnh hưởng: <bắt đầu> → <kết thúc> (<tổng thời gian>)
Incident Commander: <...>     Người viết: <...>

## Tóm tắt              — 3–5 câu: chuyện gì xảy ra, ảnh hưởng, đã khắc phục ra sao
## Tác động             — số người dùng, giao dịch, dữ liệu, SLA bị ảnh hưởng
## Dòng thời gian       — mốc phát hiện, thông báo, khắc phục, khôi phục (kèm giờ)
## Nguyên nhân gốc      — kết quả RCA (5 Whys), tách rõ nguyên nhân gốc và yếu tố góp phần
## Điều gì đã làm tốt / chưa tốt
## Action items         — | Hành động | Loại (phòng ngừa/phát hiện/giảm thiểu) | Người phụ trách | Hạn |
```
> Nguyên tắc: **không đổ lỗi cá nhân** — tập trung vào việc hệ thống và quy
> trình đã để lỗi lọt qua như thế nào.

### 22.8. Template Release Note

```
# <Tên sản phẩm> v<MAJOR.MINOR.PATCH> — <ngày phát hành>
## Tính năng mới
## Cải tiến
## Lỗi đã sửa            — (ID + mô tả ngắn)
## Thay đổi không tương thích (breaking change) và hướng dẫn chuyển đổi
## Lưu ý triển khai      — migration, cấu hình mới, biến môi trường, thứ tự deploy
## Vấn đề đã biết (known issues)
```

## 23. Checklist

### 23.1. Definition of Ready (DoR)

Một story/task chỉ được đưa vào sprint/bắt đầu code khi:
- [ ] Mô tả rõ theo mẫu user story, có giá trị nghiệp vụ
- [ ] Có acceptance criteria kiểm thử được, gồm luồng lỗi
- [ ] Đã ước lượng, đủ nhỏ để hoàn thành trong một sprint
- [ ] Phụ thuộc đã xác định và không còn chặn
- [ ] Mockup/thiết kế liên quan đã có (nếu cần)
- [ ] Team đã hiểu và không còn câu hỏi mở quan trọng

### 23.2. Definition of Done (DoD)

Một story/task chỉ được coi là "Done" khi:
- [ ] Code đã viết theo coding convention, đã self-review
- [ ] Unit test đã viết và pass; coverage không giảm dưới ngưỡng
- [ ] Code review đã approve, CI xanh, đã merge vào nhánh chính
- [ ] Mọi acceptance criteria đã được QC/PO xác nhận trên môi trường test
- [ ] Không còn defect Critical/High liên quan
- [ ] Tài liệu liên quan đã cập nhật (API doc, README, ADR, release note nháp)
- [ ] Đã deploy lên môi trường test/staging

### 23.3. Checklist code review

**Tính đúng đắn**
- [ ] Code làm đúng yêu cầu/acceptance criteria
- [ ] Xử lý luồng lỗi, null/rỗng, giá trị biên, timeout
- [ ] Không có race condition, xử lý đúng transaction/concurrency

**Bảo mật**
- [ ] Validate và encode input/output (chống injection, XSS)
- [ ] Kiểm tra phân quyền ở server, không tin dữ liệu từ client
- [ ] Không có secret, không log dữ liệu nhạy cảm

**Thiết kế và khả năng bảo trì**
- [ ] Đúng với LLD/kiến trúc; không phá layering
- [ ] Đặt tên rõ ràng, hàm ngắn, không trùng lặp code
- [ ] Không có code chết, code comment-out, TODO không có ticket

**Hiệu năng**
- [ ] Không có N+1 query, vòng lặp tốn kém không cần thiết
- [ ] Giải phóng tài nguyên (connection, file, listener)

**Test và tài liệu**
- [ ] Có test cho logic mới và cho bug vừa sửa
- [ ] Migration có review và có khả năng rollback
- [ ] Tài liệu/comment cập nhật cho phần thay đổi hành vi

### 23.4. Checklist Go/No-go phát hành

**Chất lượng**
- [ ] Gate G4 đã qua; không còn defect Critical/High mở
- [ ] UAT đã ký (hoặc chấp nhận có điều kiện bằng văn bản)
- [ ] Regression và smoke test pass trên bản release candidate

**Kỹ thuật**
- [ ] Release candidate đã tag; artifact giống hệt bản đã test
- [ ] Pre-flight check cấu hình đạt (env var, secret, health check, resource limit)
- [ ] Migration đã chạy thử trên staging với dữ liệu tương tự production
- [ ] Backup đã thực hiện và đã kiểm tra restore được
- [ ] Kế hoạch rollback đã viết và **đã thử** trên staging

**Vận hành và con người**
- [ ] Monitoring, alert cho tính năng mới đã sẵn sàng
- [ ] Người thực hiện và người trực trong lúc/sau triển khai đã được phân công
- [ ] KH, người dùng, support đã được thông báo lịch triển khai
- [ ] Release note và tài liệu vận hành đã sẵn sàng

**Quyết định:** ☐ GO  ☐ NO-GO  ☐ GO có điều kiện — Người quyết định, thời
điểm, các điều kiện/rủi ro được chấp nhận.

### 23.5. Checklist hồ sơ tại các gate (dùng cho SQA)

| Gate | Hồ sơ phải có |
|---|---|
| G0 | SOW/quyết định khởi động, Project Plan (approved), Risk Register, biên bản kick-off |
| G1 | SRS/Backlog (baselined), review record yêu cầu, xác nhận KH, RTM |
| G2 | HLD, LLD, ADR, API spec, threat model, Test Plan, review record thiết kế |
| G3 | PR đã review, báo cáo CI (test, coverage, scan), tài liệu kỹ thuật cập nhật |
| G4 | Test case + kết quả, defect log, Test Summary Report, RTM hoàn chỉnh |
| G5 | Biên bản UAT, release note, deployment & rollback plan, biên bản go/no-go, kết quả pre-flight |
| G6 | Deployment log, kết quả smoke test production, xác nhận go-live |
| G7 | Biên bản nghiệm thu cuối, danh mục bàn giao, báo cáo đóng dự án, lessons learned |

Agent `qms-compliance-checker` có thể dùng để rà nhanh checklist này trên
repository dự án.

---

## Lịch sử thay đổi tài liệu

| Version | Ngày | Nội dung |
|---|---|---|
| 1.0 | 2026-10-06 | Bản đầu tiên |
| 1.1 | 2026-10-17 | Đổi sang khung 7 giai đoạn (đồng bộ với `QUY_TRINH_SAN_XUAT_PHAN_MEM.md`): Giai đoạn 0-6 cũ renumber thành 1-7, Giai đoạn 7 cũ (Đóng dự án) chuyển thành Phụ lục ngoài khung 7 giai đoạn. Mã gate G0-G7 giữ nguyên, chỉ đổi mô tả "Thời điểm". Thêm dòng "Skill điều phối" (`/developer:discovery-planning`...`/developer:operation-maintenance`) cho mỗi giai đoạn. |
