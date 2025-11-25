import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/entity/task_entity.dart';
import '../bloc/task_cubit.dart';
import 'task_card.dart';
import 'task_count_indicator.dart';

class TaskColumn extends StatelessWidget {
  final String title;
  final List<TaskEntity> tasks;
  final String status;

  const TaskColumn({
    super.key,
    required this.title,
    required this.tasks,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<TaskEntity>(
      onWillAccept: (data) => data != null && data.status != status,
      onAccept: (task) {
        // просим кубит обновить статус
        context.read<HomeCubit>().updateTaskStatus(task.key!, status);
      },
      builder: (context, candidateData, rejectedData) {
        final highlight = candidateData.isNotEmpty;
        return Container(
          width: 300.w,
          margin: EdgeInsets.only(top: 6.h, bottom: 12.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: highlight ? Border.all(color: Colors.teal.shade300, width: 2) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header: title + count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  TaskCountIndicator(count: tasks.length),
                ],
              ),

              SizedBox(height: 12.h),

              // tasks list
              if (tasks.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 22.h),
                    child: Text('Нет задач', style: TextStyle(color: Colors.grey.shade500)),
                  ),
                ),
              ...tasks.map((t) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: TaskCardWidget(task: t),
              )),
              // placeholder when dragging over
              if (highlight)
                Container(
                  height: 56.h,
                  margin: EdgeInsets.only(top: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
