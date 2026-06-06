#!/bin/bash
# verify-deployment.sh — ChatPilot 部署验证
set -uo pipefail

PASS=0
FAIL=0

check() {
  local desc="$1"
  shift
  if eval "$@"; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=========================================="
echo " ChatPilot Deployment Verification"
echo "=========================================="

check "docker-compose.yml exists" "[[ -f docker-compose.yml ]]"
check "WeChat integration exists" "[[ -f integrations/wechat/config.yaml ]]"

if command -v docker &>/dev/null; then
  check "docker compose config valid" "cd $PWD && docker compose config > /dev/null 2>&1"
fi

echo "=========================================="
echo " Results: $PASS passed, $FAIL failed"
echo "=========================================="

[ "$FAIL" -gt 0 ] && exit 1
exit 0
