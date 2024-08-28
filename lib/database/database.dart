import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  //reference of box
  final _mybox = Hive.box('mybox');

//load data from the database
  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

  //update the database
  void updateData() {
    _mybox.put("TODOLIST", toDoList);
  }
}
