import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/database/db_functions.dart';
import 'package:todo/homescreen.dart';
import 'login_new.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveTo();
  }

  Future<void> moveTo() async {
    await Future.delayed(Duration(seconds: 3));
    //checking shared_prefs is user logined
    var islogin = await getdata();
    if (islogin == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginNew()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset("assets/task2.json", width: 100, height: 100)),
    );
  }
}
