-- Multi-tenant SaaS schema for ChatPilot
-- Run this to initialize tenant management tables

-- Tenant management table
CREATE DATABASE IF NOT EXISTS tenant_management;
USE tenant_management;

CREATE TABLE IF NOT EXISTS tenants (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    schema_name VARCHAR(64) NOT NULL UNIQUE,
    status ENUM('active', 'suspended', 'deleted') DEFAULT 'active',
    max_users INT DEFAULT 100,
    max_datasets INT DEFAULT 50,
    storage_quota_mb BIGINT DEFAULT 5120,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tenant users mapping
CREATE TABLE IF NOT EXISTS tenant_users (
    id VARCHAR(36) PRIMARY KEY,
    tenant_id VARCHAR(36) NOT NULL,
    username VARCHAR(64) NOT NULL,
    email VARCHAR(128),
    role ENUM('admin', 'editor', 'viewer') DEFAULT 'viewer',
    status ENUM('active', 'suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    UNIQUE KEY uk_tenant_user (tenant_id, username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert default tenant
INSERT IGNORE INTO tenants (id, name, schema_name, max_users, max_datasets, storage_quota_mb)
VALUES ('default', '默认租户', 'tenant_default', 100, 50, 5120);

-- Create default tenant schema
CREATE DATABASE IF NOT EXISTS tenant_default;
