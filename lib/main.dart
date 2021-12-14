import 'package:alemeno_sarthak/constants.dart';
import 'package:alemeno_sarthak/views/click_pic.dart';
import 'package:alemeno_sarthak/views/home.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "key",
      channelName: "Alemeno_Sarthak",
      channelDescription: "Alemeno",
      defaultColor: Constants().mainGreen,
      enableLights: true,
      ledColor: Colors.white,
      playSound: true,
      enableVibration: true,
    )
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alemeno Sarthak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: <String, WidgetBuilder>{
        '/click_pic': (BuildContext context) => const ClickPicPage(),
      },
    );
  }
}
