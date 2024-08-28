import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/about.dart';
import 'package:todo/database/database.dart';
import 'package:todo/privacy_policy.dart';
import 'package:todo/profile.dart';
import 'package:todo/settings.dart';
import 'package:todo/utilities/dialogbox.dart';
import 'package:todo/utilities/todotile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //retrieving username from shared preference

  String? userName;

  Future<void> _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'user';
    });
  }

  ToDoDataBase db = ToDoDataBase();
  //reference to the box
  final _mybox = Hive.box('mybox');

  @override
  void initState() {
    //load login username
    _loadCredentials();

    //if the db is empty
    if (_mybox.get("TODOLIST") == null) {
      return null;
    } else {
      db.loadData();
    }
    super.initState();
  }

  //text controllers
  final _titlecontroller = TextEditingController();
  final _descripitioncontroller = TextEditingController();
  final _datepicker = TextEditingController();
  final _categorycontroller = TextEditingController();

  //checkbox tapped
  void chekboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  //create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialogbox(
            titlecontorller: _titlecontroller,
            datepicker: _datepicker,
            descriptioncontroller: _descripitioncontroller,
            categorycontroller: _categorycontroller,
            onsave: saveNewTask,
            oncancel: () {
              Navigator.of(context).pop();
              _titlecontroller.clear();
              _categorycontroller.clear();
              _datepicker.clear();
              _descripitioncontroller.clear();
            },
          );
        });
  }

//save new task
  void saveNewTask() {
    String _timenowcontroller =
        DateFormat('kk:mm | yyyy-MM-dd').format(DateTime.now());

    setState(() {
      db.toDoList.add([
        _titlecontroller.text,
        false,
        _categorycontroller.text,
        _datepicker.text,
        _descripitioncontroller.text,
        _timenowcontroller,
      ]);
      _titlecontroller.clear();
      _categorycontroller.clear();
      _datepicker.clear();
      _descripitioncontroller.clear();
    });
    Navigator.of(context).pop();
    const snackBar = SnackBar(
      content: Text('New Task added'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    db.updateData();
  }

  //delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      Navigator.of(context).pop();
      const snackBar = SnackBar(
        content: Text('TASK Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    db.updateData();
  }

  //edit task dialog
  void editTask(index) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Pre-fill the text controllers with the existing task data
        _titlecontroller.text = db.toDoList[index][0];
        _categorycontroller.text = db.toDoList[index][2];
        _datepicker.text = db.toDoList[index][3];
        _descripitioncontroller.text = db.toDoList[index][4];

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 16,
          child: Container(
            width: 400,
            height: 450,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Edit Task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 14, 48, 65),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _titlecontroller,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  DropdownButtonFormField(
                    hint: Text(_categorycontroller.text),
                    value: null,
                    items: [
                      DropdownMenuItem(
                        value: 'High',
                        child: Text('High'),
                      ),
                      DropdownMenuItem(
                        value: 'Medium',
                        child: Text('Medium'),
                      ),
                      DropdownMenuItem(
                        value: 'Low',
                        child: Text('Low'),
                      ),
                    ],
                    onChanged: (value) {
                      _categorycontroller.text = value.toString();
                    },
                    decoration: InputDecoration(
                      labelText: 'Task Priority',
                    ),
                  ),
                  TextField(
                    controller: _datepicker,
                    decoration: InputDecoration(labelText: 'Date'),
                    onTap: () async {
                      DateTime? datetime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2200),
                      );

                      if (datetime != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(datetime);

                        setState(() {
                          _datepicker.text = formattedDate;
                        });
                      }
                    },
                  ),
                  TextField(
                    maxLines: 6,
                    controller: _descripitioncontroller,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _titlecontroller.clear();
                          _categorycontroller.clear();
                          _datepicker.clear();
                          _descripitioncontroller.clear();
                        },
                      ),
                      TextButton(
                        child: Text('Save Changes'),
                        onPressed: () => saveEditedTask(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Save Edited Task
  void saveEditedTask(int index) {
    setState(() {
      db.toDoList[index][0] = _titlecontroller.text;
      db.toDoList[index][2] = _categorycontroller.text;
      db.toDoList[index][3] = _datepicker.text;
      db.toDoList[index][4] = _descripitioncontroller.text;
      // Update the time to the current time when the task was edited
      db.toDoList[index][5] =
          DateFormat('kk:mm | yyyy-MM-dd').format(DateTime.now());
    });

    _titlecontroller.clear();
    _categorycontroller.clear();
    _datepicker.clear();
    _descripitioncontroller.clear();

    Navigator.of(context).pop();
    const snackBar = SnackBar(
      content: Text('Task Edited Successfully'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    db.updateData(); // Save the changes to Hive
  }

  //show detailed view of task
  void tapped(int index) {
    if (index < db.toDoList.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 16,
            child: Container(
              width: 300,
              height: 400,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    db.toDoList[index][0],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 14, 48, 65),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          db.toDoList[index][4],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Priority : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(db.toDoList[index][2]),
                  Text(
                    'Date Created : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(db.toDoList[index][5]),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        style: TextButton.styleFrom(
                          iconColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Edit Task'),
                        style: TextButton.styleFrom(
                          iconColor: Colors.red,
                        ),
                        onPressed: () => editTask(index),
                      ),
                      TextButton(
                        child: Text('Delete Task'),
                        style: TextButton.styleFrom(
                          iconColor: Colors.red,
                        ),
                        onPressed: () => deleteTask(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      print('Index out of range: $index');
    }
  }

  Widget buildheader(BuildContext context) => Column(
        children: [
          Container(
            width: 1000,
            color: Color.fromARGB(255, 14, 48, 65),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, bottom: 40, right: 10, top: 10),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                   
                    Text(
                      '$userName',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      );

  Widget builditems(BuildContext context) => Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                title: Text('Home'),
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Homescreen(),
                    )),
              ),
              ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                    color: Colors.black,
                  ),
                  title: Text('Settings'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      ))),
              ListTile(
                  leading: Icon(
                    Icons.stay_current_portrait_rounded,
                    color: Colors.black,
                  ),
                  title: Text('About Us'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const About(),
                      ))),
              ListTile(
                  leading: Icon(
                    Icons.policy,
                    color: Colors.black,
                  ),
                  title: Text('Privacy policy'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy(),
                      ))),
              ListTile(
                leading: Icon(Icons.notes),
                title: Text('Version'),
                subtitle: Text('version no : 1.0.0'),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 14, 48, 65),
            // centerTitle: true,
            title: Text(
              'TaskTrack',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          drawer: Drawer(
              child: Column(
            children: [
              buildheader(context),
              builditems(context),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 14, 48, 65),
            onPressed: createNewTask,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: db.toDoList.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Lottie.asset("assets/new.json",
                            width: 200, height: 200),
                      ),
                      Text(
                        "No tasks added yet!",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: db.toDoList.length,
                  itemBuilder: (context, index) {
                    return Todotile(
                      title: db.toDoList[index][0],
                      taskcompleted: db.toDoList[index][1],
                      category: db.toDoList[index][2],
                      datepicker: db.toDoList[index][3],
                      description: db.toDoList[index][4],
                      ontapped: () => tapped(index),
                      onChanged: (value) => chekboxChanged(value, index),
                      timenow: db.toDoList[index][5],
                    );
                  },
                )),
    );
  }
}
