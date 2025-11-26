import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/entity/task_entity.dart';
import '../../bloc/task_cubit.dart';
import 'task_card.dart';
import 'task_count_indicator.dart';

class TaskColumn extends StatefulWidget {
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
  State<TaskColumn> createState() => _TaskColumnState();
}

class _TaskColumnState extends State<TaskColumn> {
  bool isExpanded = true; // ← состояние (показывать или скрывать)

  @override
  Widget build(BuildContext context) {
    return DragTarget<TaskEntity>(
      onWillAccept: (data) => data != null && data.status != widget.status,
      onAccept: (task) {
        context.read<HomeCubit>().updateTaskStatus(task.key!, widget.status);
      },
      builder: (context, candidateData, rejectedData) {
        final highlight = candidateData.isNotEmpty;

        return Column(
          children: [
            // -------- HEADER --------
            Container(
              width: double.infinity,
              height: 48.h,

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
                border: highlight ? Border.all(color: Colors.teal, width: 2) : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TaskCountIndicator(count: widget.tasks.length),
                        SizedBox(width: 6.w),

                        // TOGGLE BUTTON ↓
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            if (isExpanded)
              _buildTaskList(highlight),
          ],
        );
      },
    );
  }

  Widget _buildTaskList(bool highlight) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8.h, bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: highlight ? Border.all(color: Colors.teal, width: 2) : null,
      ),
      child: Column(
        children: [
          if (widget.tasks.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text('Нет задач', style: TextStyle(color: Colors.grey.shade500)),
            ),

          ...widget.tasks.map(
                (t) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: TaskCardWidget(task: t),
            ),
          ),

          if (highlight)
            Container(
              height: 56.h,
              margin: EdgeInsets.only(top: 6.h),
              decoration: BoxDecoration(
                color: Colors.teal.withAlpha(20),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
        ],
      ),
    );
  }
}
