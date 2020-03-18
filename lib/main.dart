import 'package:KimochiAdmin/DetailOrder.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:core';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Cabang.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KimochiAdmin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: Sp(),
    );
  }
}

class Sp extends StatelessWidget {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  initState() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }

    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => DetailOrder(payload)),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Cabang(),
      title: Text(
        "",
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'Bangers-Regular',
          color: Color.fromRGBO(243, 156, 18, 20),
          // fontWeight: FontWeight.bold,
        ),
      ),
      // image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      image: Image.asset("assets/logo.jpg"),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("KimochiAdmin"),
      loaderColor: Colors.red,
    );
  }
}