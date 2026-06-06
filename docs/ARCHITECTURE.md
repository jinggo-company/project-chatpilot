# ARCHITECTURE.md — ChatPilot 架构设计

## 模块概览

```
┌─────────────────────────────────────────────────┐
│                  ChatPilot                       │
├────────────┬──────────────┬─────────────────────┤
│  RAGFlow   │  Knowledge   │  WeChat Bridge      │
│  Core      │  Base Engine │                     │
│            │              │                     │
│ • Chat API │ • Document   │ • WeChat XML parser │
│ • Embedding│   parser     │ • Token verification│
│ • Retrieval│ • Chunking   │ • Message routing   │
│ • Ranking  │ • Vector DB  │ • Reply generator   │
├────────────┴──────────────┴─────────────────────┤
│              Multi-Tenant Layer                  │
├─────────────┬──────────────┬─────────────────────┤
│  Tenant DB  │  Tenant ES   │  Tenant Redis/MinIO │
│  Schemas    │  Indices     │  Buckets            │
│             │              │                     │
│ schema:     │ index prefix:│ key/bucket prefix: │
│ tenant_<id> │ chatpilot_   │ chatpilot-         │
├─────────────┴──────────────┴─────────────────────┤
│                  Infrastructure                  │
├─────────────┬──────────────┬─────────────────────┤
│  MySQL      │  Elasticsearch│  Redis + MinIO      │
└─────────────┴──────────────┴─────────────────────┘
```

## PRD AC 映射

| AC | 架构覆盖 | 实现位置 |
|----|----------|----------|
| AC-1 | RAGFlow 部署 | docker-compose.yml |
| AC-2 | 微信公众号接入 | integrations/wechat/ |
| AC-4 | 知识库解析 | RAGFlow 原生能力 |
| AC-6 | 多租户 SaaS 架构 | config/tenant.yaml, db/multi-tenant-init.sql, scripts/setup-tenant.sh |
