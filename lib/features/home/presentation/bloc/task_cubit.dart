import 'package:bloc/bloc.dart';
import 'package:new_flutter_projects/features/home/presentation/bloc/task_state.dart';
import '../../data/entity/task_entity.dart';
import '../../domain/repo/task_repo.dart';
import '../../domain/usecases/sort_tasks_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
  final TaskRepository repository;
  final GetTasksUseCase getTasksUseCase;

  HomeCubit({required this.repository, required this.getTasksUseCase}) : super(HomeInitial());

  /// Загрузить все задачи
  Future<void> loadTasks() async {
    try {
      emit(HomeLoading());
      final result = await getTasksUseCase();
      emit(HomeLoaded(
        toDo: result.toDo,
        inProgress: result.inProgress,
        review: result.review,
        done: result.done,));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// Добавить новую задачу
  Future<void> addTask(TaskEntity task) async {
    try {
      if (state is HomeLoaded) {
        await repository.createTask(task);
        await loadTasks(); // Перезагружаем список
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// Удалить задачу
  Future<void> deleteTask(int key) async {
    try {
      if (state is HomeLoaded) {
        await repository.deleteTask(key);
        await loadTasks(); // Перезагружаем список
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// Изменить статус задачи
  Future<void> updateStatus(int key, String newStatus) async {
    try {
      if (state is HomeLoaded) {
        await repository.updateStatus(key: key, newStatus: newStatus);
        await loadTasks();
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
