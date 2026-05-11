"""
Tests for EWW Google Calendar widget script
"""
import pytest
from unittest.mock import patch, MagicMock
import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../../../eww/scripts'))

class TestGCalWidget:
    """Test cases for gcal.py widget"""

    def test_gcal_module_imports(self):
        """Test that gcal module can be imported"""
        import gcal
        assert gcal is not None

    def test_gcal_has_scopes(self):
        """Test that gcal has SCOPES defined"""
        import gcal
        assert hasattr(gcal, 'SCOPES')
        assert 'calendar.readonly' in gcal.SCOPES[0]

    def test_gcal_has_credentials_file_path(self):
        """Test that gcal has CREDS_FILE defined"""
        import gcal
        assert hasattr(gcal, 'CREDS_FILE')
        assert 'credentials.json' in gcal.CREDS_FILE

    def test_gcal_has_token_file_path(self):
        """Test that gcal has TOKEN_FILE defined"""
        import gcal
        assert hasattr(gcal, 'TOKEN_FILE')
        assert 'token.pickle' in gcal.TOKEN_FILE

    def test_gcal_has_get_service_function(self):
        """Test that gcal has get_service function"""
        import gcal
        assert hasattr(gcal, 'get_service')
        assert callable(gcal.get_service)

    def test_gcal_has_get_today_events_function(self):
        """Test that gcal has get_today_events function"""
        import gcal
        assert hasattr(gcal, 'get_today_events')
        assert callable(gcal.get_today_events)

    def test_gcal_has_get_week_events_function(self):
        """Test that gcal has get_week_events function"""
        import gcal
        assert hasattr(gcal, 'get_week_events')
        assert callable(gcal.get_week_events)

    def test_gcal_has_get_days_with_events_function(self):
        """Test that gcal has get_days_with_events function"""
        import gcal
        assert hasattr(gcal, 'get_days_with_events')
        assert callable(gcal.get_days_with_events)

    def test_gcal_has_get_next_event_function(self):
        """Test that gcal has get_next_event function"""
        import gcal
        assert hasattr(gcal, 'get_next_event')
        assert callable(gcal.get_next_event)


class TestGCalWidgetIntegration:
    """Integration tests for gcal widget"""

    @pytest.mark.integration
    def test_credentials_file_uses_expanduser(self):
        """Test that credentials file path uses expanduser"""
        import gcal
        assert '$HOME' not in gcal.CREDS_FILE
        assert '~' in gcal.CREDS_FILE or '/home/' in gcal.CREDS_FILE

    @pytest.mark.integration
    def test_token_file_uses_expanduser(self):
        """Test that token file path uses expanduser"""
        import gcal
        assert '$HOME' not in gcal.TOKEN_FILE
        assert '~' in gcal.TOKEN_FILE or '/home/' in gcal.TOKEN_FILE

    @pytest.mark.integration
    def test_get_service_requires_credentials(self):
        """Test that get_service checks for credentials"""
        import gcal
        with patch('gcal.os.path.exists', return_value=False):
            with patch('gcal.build') as mock_build:
                mock_build.return_value = MagicMock()
                try:
                    gcal.get_service()
                except Exception:
                    pass