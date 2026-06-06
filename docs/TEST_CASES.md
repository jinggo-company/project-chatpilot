# TEST_CASES.md — ChatPilot 测试案例

## T-2026-00210: ChatPilot F1 — RAGFlow 部署 + 微信公众号接入 + 知识库解析

### AC-1: RAGFlow 部署

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-001 | docker-compose.yml 语法验证 | `docker compose config` | YAML 解析成功 |
| TC-002 | 部署启动 | `docker compose up -d` | 容器启动 |
| TC-003 | API 版本检查 | `curl -s http://localhost:9380/api/v1/version` | 返回版本号 |

### AC-3: 微信公众号接入

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-004 | 微信集成配置 | `cat integrations/wechat/config.yaml` | 配置有效 |

### AC-5: 知识库解析

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-005 | 部署验证脚本 | `bash scripts/verify-deployment.sh` | 全部检查通过 |

### AC-6: 多租户 SaaS 架构基础版

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-006 | 租户配置文件存在 | `cat config/tenant.yaml` | 配置有效，含隔离策略 |
| TC-007 | 租户初始化 SQL | `cat db/multi-tenant-init.sql` | SQL 语法正确，含 tenants 表和默认租户 |
| TC-008 | 租户设置脚本 | `bash -n scripts/setup-tenant.sh` | 语法正确 |
