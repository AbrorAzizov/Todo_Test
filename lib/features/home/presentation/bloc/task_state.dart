
import '../../data/entity/task_entity.dart';


abstract class HomeState {}

// 1. Начальное состояние (при запуске)
class HomeInitial extends HomeState {}

// 2. Состояние загрузки данных
class HomeLoading extends HomeState {}

// 3. Состояние успешной загрузки данных
class HomeLoaded extends HomeState {
  final List<TaskEntity> toDo;        // К выполнению
  final List<TaskEntity> inProgress;  // В работе
  final List<TaskEntity> review;      // На проверке
  final List<TaskEntity> done;        // Выполнено

  HomeLoaded({
    required this.toDo,
    required this.inProgress,
    required this.review,
    required this.done,
  });
}

// 4. Состояние ошибки
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}