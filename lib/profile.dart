import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/database/db_functions.dart';
import 'package:todo/login_new.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? userName;

  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'user';
    });
  }

  Future<void> showUsernamePasswordDialog(BuildContext context) async {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter New Username and Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String username = usernameController.text.trim();
                String password = passwordController.text.trim();

                if (username.isEmpty || password.isEmpty) {
                  const snackBar = SnackBar(
                    content: Text('Username and password cannot be empty!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return; // Do not proceed further
                }

                // Store username and password in shared preferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('username', username);
                await prefs.setString('password', password);

                const snackBar = SnackBar(
                  content: Text('Username and password changed!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                setState(() {
                  savedata(false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginNew()),
                  );
                }); // Close the dialog
              },
              child: Text('Save changes'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('You sure want to Logout?'),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: Text('Logout'),
                  onPressed: () {
                    savedata(false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginNew()),
                    );
                  },
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 14, 48, 65),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      child: Container(
                        width: 110, // Adjust the size according to the radius
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(
                                255, 14, 48, 65), // Set the border color
                            width: 4.0, // Adjust the border width
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/profile.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20, // Space between the avatar and the text
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$userName',
                          style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 14, 48, 65)),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: Text('Change Username and Password'),
                    onTap: () => showUsernamePasswordDialog(context),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: Text('Logout'),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
