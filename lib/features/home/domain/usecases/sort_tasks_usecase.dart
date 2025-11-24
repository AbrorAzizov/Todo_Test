import '../../data/entity/sorted_tasks.dart';
import '../repo/task_repo.dart';

class GetTasksUseCase {
  final TaskRepository repo;

  GetTasksUseCase(this.repo);

  Future<SortedTasks> call() async {
    final tasks = await repo.getAllTasks();

    return SortedTasks(
      toDo: tasks.where((t) => t.status == "to_do").toList(),
      inProgress: tasks.where((t) => t.status == "in_progress").toList(),
      review: tasks.where((t) => t.status == "review").toList(),
      done: tasks.where((t) => t.status == "done").toList(),
    );
  }
}
