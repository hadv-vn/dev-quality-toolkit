---
name: release-deployment
description: >
  Điều phối giai đoạn đóng gói, phát hành và triển khai: tổng hợp changelog,
  tối ưu/review cấu hình hạ tầng (Docker/IaC) nếu có thay đổi, sửa CI đang
  fail, kiểm tra pre-flight trước deploy, rồi tổng hợp thành checklist
  go/no-go + kế hoạch rollback. Dùng khi người dùng gõ
  /developer:release-deployment hoặc đang chuẩn bị phát hành một phiên bản cụ
  thể.
argument-hint: "[version/phạm vi release, ví dụ v2.3.0 hoặc tag gần nhất tới HEAD]"
disable-model-invocation: true
allowed-tools: Bash(git log:*), Bash(git tag:*), Bash(git diff:*)
---

# Release & Deployment

Phạm vi release (có thể trống → hỏi lại version/mốc so sánh): $ARGUMENTS

Skill này điều phối, KHÔNG tự thực hiện deploy hay tạo tag/push. Mọi hành
động thật (deploy, tag, push) chỉ thực hiện khi người dùng yêu cầu rõ ràng ở
ngoài phạm vi skill này.

## Bước 1 — Changelog

Gọi `developer:changelog-writer` để tổng hợp thay đổi từ mốc trước tới HEAD
(hoặc theo `$ARGUMENTS` nếu có tag cụ thể).

## Bước 2 — Hạ tầng & container (nếu có thay đổi)

- Diff có Dockerfile thay đổi → `developer:docker-optimizer`.
- Diff có Terraform/K8s/Helm/CloudFormation thay đổi →
  `developer:iac-reviewer`.
- Không có thay đổi loại này → bỏ qua, không chạy cho đủ bộ.

## Bước 3 — CI

Pipeline CI đang fail → `developer:ci-fixer` TRƯỚC khi tiếp tục các bước
sau (không có ý nghĩa lập kế hoạch release trên một pipeline đang fail).

## Bước 4 — Pre-flight check

Gọi `developer:deployment-validator` để kiểm tra env var, secret hardcode,
health check, resource limit trước khi deploy thật.

## Bước 5 — Checklist go/no-go

Gọi `developer:release-manager` với toàn bộ kết quả Bước 1-4 làm input, yêu
cầu xuất checklist go/no-go, thứ tự deploy, và kế hoạch rollback.

## Bước 6 — Tổng hợp

```
# Release & Deployment: <version/phạm vi>

## Changelog
...

## Hạ tầng/CI
...

## Pre-flight
...

## Checklist go/no-go (từ release-manager)
...

## Bước tiếp theo đề xuất
Thực hiện deploy theo checklist trên (ngoài phạm vi skill này); sau khi lên
production ổn định, dùng `/developer:operation-maintenance` để theo dõi.
```
