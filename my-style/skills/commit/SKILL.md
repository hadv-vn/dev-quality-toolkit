---
name: commit
description: >
  Soạn commit message BẮT BUỘC có mô tả rõ ràng, đầy đủ, chi tiết (cái gì
  thay đổi, tại sao, ảnh hưởng) cho thay đổi đang staged, trình người dùng
  duyệt, rồi tạo commit sau khi được xác nhận. Dùng khi người dùng gõ
  /my-style:commit hoặc muốn commit theo nguyên tắc cá nhân "mô tả đầy đủ".
argument-hint: "[gợi ý lý do thay đổi — tùy chọn]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git show:*)
---

# My-Style Commit

Ngữ cảnh người dùng cung cấp thêm (có thể trống): $ARGUMENTS

Nguyên tắc cá nhân (xem skill `guidance`): **mọi commit đều phải có mô tả rõ
ràng, đầy đủ, chi tiết** — không chấp nhận message 1 dòng mơ hồ kiểu
"update", "fix bug", "wip".

## Quy trình

1. **Xác nhận có gì đang staged.** Chạy `git status` và `git diff --staged`.
   Không có gì staged → DỪNG, hỏi người dùng muốn stage file nào. Không tự
   `git add` khi chưa được đồng ý.

2. **Nhận diện convention hiện có.** Chạy `git log --oneline -20` để theo
   đúng type/scope/ngôn ngữ đang dùng trong repo (Conventional Commits,
   prefix ticket, tiếng Việt...). Không có convention rõ → dùng Conventional
   Commits.

3. **Kiểm tra vệ sinh diff.** Diff gộp nhiều thay đổi không liên quan → đề
   xuất tách commit. Có secret/credential/file build lẫn vào → cảnh báo
   ngay, không commit tới khi người dùng quyết định.

4. **Soạn message — LUÔN gồm đủ 3 phần, không rút gọn:**
   - **Subject**: mệnh lệnh cách, ngắn gọn, nêu đúng bản chất thay đổi.
   - **Body — "Cái gì"**: mô tả cụ thể phần code/file nào thay đổi, theo
     cách nào (không lặp lại diff, nhưng đủ chi tiết để người đọc không cần
     mở diff mới hiểu).
   - **Body — "Tại sao"**: lý do/ngữ cảnh thực sự (từ hội thoại hoặc commit
     trước), không bịa nếu không có thông tin — khi đó hỏi người dùng lý do
     trước khi soạn tiếp.
   - **Ảnh hưởng** (nếu có): breaking change, tác động tới module/API khác,
     việc cần làm tiếp theo. Nêu rõ trong footer `BREAKING CHANGE: ...` nếu
     là breaking change.
   - Nếu sau khi tìm hiểu mà thay đổi thực sự quá nhỏ/hiển nhiên (ví dụ sửa
     1 typo) để có "tại sao" đáng kể, vẫn phải nêu rõ phạm vi cụ thể thay vì
     bỏ trống — không vì vậy mà quay lại dùng message 1 dòng.

5. **Trình người dùng duyệt** — hiển thị message đầy đủ, hỏi: commit luôn,
   sửa lại, hay hủy.

6. **Chỉ commit sau khi được xác nhận rõ ràng**, dùng heredoc để giữ nguyên
   xuống dòng:

   ```bash
   git commit -F - <<'EOF'
   <message>
   EOF
   ```

   Sau đó `git log --oneline -1` để xác nhận.

## Quy tắc an toàn

- Luôn tạo commit mới: không `--amend`, không `--no-verify`, không bỏ qua
  signing. Hook fail → tìm nguyên nhân, không lách hook.
- Không `git push`, không `git reset --hard`, không đổi branch.
- Đang ở branch mặc định (main/master) → nhắc người dùng một câu trước khi
  commit, nhưng vẫn theo quyết định của họ.
