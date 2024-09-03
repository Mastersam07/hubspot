# HubSpot Flutter Plugin

The `hubspot_flutter` plugin allows you to integrate HubSpot's mobile chat SDK into your Flutter app, enabling real-time, in-app customer support for both Android and iOS.

## Installation

### 1. Add the Dependency

Add `hubspot_flutter` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  hubspot_flutter:
    git:
      url: https://github.com/your-repo/hubspot_flutter.git
      ref: dev
```

### 2. iOS Setup

- Make sure your iOS deployment target is set to 11.0 or higher in your ios/Podfile.
- Add the HubSpot-Info.plist file to your iOS project under ios/Runner.

### 3. Android Setup

- Ensure your minSdkVersion is set to 21 or higher in your android/app/build.gradle file.
- Place your google-services.json in the android/app/ directory.
- Place your hubspot-info.json in the android/app/src/main/assets/ directory.


## Usage

### Initialize the SDK

Before using any chat functionality, initialize the SDK:

```dart
import 'package:hubspot_flutter/hubspot_flutter.dart';

await HubspotFlutter.initialize();
```

### Open Chat

To open the chat view, use:

```dart
await HubspotFlutter.openChat();
```

### Set User Identity

Identify a user with their email and identity token:

```dart
await HubspotFlutter.setUserIdentity(email: "user@example.com", identityToken: "identityToken123");
```

### Set Chat Properties

Set custom properties for the chat session:

```dart
await HubspotFlutter.setChatProperties({
  "CameraPermissions": "false",
  "PhotoPermissions": "false",
  "NotificationPermissions": "false",
});
```

### Clear User Data

Clear user data on logout:

```dart
await HubspotFlutter.logout();
```

## Example
Refer to the example directory for a complete implementation example.

## Contributing
Feel free to submit issues and pull requests for improvements. Contributions to enhance the plugin's functionality are welcome.