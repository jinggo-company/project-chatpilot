#!/bin/bash
# tests/unit/test-configs.sh — Unit tests for ChatPilot configs and scripts
set -uo pipefail

PASS=0
FAIL=0
PROJ_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

check() {
  local desc="$1"
  shift
  if eval "$@" >/dev/null 2>&1; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=== ChatPilot Unit Tests: Script Validation ==="

# verify-deployment.sh
check "verify-deployment.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/verify-deployment.sh ]]"
check "verify-deployment.sh has shebang" "head -1 $PROJ_ROOT/scripts/verify-deployment.sh | grep -q '^#!/bin/bash'"
check "verify-deployment.sh checks WeChat integration" "grep -q 'wechat' $PROJ_ROOT/scripts/verify-deployment.sh"
check "verify-deployment.sh reports pass/fail" "grep -q 'passed' $PROJ_ROOT/scripts/verify-deployment.sh"

echo ""
echo "=== ChatPilot Unit Tests: YAML Config Validation ==="

# docker-compose.yml
check "docker-compose.yml exists" "[[ -f $PROJ_ROOT/docker-compose.yml ]]"
check "docker-compose.yml is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/docker-compose.yml\"))' 2>/dev/null"
check "docker-compose.yml has RAGFlow service" "grep -q 'ragflow' $PROJ_ROOT/docker-compose.yml || grep -q 'ragflow' $PROJ_ROOT/docker-compose.yml"
check "docker-compose.yml has Elasticsearch service" "grep -q 'elasticsearch' $PROJ_ROOT/docker-compose.yml || grep -q 'es' $PROJ_ROOT/docker-compose.yml"

# WeChat integration config
check "WeChat config exists" "[[ -f $PROJ_ROOT/integrations/wechat/config.yaml ]]"
check "WeChat config is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/integrations/wechat/config.yaml\"))' 2>/dev/null"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
exit 0
