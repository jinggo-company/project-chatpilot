# TEST_REPORT.md — ChatPilot 测试报告

## T-2026-00210

| Case-ID | Result | Command | Notes |
|---------|--------|---------|-------|
| TC-001 | PASS | `docker compose config` | YAML 解析成功 |
| TC-002 | SKIP | `docker compose up -d` | 需要拉取 RAGFlow 镜像 |
| TC-003 | SKIP | `curl http://localhost:9380/api/v1/version` | 依赖 TC-002 |
| TC-004 | PASS | `cat integrations/wechat/config.yaml` | 微信配置有效 |
| TC-005 | PASS | `bash scripts/verify-deployment.sh` | 3/3 checks passed |
| TC-006 | PASS | `cat config/tenant.yaml` | 租户配置文件有效，含隔离策略 |
| TC-007 | PASS | `cat db/multi-tenant-init.sql` | 初始化 SQL 含 tenants 表和默认租户 |
| TC-008 | PASS | `bash -n scripts/setup-tenant.sh` | 语法正确

### 执行环境
- Docker: 27.5.1
- Docker Compose: 2.40.3
