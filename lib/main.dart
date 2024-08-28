import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/splash_screen.dart';

void main() async {
  //initialize the hive
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do application model',
      //supportedLocales: L10n.all,
      theme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.yellow),
//darkTheme: ThemeData(brightness: Brightness.dark),
      // themeMode: ThemeMode.light,

      home: SplashScreen(),
    );
  }
}
