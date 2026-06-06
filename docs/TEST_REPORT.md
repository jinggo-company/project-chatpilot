# TEST_REPORT.md — ChatPilot 测试报告

## T-2026-00210

| Case-ID | Result | Command | Notes |
|---------|--------|---------|-------|
| TC-001 | PASS | `docker compose config` | YAML 解析成功 |
| TC-002 | SKIP | `docker compose up -d` | 需要拉取 RAGFlow 镜像 |
| TC-003 | SKIP | `curl http://localhost:9380/api/v1/version` | 依赖 TC-002 |
| TC-004 | PASS | `cat integrations/wechat/config.yaml` | 微信配置有效 |
| TC-005 | PASS | `bash scripts/verify-deployment.sh` | 3/3 checks passed |

### 执行环境
- Docker: 27.5.1
- Docker Compose: 2.40.3
