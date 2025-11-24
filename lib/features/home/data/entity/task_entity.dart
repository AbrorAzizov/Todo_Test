// domain/entities/task_entity.dart

class TaskEntity {
  // Уникальный ключ/ID, который может быть присвоен позже (в Data Layer)
  final int? key;

  final String title;
  final DateTime deadline;
  final String status; // Использует константы статусов

  TaskEntity({
    this.key,
    required this.title,
    required this.deadline,
    required this.status,
  });


}