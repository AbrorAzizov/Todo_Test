

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:new_flutter_projects/features/home/data/repository/task_repository_imp.dart';
import 'package:new_flutter_projects/features/home/domain/models/task_model.dart';
import 'package:new_flutter_projects/features/home/domain/repo/task_repo.dart';
import 'package:new_flutter_projects/features/home/presentation/bloc/task_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final box = await Hive.openBox<TaskModel>('tasks');

  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(box));

  sl.registerLazySingleton(() => HomeCubit(repository: sl<TaskRepository>()),);

}