# HubSpot Flutter Plugin

The `hubspot_flutter` plugin allows you to integrate HubSpot's mobile chat SDK into your Flutter app, enabling real-time, in-app customer support for both Android and iOS.

## Installation

### Known Issues

- **iOS**: iOS support is currently being implemented. The plugin only supports Android for now.

### 1. Add the Dependency

Add `hubspot_flutter` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  hubspot_flutter:
    git:
      url: https://github.com/shuttlershq/hubspot_flutter.git
      ref: dev
```

### 2. iOS Setup

- Make sure your iOS deployment target is set to 11.0 or higher in your ios/Podfile.
- Add the HubSpot-Info.plist file to your iOS project under ios/Runner.

### 3. Android Setup

- Ensure your minSdkVersion is set to 21 or higher in your android/app/build.gradle file.
- Place your google-services.json in the android/app/ directory.
- Place your hubspot-info.json in the android/app/src/main/assets/ directory.
- **Update the `AndroidManifest.xml`**:
> In your app’s `AndroidManifest.xml` file, ensure that you add the following line in the `<application>` tag to apply the appropriate theme.
> You can also specify your custom app theme here
```xml
<application
    android:theme="@style/Theme.AppCompat.Light"
    ... >
```



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

# Warning

```sh
/.../AndroidManifest.xml Error:
	uses-sdk:minSdkVersion 21 cannot be smaller than version 26 declared in library [com.hubspot.mobilechatsdk:mobile-chat-sdk-android:1.0.3] /Users/codefarmer/.gradle/caches/transforms-3/cc158e89eb26b58120b42c3d31b601f0/transformed/jetified-mobile-chat-sdk-android-1.0.3/AndroidManifest.xml as the library might be using APIs not available in 21
	Suggestion: use a compatible library with a minSdk of at most 21,
		or increase this project's minSdk version to at least 26,
		or use tools:overrideLibrary="com.hubspot.mobilesdk" to force usage (may lead to runtime failures)
```