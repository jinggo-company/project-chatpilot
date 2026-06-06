# TECH_STACK.md — ChatPilot 技术栈

## 核心技术

| 组件 | 版本 | 说明 |
|------|------|------|
| RAGFlow | 0.15+ | RAG 引擎（核心） |
| Docker Compose | 2.20+ | 容器编排部署 |
| Elasticsearch | 8.x | 向量检索 |
| MySQL | 8.0 | 数据存储 |
| Redis | 7 | 缓存 |
| MinIO | latest | 对象存储 |

## 微信公众号集成
- 消息格式: XML
- 认证: Token + EncodingAESKey
- 被动回复

## 知识库解析
- 支持格式: PDF, Word, Excel, TXT, Markdown
- 解析引擎: RAGFlow Document Parser
- 分块策略: 语义分块

## 多租户 SaaS
- 隔离模式: Schema 级别（MySQL 独立 schema）
- 租户管理: tenant_management 数据库
- 数据隔离:
  - MySQL: tenant_<id> schema
  - Elasticsearch: chatpilot_<id>_ 索引前缀
  - Redis: chatpilot:<id>: key 前缀
  - MinIO: chatpilot-<id>- bucket 前缀
- 租户初始化: db/multi-tenant-init.sql + scripts/setup-tenant.sh
