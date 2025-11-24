
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:new_flutter_projects/features/home/presentation/bloc/task_state.dart';
import '../../data/entity/task_entity.dart';
import '../../domain/repo/task_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final TaskRepository repository;

  HomeCubit({required this.repository}) : super(HomeInitial());

  /// Загрузить все задачи
  Future<void> loadTasks() async {
    try {
      emit(HomeLoading());
      final tasks = await repository.getAllTasks();
      emit(HomeLoaded(tasks));
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
