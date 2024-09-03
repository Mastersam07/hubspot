
import 'hubspot_flutter_platform_interface.dart';

class HubspotFlutter {
  Future<String?> getPlatformVersion() {
    return HubspotFlutterPlatform.instance.getPlatformVersion();
  }
}
