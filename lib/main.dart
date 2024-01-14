import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( //to change the top sys tray color
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,//to remove dat "debug" text
      title: 'ToDo App',
      home: Home(),
    );
  }
}
