
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_flutter_projects/features/home/presentation/bloc/task_state.dart';
import 'package:new_flutter_projects/features/home/presentation/widgets/ad_task_form.dart';
import 'package:new_flutter_projects/features/home/presentation/widgets/add_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/text_styles.dart';
import '../../data/entity/task_entity.dart';
import '../bloc/task_cubit.dart';

import '../widgets/task/task_column.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _col(String title, List<TaskEntity> list, String status) {
    return SizedBox(

      child: TaskColumn(
        title: title,
        tasks: list,
        status: status,
      ),
    );
  }

  void _onAddTaskPressed(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return BlocProvider.value(
          value: homeCubit,
          child: const AddTaskForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.appName, style: AppStyles.headerTitle.copyWith(fontSize: 28.sp)),
                  AddButton(onPressed: () => _onAddTaskPressed(context)),
                ],
              ),
              SizedBox(height: 22.h),

              // Основная рабочая зона
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      // Горизонтальная полоса колонок (как в Figma)
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _col("К выполнению ", state.toDo, "to_do"),

                            _col("В работе", state.inProgress, "in_progress"),

                            _col("На проверке", state.review, "review"),

                            _col("Выполнено", state.done, "done"),

                          ],
                        ),
                      );
                    }

                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeError) {
                      return Center(child: Text('Ошибка: ${state.message}'));
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}