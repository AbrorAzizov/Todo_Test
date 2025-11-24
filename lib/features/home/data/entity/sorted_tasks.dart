import 'package:new_flutter_projects/features/home/data/entity/task_entity.dart';

class SortedTasks {
  final List<TaskEntity> toDo;
  final List<TaskEntity> inProgress;
  final List<TaskEntity> review;
  final List<TaskEntity> done;

  SortedTasks({
    required this.toDo,
    required this.inProgress,
    required this.review,
    required this.done,
  });
}
