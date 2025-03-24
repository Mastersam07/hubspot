import 'package:flutter/material.dart';
import 'package:hubspot/hubspot.dart';

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
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initializeHubSpot();
  }

  Future<void> initializeHubSpot() async {
    try {
      await Hubspot.initialize();
      debugPrint("HubSpot SDK initialized.");
    } catch (e) {
      debugPrint("Error initializing HubSpot SDK: $e");
    }
  }

  void openChat() async {
    try {
      await Hubspot.openChat();
      debugPrint("Chat opened.");
    } catch (e) {
      debugPrint("Error opening chat: $e");
    }
  }

  void setUserIdentity() async {
    try {
      await Hubspot.setUserIdentity(
          "user@example.com", "identityToken123");
      debugPrint("User identity set.");
    } catch (e) {
      debugPrint("Error setting user identity: $e");
    }
  }

  void setChatProperties() async {
    try {
      await Hubspot.setChatProperties({
        "CameraPermissions": "false",
        "PhotoPermissions": "false",
        "NotificationPermissions": "false",
        "LocationPermissions": "false"
      });
      debugPrint("Chat properties set.");
    } catch (e) {
      debugPrint("Error setting chat properties: $e");
    }
  }

  void logout() async {
    try {
      await Hubspot.logout();
      debugPrint("Logged out.");
    } catch (e) {
      debugPrint("Error during logout: $e");
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
