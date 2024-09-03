import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hubspot_flutter_method_channel.dart';

abstract class HubspotFlutterPlatform extends PlatformInterface {
  /// Constructs a HubspotFlutterPlatform.
  HubspotFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static HubspotFlutterPlatform _instance = MethodChannelHubspotFlutter();

  /// The default instance of [HubspotFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelHubspotFlutter].
  static HubspotFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HubspotFlutterPlatform] when
  /// they register themselves.
  static set instance(HubspotFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
