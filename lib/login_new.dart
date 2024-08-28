import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/database/db_functions.dart';
import 'package:todo/homescreen.dart';

class LoginNew extends StatefulWidget {
  const LoginNew({super.key});

  @override
  State<LoginNew> createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> {
  String? userName;
  String? password;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'user';
      password = prefs.getString('password') ?? '1';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Icon(
                Icons.person_outlined,
                size: 60,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'sign in to continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      labelText: 'User Name',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (userNameController.text == userName &&
                        passwordController.text == password) {
                      //saving user to prefs
                      savedata(true);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Homescreen()),
                      );
                    } else {
                      const snackBar = SnackBar(
                        content: Text('invalid credentials!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 48, 65)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
