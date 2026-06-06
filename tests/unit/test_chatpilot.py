"""
ChatPilot unit tests — wrapper for config/script validation.
"""
import subprocess
import os
import unittest

PROJ_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class TestChatPilotScripts(unittest.TestCase):
    """Test that all ChatPilot scripts exist and are well-formed."""

    def test_verify_deployment_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, "scripts/verify-deployment.sh")))

    def test_verify_has_shebang(self):
        with open(os.path.join(PROJ_ROOT, "scripts/verify-deployment.sh")) as f:
            self.assertTrue(f.readline().startswith("#!/bin/bash"))

    def test_verify_checks_wechat(self):
        with open(os.path.join(PROJ_ROOT, "scripts/verify-deployment.sh")) as f:
            content = f.read()
            self.assertIn("wechat", content)


class TestChatPilotConfigs(unittest.TestCase):
    """Test that ChatPilot YAML configs are valid."""

    def _import_yaml(self):
        try:
            import yaml
            return yaml
        except ImportError:
            self.skipTest("PyYAML not installed")

    def test_docker_compose_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "docker-compose.yml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)

    def test_wechat_config_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "integrations/wechat/config.yaml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)


if __name__ == "__main__":
    unittest.main()
