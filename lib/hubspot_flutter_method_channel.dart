import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hubspot_flutter_platform_interface.dart';

/// An implementation of [HubspotFlutterPlatform] that uses method channels.
class MethodChannelHubspotFlutter extends HubspotFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hubspot_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
