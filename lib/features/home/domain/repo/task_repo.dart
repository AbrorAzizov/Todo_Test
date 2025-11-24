
import '../../data/entity/task_entity.dart';

abstract class TaskRepository {
  /// Создать новую задачу
  Future<TaskEntity> createTask(TaskEntity task);

  /// Удалить задачу по ключу
  Future<void> deleteTask(int key);

  /// Получить список всех задач
  Future<List<TaskEntity>> getAllTasks();

  /// Обновить статус по ключу
  Future<TaskEntity> updateStatus({
    required int key,
    required String newStatus,
  });
}
