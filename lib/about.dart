import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us',style: TextStyle(color: Colors.white),),
         iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        backgroundColor: Color.fromARGB(255, 14, 48, 65),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                  "Welcome to TaskTrack , a TaskTrack app designed to help you manage your tasks and stay organized. We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our app. We believe that productivity should be effortless. That's why we've created an intuitive and user-friendly platform that allows you to quickly add, organize, and track your tasks from anywhere. Our goal is to empower you to stay focused and get things done, without the clutter or complexity.",style: TextStyle(fontSize: 15),),
              SizedBox(
                height: 50,
              ),
              Text(
                "What We Do",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                  "At TaskTrack, we believe that great productivity tools should be simple, smart, and fun to use. That’s why we’ve poured our hearts into creating an app that’s not only easy to navigate but also packed with features that help you stay on top of your game.",style: TextStyle(fontSize: 15),),
              SizedBox(
                height: 30,
              ),
                Text(
                "Developed By",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
                Text(
                "Developed By - ABHIJITH R, ABHISHEK SURESH, AKHIL PRAKASH, AKHIL NAIR M, RAHUL JACOB THOMAS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Institute - ST BERCHMANS COLLEGE, CHANGANASHERRY",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
               Text("Course - Bachelor of Computer Application(BCA)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
               Text("Semester - 5",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Join Us",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                  "We’re always eager to connect with our users. Got feedback or a feature request? We want to hear from you! Drop us a line at 'tasktrack@todo.com' and let’s chat.",style: TextStyle(fontSize: 15),),
              SizedBox(
                height: 50,
              ),
              Text(
                  "Thank you for choosing TaskTrack. Here’s to achieving great things together!")
            ],
          ),
        ),
      ),
    );
  }
}
