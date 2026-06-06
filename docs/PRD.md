# ChatPilot — PRD v1

## 需求概述
ChatPilot 是基于 RAGFlow 的智能知识库问答平台，提供微信公众号接入、多格式知识库解析和多租户 SaaS 架构。

## 验收标准 (AC)
- AC-1: RAGFlow Docker Compose 部署（含 Elasticsearch）
- AC-2: 微信公众号消息接入（Mock Webhook 验证链路）
- AC-4: 知识库自动解析引擎（PDF/Word 多格式导入）
- AC-6: 多租户 SaaS 架构基础版

## 测试场景

### 场景 1：部署验证
1. docker compose up -d 启动全栈服务
2. curl http://localhost:9380/api/v1/version 返回版本信息

### 场景 2：微信公众号消息
1. 配置 App ID 和 Token
2. 发送测试消息到公众号，验证回调触发
