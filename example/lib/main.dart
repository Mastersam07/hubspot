import 'package:flutter/material.dart';
import 'package:hubspot_flutter/hubspot_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HubSpot Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initializeHubSpot();
  }

  Future<void> initializeHubSpot() async {
    try {
      await HubspotFlutter.initialize();
      print("HubSpot SDK initialized.");
    } catch (e) {
      print("Error initializing HubSpot SDK: $e");
    }
  }

  void openChat() async {
    try {
      await HubspotFlutter.openChat();
      print("Chat opened.");
    } catch (e) {
      print("Error opening chat: $e");
    }
  }

  void setUserIdentity() async {
    try {
      await HubspotFlutter.setUserIdentity(
          "user@example.com", "identityToken123");
      print("User identity set.");
    } catch (e) {
      print("Error setting user identity: $e");
    }
  }

  void setChatProperties() async {
    try {
      await HubspotFlutter.setChatProperties({
        "CameraPermissions": "false",
        "PhotoPermissions": "false",
        "NotificationPermissions": "false",
        "LocationPermissions": "false"
      });
      print("Chat properties set.");
    } catch (e) {
      print("Error setting chat properties: $e");
    }
  }

  void logout() async {
    try {
      await HubspotFlutter.logout();
      print("Logged out.");
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HubSpot Flutter Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: openChat,
                child: const Text("Open Chat"),
              ),
              ElevatedButton(
                onPressed: setUserIdentity,
                child: const Text("Set User Identity"),
              ),
              ElevatedButton(
                onPressed: setChatProperties,
                child: const Text("Set Chat Properties"),
              ),
              ElevatedButton(
                onPressed: logout,
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
