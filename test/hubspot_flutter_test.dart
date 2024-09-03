import 'package:flutter_test/flutter_test.dart';
import 'package:hubspot_flutter/hubspot_flutter.dart';
import 'package:hubspot_flutter/hubspot_flutter_platform_interface.dart';
import 'package:hubspot_flutter/hubspot_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHubspotFlutterPlatform
    with MockPlatformInterfaceMixin
    implements HubspotFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HubspotFlutterPlatform initialPlatform = HubspotFlutterPlatform.instance;

  test('$MethodChannelHubspotFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHubspotFlutter>());
  });

  test('getPlatformVersion', () async {
    HubspotFlutter hubspotFlutterPlugin = HubspotFlutter();
    MockHubspotFlutterPlatform fakePlatform = MockHubspotFlutterPlatform();
    HubspotFlutterPlatform.instance = fakePlatform;

    expect(await hubspotFlutterPlugin.getPlatformVersion(), '42');
  });
}
