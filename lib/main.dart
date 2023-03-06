import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/head.dart';

import 'Services/local_notification.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  var box = await Hive.openBox('NewToDoBox');
  //box.deleteFromDisk();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.amber,

      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HeadPage(0),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/view': (context) => HeadPage(0),
      },

      
    );
  }
}

