import 'package:hive/hive.dart';

import '../../data/entity/task_entity.dart';
part 'task_model.g.dart';
// 1. Аннотируем класс как TypeAdapter
@HiveType(typeId: 0) // Уникальный ID для этой модели
class TaskModel extends HiveObject{
  // 2. Аннотируем каждое поле уникальным FieldId
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime deadline;

  @HiveField(2)
  final String status;

  TaskModel({
    required this.title,
    required this.deadline,
    required this.status,
  });
  /// Entity → Model
  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      title: entity.title,
      deadline: entity.deadline,
      status: entity.status,
    );
  }

  /// Model → Entity
  TaskEntity toEntity() {
    return TaskEntity(
      key: key,
      title: title,
      deadline: deadline,
      status: status,
    );
}
}