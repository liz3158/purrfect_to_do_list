import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/models/task.dart';
import 'package:doable_todo_list_app/screens/settings_page.dart';
import 'package:doable_todo_list_app/services/task_service.dart';
import 'package:doable_todo_list_app/widgets/add_task_button.dart';
import 'package:doable_todo_list_app/widgets/header.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:doable_todo_list_app/widgets/task_item.dart';
import 'package:doable_todo_list_app/widgets/today_and_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Task> _tasks = [];
  bool _showCompletedTasks = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _loadTasks();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadTasks() {
    setState(() {
      _tasks = TaskService().getTasks();
    });
  }

  void _toggleShowCompletedTasks() {
    setState(() {
      _showCompletedTasks = !_showCompletedTasks;
    });
  }

  List<Task> get _filteredTasks {
    if (_showCompletedTasks) {
      return _tasks;
    } else {
      return _tasks.where((task) => !task.isCompleted).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SvgPicture.asset(
            "assets/trans_logo.svg",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const AddTaskButton(),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                SizedBox(height: 24),
                TodayAndFilterButton(
                  showCompletedTasks: _showCompletedTasks,
                  onFilterToggle: _toggleShowCompletedTasks,
                ),
                const Spacing(),
                _filteredTasks.isEmpty 
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 64,
                              color: descriptionColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No tasks yet",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Add a task by tapping the + button",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _filteredTasks.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: TaskItem(
                              task: _filteredTasks[index],
                              onTaskUpdated: _loadTasks,
                            ),
                          );
                        },
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
