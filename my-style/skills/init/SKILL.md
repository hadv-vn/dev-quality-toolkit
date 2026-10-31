---
name: init
description: >
  Soạn và tạo/cập nhật file rule phong cách code (CLAUDE.md hoặc file rule
  riêng) cho project hiện tại, dựa trên 9 nguyên tắc chuẩn ở skill
  `style-rules` kèm phần áp dụng cụ thể theo đúng stack/ngôn ngữ thực tế của
  project (phân tích qua manifest, cấu trúc thư mục, test runner đang dùng).
  Dùng khi người dùng gõ /my-style:init hoặc yêu cầu kiểu "khởi tạo rule
  phong cách cho project này", "tạo CLAUDE.md theo 9 nguyên tắc lập trình
  huyền thoại".
argument-hint: "[đường dẫn file rule muốn tạo — tùy chọn, mặc định CLAUDE.md]"
disable-model-invocation: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash(git log:*), Bash(git status:*)
---

# Init project — soạn file rule phong cách

Đường dẫn file rule người dùng chỉ định (có thể trống, mặc định `CLAUDE.md`
ở root project): $ARGUMENTS

Nội dung 9 nguyên tắc dùng trong skill này LUÔN lấy từ skill nền
`my-style:style-rules` (đã nạp sẵn trong context) — không tự viết lại
hoặc diễn giải khác đi. Việc của skill này là: (1) hiểu project đang làm gì,
(2) viết phần "Áp dụng vào project này" cụ thể cho từng nguyên tắc, (3) ghi
ra file đúng vị trí, đúng cách, có xác nhận của người dùng trước khi ghi.

## Bước 1 — Khảo sát project (bắt buộc trước khi viết bất kỳ nội dung nào)

Dùng `Glob`/`Read`/`Grep` để xác định, không đoán:

- **Ngôn ngữ/stack chính**: tìm manifest (`package.json`, `pyproject.toml`/
  `requirements*.txt`, `go.mod`, `Cargo.toml`, `*.csproj`, `build.gradle*`,
  `*.pro`/`CMakeLists.txt`, `Gemfile`...) và đuôi file phổ biến nhất trong
  repo.
- **Cấu trúc hiện có**: monorepo nhiều package/plugin hay single app; có
  `src/`, `tests/`, layer rõ rệt (API/service/data) hay không.
- **Test runner đang dùng** (nếu có): Jest/Vitest, pytest, JUnit, Qt Test,
  go test... — để phần áp dụng mục 4 (Kent Beck) và mục 7 không chung chung.
- **Quy ước commit/PR hiện có**: `git log --oneline -20` để biết có
  convention commit riêng không (ảnh hưởng mục 9 — quy ước thay cấu hình).
- **File rule đã tồn tại chưa**: `CLAUDE.md` ở root, hoặc file do
  `$ARGUMENTS` chỉ định. Có plugin khác trong project cũng định nghĩa rule
  tương tự (ví dụ plugin `my-style` nếu được cài) → đọc để tránh lặp/mâu
  thuẫn nội dung, không tự ý xoá nội dung người khác đã viết.

Project quá lớn/nhiều module để khảo sát hết trong context chính (ví dụ
monorepo >10 package khác stack nhau) → có thể giao phần khảo sát sâu từng
module cho agent `my-style:init-project` thay vì tự đọc hết, rồi
tổng hợp kết quả lại.

## Bước 2 — Xác nhận phạm vi với người dùng nếu còn mơ hồ

Chỉ hỏi khi thực sự cần — không hỏi những gì đã suy ra được từ Bước 1:

- Project có nhiều stack rõ rệt (ví dụ vừa backend Python vừa app Android)
  → hỏi có muốn tách phần "Áp dụng" riêng theo từng stack trong cùng 1 file,
  hay tách thành nhiều file rule.
- `CLAUDE.md` đã tồn tại và đã có nội dung đáng kể → hỏi: ghép thêm 9
  nguyên tắc vào cuối file hiện có (mặc định, khuyến nghị), hay tạo file
  riêng (ví dụ `.claude/STYLE_RULES.md`) và chỉ thêm 1 dòng tham chiếu vào
  `CLAUDE.md`.

## Bước 3 — Soạn nội dung

File rule tạo ra PHẢI gồm đủ 2 phần sau, theo đúng thứ tự:

1. **Nguyên văn 9 mục từ skill `style-rules`** (copy đúng nội dung, không
   rút gọn, không bỏ mục nào) — đây là phần triết lý/nguyên tắc nền, dùng
   chung cho mọi project.
2. **Ngay dưới mỗi mục, thêm đoạn "Áp dụng vào project này"** — 2-4 dòng cụ
   thể, dựa trên khảo sát ở Bước 1, ví dụ:
   - Mục 1 (Linus) ở project có nhiều `if`/`switch` xử lý case đặc biệt rải
     rác → chỉ ra đúng vùng code/pattern đó, gợi ý chuẩn hoá dữ liệu đầu vào
     thay vì rẽ nhánh.
   - Mục 4 (Kent Beck) → nêu đúng test runner đang dùng và quy tắc viết test
     trước khi merge (liên kết tới skill `/my-style:commit` hay
     `/developer:pre-merge` nếu plugin `developer` cũng được cài).
   - Mục 7 (Jeff Dean) chỉ thêm nếu project có phần liên quan hiệu năng/hệ
     thống phân tán rõ rệt — không gượng ép cho project nhỏ, thuần CRUD.

   Không bịa số liệu/đặc điểm project không có thật. Thiếu thông tin để viết
   phần áp dụng cho một mục cụ thể → viết ngắn gọn ở mức nguyên tắc chung,
   không suy diễn chi tiết kỹ thuật chưa xác minh.

## Bước 4 — Trình bày và xác nhận trước khi ghi file

Hiển thị nội dung đầy đủ dự kiến ghi (hoặc phần sẽ nối thêm nếu ghép vào
file có sẵn), nói rõ: ghi mới, nối vào cuối file, hay tạo file riêng theo
quyết định ở Bước 2. Chỉ `Write`/`Edit` sau khi người dùng xác nhận.

- File đã tồn tại và người dùng chọn ghi đè toàn bộ → cảnh báo rõ sẽ mất nội
  dung cũ, hỏi lại một lần nữa trước khi ghi đè.
- Không tự `git add`/`git commit` nội dung vừa tạo — để người dùng tự commit
  (gợi ý dùng `/my-style:commit` để commit theo nguyên tắc cá nhân).

## Định dạng file rule đầu ra (khung mẫu)

```markdown
# <Tên project> — Quy tắc & phong cách code

> Soạn bởi `/my-style:init` — 9 nguyên tắc nền + áp dụng cụ thể theo
> stack: <stack đã khảo sát>.

## 1. "Taste" và cấu trúc dữ liệu — Linus Torvalds
<nguyên văn mục 1>

**Áp dụng vào project này:** <cụ thể>

## 2. Tập trung sâu và thực dụng — John Carmack
...

(tiếp tục đủ 9 mục theo đúng thứ tự trong skill `style-rules`)
```

## Kết quả bàn giao

Sau khi ghi file, trả lời ngắn gọn:

```
Đã tạo/cập nhật: <đường dẫn file>

Stack đã khảo sát: <tóm tắt>
Phần đã thêm "Áp dụng cụ thể": <liệt kê mục nào có áp dụng rõ, mục nào giữ
mức nguyên tắc chung vì thiếu thông tin>
```
