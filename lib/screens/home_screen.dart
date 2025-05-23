import 'package:flutter/material.dart';
import '../widgets/task_list.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'edit_task_page.dart';
import '../widgets/animated_success_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Purrfect Tasks 🐱', style: TextStyle(color: Colors.yellow)),
        centerTitle: true,
        elevation: 0,
      ),
      body: const TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.grey[800],
          title: const Text('Add New Task', style: TextStyle(color: Colors.yellow)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter task title',
                    labelStyle: TextStyle(color: Colors.yellow),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(color: Colors.grey[700]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter task description (optional)',
                    labelStyle: TextStyle(color: Colors.yellow),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(color: Colors.grey[700]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: Colors.yellow,
                                    onPrimary: Colors.black,
                                    surface: Colors.grey[900]!,
                                    onSurface: Colors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[700]!),
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month_outlined, color: Colors.yellow),
                              SizedBox(width: 8),
                              Text(
                                selectedDate != null
                                    ? DateFormat('MMM dd, yyyy').format(selectedDate!)
                                    : 'Select Date',
                                style: TextStyle(
                                  color: selectedDate != null ? Colors.white : Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: selectedTime ?? TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: Colors.yellow,
                                    onPrimary: Colors.black,
                                    surface: Colors.grey[900]!,
                                    onSurface: Colors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              selectedTime = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[700]!),
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time_outlined, color: Colors.yellow),
                              SizedBox(width: 8),
                              Text(
                                selectedTime != null
                                    ? selectedTime!.format(context)
                                    : 'Select Time',
                                style: TextStyle(
                                  color: selectedTime != null ? Colors.white : Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.yellow)),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final task = Task(
                    id: DateTime.now().toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    date: selectedDate != null
                        ? DateFormat('MMM dd, yyyy').format(selectedDate!)
                        : 'No date',
                    time: selectedTime != null
                        ? selectedTime!.format(context)
                        : 'No time',
                  );
                  context.read<TaskProvider>().addTask(task);
                  Navigator.pop(context);
                  
                  // Show success animation
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AnimatedSuccessDialog(
                      message: 'New task added! ${task.title} 🐱',
                      onClose: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ),
              ),
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
} 