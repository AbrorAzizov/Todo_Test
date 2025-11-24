class TaskEntity {
  final int key;
  final String title;
  final DateTime deadline;
  final String status;

  TaskEntity({
    required this.key,
    required this.title,
    required this.deadline,
    required this.status,
  });
}
