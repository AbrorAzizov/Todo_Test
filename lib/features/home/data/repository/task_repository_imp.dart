import 'package:hive/hive.dart';

import '../../domain/models/task_model.dart';
import '../../domain/repo/task_repo.dart';
import '../entity/task_entity.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Box<TaskModel> box;

  TaskRepositoryImpl(this.box);

  @override
  Future<TaskEntity> createTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    final key = await box.add(model);
    final saved = box.get(key)!;

    return saved.toEntity();
  }

  @override
  Future<void> deleteTask(int key) async {
    await box.delete(key);
  }

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    return box.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<TaskEntity> updateStatus({
    required int key,
    required String newStatus,
  }) async {
    final model = box.get(key);

    if (model == null) {
      throw Exception("Task not found");
    }

    model.status = newStatus;
    await model.save();

    return model.toEntity();
  }
}
