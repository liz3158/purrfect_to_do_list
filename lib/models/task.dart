class Task {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.date = 'No date',
    this.time = 'No time',
    this.isCompleted = false,
  });
} 