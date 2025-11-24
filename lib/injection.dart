import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_projects/service_locator.dart';

import 'features/home/presentation/bloc/task_cubit.dart';
import 'features/home/presentation/pages/home_page.dart';

class Injection extends StatelessWidget {
  const Injection({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      // Получаем экземпляр Cubit через GetIt (sl())
      create: (context) => sl<HomeCubit>()..loadTasks(),
      child:  HomePage(),
    );
  }
}
