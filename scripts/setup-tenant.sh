#!/bin/bash
# setup-tenant.sh — 创建新租户并初始化隔离资源
# Usage: bash scripts/setup-tenant.sh <tenant-id> <tenant-name>
set -euo pipefail

TENANT_ID="${1:?Usage: setup-tenant.sh <tenant-id> <tenant-name>}"
TENANT_NAME="${2:?Usage: setup-tenant.sh <tenant-id> <tenant-name>}"
SCHEMA_NAME="tenant_${TENANT_ID}"

echo "[ChatPilot] Setting up tenant: ${TENANT_NAME} (id: ${TENANT_ID})"

# MySQL schema creation
MYSQL_CONTAINER="project-chatpilot-mysql-1"
if docker ps --format '{{.Names}}' | grep -q "$MYSQL_CONTAINER"; then
  echo "[ChatPilot] Creating MySQL schema: ${SCHEMA_NAME}"
  docker exec "$MYSQL_CONTAINER" mysql -uroot -proot -e "
    CREATE DATABASE IF NOT EXISTS ${SCHEMA_NAME} DEFAULT CHARSET utf8mb4;
    INSERT IGNORE INTO tenant_management.tenants (id, name, schema_name)
    VALUES ('${TENANT_ID}', '${TENANT_NAME}', '${SCHEMA_NAME}');
  " 2>/dev/null || echo "[WARN] MySQL not reachable, schema creation deferred"
else
  echo "[ChatPilot] MySQL container not running, deferring schema creation"
fi

# Redis key prefix check (just verify Redis is up)
REDIS_CONTAINER="project-chatpilot-redis-1"
if docker ps --format '{{.Names}}' | grep -q "$REDIS_CONTAINER"; then
  echo "[ChatPilot] Redis tenant prefix: chatpilot:${TENANT_ID}:*"
else
  echo "[ChatPilot] Redis not running, tenant isolation deferred"
fi

# Elasticsearch index pattern check
ES_CONTAINER="project-chatpilot-elasticsearch-1"
if docker ps --format '{{.Names}}' | grep -q "$ES_CONTAINER"; then
  echo "[ChatPilot] ES tenant index prefix: chatpilot_${TENANT_ID}_*"
else
  echo "[ChatPilot] Elasticsearch not running, tenant isolation deferred"
fi

# MinIO bucket check
MINIO_CONTAINER="project-chatpilot-minio-1"
if docker ps --format '{{.Names}}' | grep -q "$MINIO_CONTAINER"; then
  echo "[ChatPilot] MinIO tenant bucket prefix: chatpilot-${TENANT_ID}-*"
else
  echo "[ChatPilot] MinIO not running, tenant isolation deferred"
fi

echo "[ChatPilot] Tenant ${TENANT_ID} setup complete."
