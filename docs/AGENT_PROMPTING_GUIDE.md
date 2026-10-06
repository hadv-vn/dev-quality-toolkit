# Hướng dẫn viết prompt cho các AI agent trong dev-quality-toolkit

Tài liệu này hướng dẫn cách viết prompt hiệu quả cho từng agent hiện có trong
bộ công cụ này, để agent được auto-trigger đúng lúc (hoặc được gọi đúng khi
nhắc tên trực tiếp) và cho ra báo cáo hữu ích ngay từ lần gọi đầu tiên.

Danh sách agent hiện có:

| Agent | Plugin/Vị trí | Vai trò |
|---|---|---|
| `python-pep8-security-reviewer` | `.claude/agents/` | Review code Python — PEP8 + bảo mật OWASP |
| `docs-reviewer` | `.claude/agents/` | Review tài liệu Markdown — chính tả, link hỏng, heading |
| `android-commit-reviewer` | plugin `commit-reviewers` | Review commit/diff Android (Kotlin/Java/Compose/Gradle/Manifest) |
| `qt-cpp-commit-reviewer` | plugin `commit-reviewers` | Review commit/diff Qt/C++ — memory safety, ownership, signal-slot |
| `ai-agent-architect` | plugin `agent-architect` | Thiết kế/tạo mới/nâng cấp một sub-agent khác |

## Nguyên tắc chung khi viết prompt cho bất kỳ agent nào ở đây

Tất cả các agent review (`python-pep8-security-reviewer`, `docs-reviewer`,
`android-commit-reviewer`, `qt-cpp-commit-reviewer`) đều theo cùng một triết
lý thiết kế: **chỉ đọc/phân tích/báo cáo, bám sát đúng phạm vi được giao,
không tự mở rộng**. Vì vậy, một prompt tốt cho các agent này luôn cần:

1. **Nêu rõ phạm vi.** Chỉ định cụ thể file, thư mục, commit hash, hoặc diff
   cần review. Agent được thiết kế để **hỏi lại** nếu phạm vi mơ hồ, thay vì
   tự ý quét toàn bộ dự án — nhưng cho phạm vi rõ ngay từ đầu sẽ nhanh hơn.
   - Tốt: *"Review giúp file `src/api/payment.py`"*
   - Tránh: *"Review code Python trong dự án"* (agent sẽ hỏi lại: file/thư
     mục nào?)

2. **Nói rõ bối cảnh nếu có** (tùy chọn nhưng hữu ích): đây là code sắp
   merge, đang debug một lỗi cụ thể, hay chỉ muốn rà soát tổng quát trước
   khi publish. Giúp agent ưu tiên đúng trọng tâm.

3. **Nếu muốn nhấn vào một khía cạnh cụ thể, nói thẳng ra** — ví dụ "đặc biệt
   chú ý phần build câu query" hay "kiểm tra kỹ đoạn xử lý thread". Các agent
   này có danh sách chuyên môn rất dài; chỉ định trọng tâm giúp báo cáo tập
   trung hơn thay vì dàn trải.

4. **Đừng yêu cầu agent tự sửa file.** Toàn bộ agent review trong bộ này chỉ
   có quyền đọc (`Read`/`Grep`/`Glob`, cộng `Bash` ở chế độ đọc/lint cho một
   số agent) — không có `Write`/`Edit`. Nếu muốn áp dụng fix, yêu cầu agent
   xuất đề xuất rồi tự bạn (hoặc một bước riêng) thực hiện sửa.

5. **Nhắc agent theo tên nếu muốn chỉ định chính xác**, tránh trường hợp mô
   tả mơ hồ khiến Claude Code chọn nhầm agent khi có nhiều agent review khác
   nhau cùng khả dụng (ví dụ vừa có `android-commit-reviewer` vừa có
   `qt-cpp-commit-reviewer` — nếu diff có cả hai loại code, nói rõ bạn muốn
   review phần nào bằng agent nào).

## Theo từng agent

### 1. `python-pep8-security-reviewer`

**Dùng khi:** cần review một file, diff/commit, hoặc thư mục Python cụ thể
trước khi merge, tập trung PEP8 và bảo mật OWASP.

**Prompt nên có:**
- Đường dẫn file/thư mục/commit cụ thể.
- Nếu là input từ bên ngoài (user input, file upload, API call) — nói rõ,
  giúp agent đánh giá đúng mức độ nghiêm trọng của các finding bảo mật.

**Ví dụ tốt:**
> "Review giúp file `scripts/import_data.py` xem có vấn đề PEP8 và bảo mật
> gì không, đặc biệt phần build câu SQL và gọi subprocess."

> "Kiểm tra bảo mật đoạn code Python xử lý input người dùng trong
> `api/upload.py` trước khi tôi merge."

**Lưu ý:** agent có thể chạy `flake8`/`bandit`/`pylint` qua `python -m ...`
nếu môi trường có sẵn; không tự cài package còn thiếu — nếu thiếu công cụ,
báo cáo sẽ ghi rõ và chuyển sang rà soát thủ công. Đây không phải lỗi cần
bạn xử lý trước.

### 2. `docs-reviewer`

**Dùng khi:** cần review chất lượng tài liệu Markdown/README — chính tả,
link nội bộ hỏng, cấu trúc heading không nhất quán.

**Prompt nên có:**
- Thư mục hoặc file `.md` cụ thể (mặc định agent quét toàn repo nếu không
  chỉ rõ).

**Ví dụ tốt:**
> "Review giúp tôi các file README trong thư mục `docs/` xem có lỗi chính
> tả hay link hỏng không."

> "Kiểm tra cấu trúc heading của `CONTRIBUTING.md` trước khi tôi publish."

**Lưu ý:** agent không có quyền mạng nên link `http(s)://` bên ngoài chỉ
được ghi nhận là "chưa kiểm tra", không xác minh được. Không hỏi agent này
về nội dung/văn phong (nó chỉ bắt chính tả, không sửa diễn đạt) hay lỗi cú
pháp trong code block — những việc đó ngoài phạm vi của nó.

### 3. `android-commit-reviewer`

**Dùng khi:** cần review một commit hoặc diff Android (Kotlin/Java, Gradle,
Compose, Manifest) trước khi merge.

**Prompt nên có:**
- Commit hash, hoặc diff dán trực tiếp, hoặc "commit vừa rồi"/"thay đổi
  hiện tại" nếu agent có thể tự lấy qua `git diff`/`git show`.
- Nếu thay đổi liên quan coroutine/lifecycle/Compose, có thể nhấn mạnh khía
  cạnh đó.

**Ví dụ tốt:**
> "Review giúp commit vừa rồi sửa màn hình login bằng Kotlin coroutine."

> "Xem lại diff này có vấn đề gì về Compose recomposition hay leak Context
> không." *(kèm diff hoặc chỉ rõ file)*

### 4. `qt-cpp-commit-reviewer`

**Dùng khi:** cần review một commit/diff Qt/C++ (hoặc C) cụ thể, tập trung
memory safety, ownership (parent-child), signal-slot, thread-safety.

**Prompt nên có:**
- Commit hash hoặc diff cụ thể.
- Nếu đổi ownership pointer (raw ↔ smart pointer) hay đụng đến
  threading/signal-slot, nói rõ — đây là trọng tâm agent quan tâm nhất.

**Ví dụ tốt:**
> "Review giúp commit `abc123` sửa lại `QThread` worker trong module
> camera."

> "Xem qua diff này, tôi vừa đổi raw pointer sang `QSharedPointer` trong
> `DeviceManager`, có ổn không?"

### 5. `ai-agent-architect`

**Dùng khi:** cần thiết kế, tạo mới, hoặc nâng cấp một sub-agent khác (đây
là agent "meta" — agent tạo ra agent).

**Prompt nên có nhất — đây là điểm khác biệt lớn nhất so với 4 agent review
ở trên:** agent này cần đủ thông tin để ra quyết định thiết kế, không chỉ
một câu mô tả mơ hồ. Cung cấp càng rõ các mục sau, agent càng ít phải hỏi
lại:

- **Mục đích cụ thể** của agent mới — nó giải quyết vấn đề gì.
- **Agent chỉ đọc/báo cáo hay được phép sửa/ghi file** — quyết định
  `tools` được cấp.
- **Có cần truy cập mạng không** (`WebFetch`/`WebSearch`) — ví dụ tra cứu
  CVE, tài liệu framework bên ngoài.
- **Nên là agent cấp project (`.claude/agents/`) hay đóng gói thành plugin
  riêng** (như `commit-reviewers`, `agent-architect` trong repo này).
- Nếu là **nâng cấp agent có sẵn**, nói rõ agent nào và vấn đề cụ thể cần
  sửa (ví dụ "description chưa đủ rõ để auto-trigger").

**Ví dụ tốt:**
> "Tạo giúp tôi một agent chuyên review code Python theo PEP8 và OWASP."
> *(agent sẽ tự hỏi thêm các chi tiết còn thiếu nếu cần)*

> "Tôi cần một agent viết release notes từ changelog, hãy thiết kế system
> prompt cho nó — nó chỉ cần đọc file changelog và ghi ra file
> RELEASE_NOTES.md, không cần truy cập mạng."

> "Nâng cấp lại agent `android-commit-reviewer` hiện có, description của
> nó chưa đủ rõ để auto-trigger khi tôi nói 'kiểm tra memory leak trong
> Fragment này'."

**Lưu ý:** nếu bạn chỉ muốn thảo luận thiết kế trước, nói rõ "chưa cần tạo
file, chỉ đề xuất trước" — mặc định nếu yêu cầu đủ rõ ràng, agent sẽ tạo
file `.md` thật ngay (không chỉ mô tả suông).

## Khi không chắc nên gọi agent nào

Nếu một diff/thay đổi trải rộng nhiều domain (ví dụ vừa có code Python vừa
có tài liệu Markdown thay đổi), có thể gọi lần lượt từng agent đúng phạm vi
của nó thay vì kỳ vọng một agent xử lý hết — mỗi agent trong bộ này được
thiết kế theo nguyên tắc single-responsibility (một agent làm tốt một việc).