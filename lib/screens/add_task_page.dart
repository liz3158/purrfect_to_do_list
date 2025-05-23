import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/services/task_service.dart';
import 'package:doable_todo_list_app/widgets/icon_text_box.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:doable_todo_list_app/widgets/back_arrow.dart';
import 'package:doable_todo_list_app/widgets/set_reminder.dart';
import 'package:doable_todo_list_app/widgets/small_spacing.dart';
import 'package:doable_todo_list_app/widgets/text_box.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doable_todo_list_app/widgets/animated_success_dialog.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> with SingleTickerProviderStateMixin {
  String _titleValue = '';
  String _descriptionValue = '';
  String _dateValue = '';
  String _timeValue = '';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    const BackArrow(),
                    Text(
                      "Create to-do",
                      style: Theme.of(context).textTheme.displayLarge,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                const SetReminder(),
                const Spacing(),
                //Todo title & Todo description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tell us about your task",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                const SmallSpacing(),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.title_outlined),
                    hintText: "Title",
                    labelText: "Title",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _titleValue = value;
                    });
                  },
                ),
                const SmallSpacing(),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.description_outlined),
                    hintText: "Description",
                    labelText: "Description",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _descriptionValue = value;
                    });
                  },
                ),
                const Spacing(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date & Time",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),

                SizedBox(height: 5,),

                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    hintText: "Select Date"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _dateValue = value;
                    });
                  },
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.access_time_outlined),
                    hintText: "Select Time"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _timeValue = value;
                    });
                  },
                ),

                const Spacing(),

                GestureDetector(
                  onTap: () {
                    if (_titleValue.isNotEmpty) {
                      TaskService().addTask(
                        _titleValue,
                        _descriptionValue,
                        _dateValue.isNotEmpty ? _dateValue : 'No date',
                        _timeValue.isNotEmpty ? _timeValue : 'No time',
                      );
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AnimatedSuccessDialog(
                          message: 'Yay! Your task has been created!',
                          onClose: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Task title is required'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(45.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Create",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //TODO: Add more TextBox() and a submit button
                //Save the data to variables
                //Save the data to ObjectBox
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
