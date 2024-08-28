import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dialogbox extends StatefulWidget {
  final TextEditingController titlecontorller;
  final TextEditingController descriptioncontroller;
  final TextEditingController categorycontroller;
  final TextEditingController datepicker;
  final VoidCallback onsave;
  final VoidCallback oncancel;

  Dialogbox({
    super.key,
    required this.titlecontorller,
    required this.descriptioncontroller,
    required this.datepicker,
    required this.categorycontroller,
    required this.onsave,
    required this.oncancel,
  });

  @override
  State<Dialogbox> createState() => _DialogboxState();
}

class _DialogboxState extends State<Dialogbox> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Row(
        children: [
          Icon(Icons.task, color: Color.fromARGB(255, 14, 48, 65)),
          SizedBox(width: 8),
          Text(
            'Add Task',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 14, 48, 65)
            ),
          ),
        ],
      ),
      content: Container(
        width: 300,
        height: 500,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                    controller: widget.titlecontorller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:
                          Icon(Icons.title_rounded, color: Color.fromARGB(255, 14, 48, 65)),
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 14, 48, 65),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Description Field
                  TextFormField(
                    maxLines: 5,
                    maxLength: 1000,
                    controller: widget.descriptioncontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:
                          Icon(Icons.description, color: Color.fromARGB(255, 14, 48, 65)),
                      hintText: 'Enter a detailed description...',
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 14, 48, 65),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 15),

                  // Category Dropdown
                  DropdownButtonFormField(
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
                      widget.categorycontroller.text = value.toString();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Task Priority',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 14, 48, 65),
                      ),
                      prefixIcon: Icon(Icons.category_rounded,
                          color: Color.fromARGB(255, 14, 48, 65)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Date Picker
                  TextField(
                    controller: widget.datepicker,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:
                          Icon(Icons.calendar_today, color: Color.fromARGB(255, 14, 48, 65)),
                      labelText: 'Due Date',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 14, 48, 65),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    readOnly: true,
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
                          widget.datepicker.text = formattedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onsave();
                        }
                      },
                      child: Text(
                        'Save Task',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 116, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: widget.oncancel,
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
