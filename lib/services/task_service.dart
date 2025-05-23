import 'package:doable_todo_list_app/models/task.dart';
import 'dart:math';

// This is a temporary in-memory implementation
// TODO: Replace with actual database implementation
class TaskService {
  static final TaskService _instance = TaskService._internal();
  
  factory TaskService() {
    return _instance;
  }
  
  TaskService._internal();
  
  final List<Task> _tasks = [
    // Sample tasks
    Task(
      id: '1',
      title: 'Complete Flutter Project',
      description: 'Finish the todo app implementation',
      date: '2023-06-15',
      time: '14:30',
      isCompleted: false,
    ),
    Task(
      id: '2',
      title: 'Buy Groceries',
      description: 'Get milk, eggs, and bread',
      date: '2023-06-16',
      time: '10:00',
      isCompleted: true,
    ),
    Task(
      id: '3',
      title: 'Doctor Appointment',
      description: 'Annual checkup at City Hospital',
      date: '2023-06-18',
      time: '09:15',
      isCompleted: false,
    ),
  ];
  
  List<Task> getTasks() {
    return _tasks;
  }
  
  void addTask(String title, String description, String date, String time) {
    final newTask = Task(
      id: Random().nextInt(10000).toString(),
      title: title,
      description: description,
      date: date,
      time: time,
    );
    
    _tasks.add(newTask);
  }
  
  void toggleTaskCompletion(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
    }
  }
  
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }

  void updateTask(String id, String title, String description, String date, String time) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
        id: id,
        title: title,
        description: description,
        date: date,
        time: time,
        isCompleted: _tasks[taskIndex].isCompleted,
      );
    }
  }
} 