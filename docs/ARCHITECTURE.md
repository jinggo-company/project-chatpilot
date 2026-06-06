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
│                  Infrastructure                  │
├─────────────┬──────────────┬─────────────────────┤
│  MySQL      │  Elasticsearch│  Redis + MinIO      │
└─────────────┴──────────────┴─────────────────────┘
```

## PRD AC 映射

| AC | 架构覆盖 | 实现位置 |
|----|----------|----------|
| AC-1 | RAGFlow 部署 | docker-compose.yml |
| AC-3 | 微信公众号接入 | integrations/wechat/ |
| AC-5 | 知识库解析 | scripts/ |
