import 'package:arsivbox/Screens/wrapper.dart';
import 'package:arsivbox/models/user.dart';
import 'package:arsivbox/service/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await init();
  runApp(MyApp());
}

FirebaseMessaging firebaseMessaging = FirebaseMessaging();

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseMessaging.requestNotificationPermissions();
  final token = await firebaseMessaging.getToken();
  print(token);
  
  firebaseMessaging.configure(
      onLaunch: (message) {
        print("OnLAUNCH $message");

        return Future.value(true);
      },
      onMessage: (message) {
        print("OnMessage $message");
        return Future.value(true);
      },
      onResume: (message) {
        print("OnResume $message");
        return Future.value(true);
      },
    );
    await firebaseMessaging.subscribeToTopic("topics-all");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
