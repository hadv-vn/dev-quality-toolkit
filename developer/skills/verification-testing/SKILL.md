---
name: verification-testing
description: >
  Điều phối giai đoạn kiểm thử sau khi code xong: phân tích coverage để tìm
  vùng thiếu test, chạy/viết integration-E2E, xử lý flaky test, và kiểm thử
  bảo mật + hiệu năng — chọn đúng agent theo tình trạng test hiện có, không
  chạy cho đủ bộ. Dùng khi người dùng gõ /developer:verification-testing hoặc
  cần một vòng kiểm thử toàn diện cho một tính năng/module đã code xong.
argument-hint: "[module/tính năng cần kiểm thử — có thể để trống]"
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash(git diff:*), Bash(git log:*)
---

# Verification & Testing

Phạm vi cần kiểm thử (có thể trống): $ARGUMENTS

Skill này điều phối, không tự quyết định test case thay agent chuyên trách.
Trung thực tuyệt đối khi tổng hợp — không tự suy ra kết quả PASS nếu agent
không thực sự chạy được.

## Bước 1 — Coverage hiện trạng

Có coverage report (lcov, coverage.py, JaCoCo...) → gọi
`developer:test-coverage-analyzer` để chỉ ra vùng thiếu test cần ưu tiên.
Không có report → bỏ qua, ghi nhận "chưa có coverage report" trong tổng hợp.

## Bước 2 — Viết/bổ sung test theo kết quả Bước 1

Theo ưu tiên từ `test-coverage-analyzer` (nếu có) hoặc theo phạm vi
`$ARGUMENTS`:

- Unit test còn thiếu → `developer:test-writer`.
- Luồng nghiệp vụ/API cần integration hoặc E2E thật →
  `developer:e2e-test-runner`.

## Bước 3 — Test không ổn định

Có test lúc pass lúc fail được người dùng chỉ ra (hoặc phát hiện khi chạy
Bước 2) → `developer:flaky-test-detector`. Không tự đoán test nào flaky nếu
chưa có bằng chứng (test đã chạy lại nhiều lần hoặc log CI).

## Bước 4 — Kiểm thử bảo mật & hiệu năng

Theo nhu cầu nêu trong `$ARGUMENTS` hoặc rủi ro đã biết của module (luồng
nhạy cảm, hay bị chậm...):

- `developer:security-auditor` — injection, auth, rò rỉ secret, OWASP Top 10.
- `developer:performance-profiler` — bottleneck, N+1 query, memory leak.

Có thể chạy song song hai agent này vì độc lập nhau.

## Bước 5 — Cập nhật RTM (nếu có)

Dự án đã có RTM từ giai đoạn Requirements Analysis → gọi
`developer:rtm-manager` để nối ID yêu cầu với test case/kết quả test vừa có.
Không có RTM → bỏ qua.

## Bước 6 — Tổng hợp

```
# Verification & Testing: <phạm vi>

## Coverage
...

## Test đã bổ sung
...

## Flaky test
...

## Bảo mật & hiệu năng
...

## Không kiểm tra được
<agent lỗi, thiếu môi trường...>

## Bước tiếp theo đề xuất
`/developer:release-deployment` khi tất cả hạng mục trên đã đạt tiêu chí ra
(exit criteria) của Test Plan.
```
