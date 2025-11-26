import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/entity/task_entity.dart';
import '../../../domain/use_cases/format_date_usecase.dart';
import '../../bloc/task_cubit.dart';

class TaskCardWidget extends StatefulWidget {
  final TaskEntity task;

  const TaskCardWidget({super.key, required this.task});

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  late FormatDateUseCase formatDateUseCase;
  late String deadlineString;
  late bool isExpired;

  Offset? tapPosition;

  @override
  void initState() {
    super.initState();

    formatDateUseCase = FormatDateUseCase();
    deadlineString = formatDateUseCase.formatDate(widget.task.deadline);
    isExpired = formatDateUseCase.isExpired(widget.task.deadline);
  }

  void _storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  void _showContextMenu() async {
    if (tapPosition == null) return;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition!.dx,
        tapPosition!.dy,
        tapPosition!.dx,
        tapPosition!.dy,
      ),
      items: const [
        PopupMenuItem(value: 'delete', child: Text("Удалить")),
      ],
    );

    if (selected == 'delete') {
      context.read<HomeCubit>().deleteTask(widget.task.key!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _storePosition,
      child: LongPressDraggable<TaskEntity>(
        data: widget.task,
        maxSimultaneousDrags: 1,

        feedback: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 260.w),
            child: _card(shadow: true),
          ),
        ),

        childWhenDragging: Opacity(opacity: 0.25, child: _card()),
        child: _card(),
      ),
    );
  }

  Widget _card({bool shadow = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.bookmark, color: Colors.red),
                SizedBox(width: 6.w),
                Text(
                  widget.task.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // ⬇⬇⬇ КНОПКА МЕНЮ (исправленная)
            GestureDetector(
              onTapDown: _storePosition,
              onTap: _showContextMenu,
              child: Icon(Icons.more_vert, size: 22.sp),
            )
          ],
        ),

        SizedBox(height: 12.h),

        Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 16.sp, color: Colors.grey.shade600),
            SizedBox(width: 6.w),

            Text(
              deadlineString,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade600,
              ),
            ),

            const Spacer(),

            if (isExpired)
              Container(
                height: 24.h,
                width: 88.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "Просрочена",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}