import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Hubspot {
  static const MethodChannel _channel = MethodChannel('hubspot');
  static const MethodChannel _logger = MethodChannel('hubspot_logs');

  static Future<void> initialize() async {
    _logger.setMethodCallHandler((call) async {
      if (call.method == 'log') {
        debugPrint('[HubSpot] ${call.arguments}');
      }
    });
    await _channel.invokeMethod('initialize');
  }

  static Future<void> openChat() async {
    await _channel.invokeMethod('openChat');
  }

  static Future<void> setUserIdentity(
      String email, String identityToken) async {
    await _channel.invokeMethod('setUserIdentity', {
      'email': email,
      'identityToken': identityToken,
    });
  }

  static Future<void> setChatProperties(Map<String, String> properties) async {
    await _channel.invokeMethod('setChatProperties', {
      'properties': properties,
    });
  }

  static Future<void> logout() async {
    await _channel.invokeMethod('logout');
  }
}
