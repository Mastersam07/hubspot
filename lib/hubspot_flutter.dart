import 'package:flutter/services.dart';

class HubspotFlutter {
  static const MethodChannel _channel = MethodChannel('hubspot_flutter');

  static Future<void> initialize() async {
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
