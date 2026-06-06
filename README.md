# project-chatpilot

> ChatPilot — 基于 RAGFlow 的智能客服平台（微信公众号接入 + 知识库解析）

## 状态
- **Phase:** `dev`
- **Project ID:** P-2026-00031
- **Lead Dev:** quanchen

## 概述
ChatPilot 基于 RAGFlow 构建，提供微信公众号接入能力和知识库自动解析能力。

## 本地运行
```bash
docker compose up -d
sleep 60
curl http://localhost:9380/api/v1/version
```
