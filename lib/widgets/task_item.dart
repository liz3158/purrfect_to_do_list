import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/models/task.dart';
import 'package:doable_todo_list_app/screens/edit_task_page.dart';
import 'package:doable_todo_list_app/services/task_service.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskUpdated;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onTaskUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: outlineColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox for task completion
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                activeColor: blueColor,
                value: task.isCompleted,
                onChanged: (_) {
                  TaskService().toggleTaskCompletion(task.id);
                  onTaskUpdated();
                },
              ),
            ),
            const SizedBox(width: 12),
            // Task content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: task.isCompleted
                              ? descriptionColor
                              : blackColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, 
                          size: 16, 
                          color: descriptionColor),
                      const SizedBox(width: 4),
                      Text(
                        task.time,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.calendar_today_outlined, 
                          size: 16, 
                          color: descriptionColor),
                      const SizedBox(width: 4),
                      Text(
                        task.date,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Edit button
            IconButton(
              icon: Icon(Icons.edit, color: descriptionColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskPage(task: task),
                  ),
                ).then((_) => onTaskUpdated());
              },
            ),
            // Delete button
            IconButton(
              icon: Icon(Icons.delete_outline, color: descriptionColor),
              onPressed: () {
                TaskService().deleteTask(task.id);
                onTaskUpdated();
              },
            ),
          ],
        ),
      ),
    );
  }
} 