---
name: commit
description: >
  Viết commit message đúng convention dự án cho thay đổi đang staged, trình
  cho người dùng duyệt, rồi tạo commit sau khi được xác nhận. Dùng khi người
  dùng gõ /developer:commit hoặc muốn commit thay đổi hiện tại.
argument-hint: "[gợi ý ngữ cảnh/lý do thay đổi — tùy chọn]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git show:*)
---

# Commit

Ngữ cảnh người dùng cung cấp thêm (có thể trống): $ARGUMENTS

Skill này chạy trong context chính, nên tận dụng những gì đã trao đổi trong
phiên (lý do sửa, bug đang xử lý...) để viết phần "tại sao" — nhưng chỉ khi
thông tin đó thực sự có trong hội thoại hoặc diff, không bịa.

## Quy trình

1. **Xác nhận có gì đang staged.** Chạy `git status` và `git diff --staged`.
   Nếu không có gì staged: DỪNG, hỏi người dùng muốn stage file nào (hoặc
   muốn dùng thay đổi unstaged). Không tự `git add` khi chưa được đồng ý.

2. **Nhận diện convention.** Chạy `git log --oneline -20`.
   - Lịch sử theo Conventional Commits → dùng đúng type/scope đang dùng.
   - Convention riêng (ticket prefix `JIRA-123: ...`, tiếng Việt...) → theo
     đúng convention đó.
   - Lịch sử quá ít/không nhất quán → mặc định Conventional Commits và nói rõ
     đây là lựa chọn mặc định.

3. **Kiểm tra vệ sinh diff trước khi viết.**
   - Diff chứa nhiều thay đổi KHÔNG liên quan → cảnh báo và đề xuất tách
     commit (`git reset` + `git add -p`), không gộp che lấp.
   - Thấy secret/credential, file build, file tạm bị stage nhầm → cảnh báo
     ngay, không commit cho tới khi người dùng quyết định.

4. **Soạn message.**
   - TYPE theo bản chất diff: `feat` (khả năng mới), `fix` (sửa lỗi),
     `refactor` (đổi cấu trúc, không đổi hành vi), `test`, `docs`,
     `build`/`ci`, `perf`, `chore`.
   - Subject: mệnh lệnh cách, ~50-72 ký tự, viết hoa/dấu chấm theo convention.
   - Body chỉ khi cần giải thích "tại sao"; không lặp lại subject.
   - Breaking change (đổi API public, đổi mặc định, xóa field) → footer
     `BREAKING CHANGE: ...`.
   - Nếu có dòng attribution/trailer bắt buộc (từ CLAUDE.md, system reminder
     hoặc convention repo) → thêm vào cuối.

5. **Trình cho người dùng duyệt** — hiển thị message đề xuất, kèm 1 dòng giải
   thích type/scope và mọi cảnh báo ở bước 3. Hỏi: commit luôn, sửa lại, hay
   hủy.

6. **Chỉ commit sau khi người dùng xác nhận rõ ràng.** Dùng heredoc để giữ
   nguyên xuống dòng:

   ```bash
   git commit -F - <<'EOF'
   <message>
   EOF
   ```

   Sau đó chạy `git log --oneline -1` để xác nhận.

## Quy tắc an toàn

- Luôn tạo commit mới: không `--amend`, không `--no-verify`, không bỏ qua
  signing. Nếu hook fail → báo lỗi, tìm nguyên nhân, không lách hook.
- Không `git push`, không `git reset --hard`, không đổi branch.
- Đang ở branch mặc định (main/master) → nhắc người dùng một câu trước khi
  commit, nhưng vẫn theo quyết định của họ.
