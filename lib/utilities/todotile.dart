import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/utilities/dialogbox.dart';

class Todotile extends StatelessWidget {
  final String title;

  final bool taskcompleted;

  final String description;

  final VoidCallback ontapped;

  final String category;

  final String datepicker;
  final String timenow;

  Function(bool?) onChanged;
  //final VoidCallback onDelete;

  Todotile({
    super.key,
    required this.title,
    required this.taskcompleted,
    required this.category,
    required this.datepicker,
    required this.description,
    required this.onChanged,
    required this.ontapped,
    required this.timenow,
  });

  Color? getCategoryColor(String colorcategory) {
    switch (colorcategory) {
      case 'High':
        return Colors.red[500];
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return const Color.fromARGB(255, 112, 98, 98);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorcategory = category;
    return GestureDetector(
      onTap: ontapped,
      child: Card(
        color: getCategoryColor(colorcategory),
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 9.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    activeColor: Colors.black,
                    value: taskcompleted,
                    onChanged: onChanged,
                  )
                ],
              ),

              SizedBox(height: 8.0),
              // SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Due: ' + datepicker,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    timenow,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
