import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/entity/task_entity.dart';
import '../../../domain/use_cases/format_date_usecase.dart';

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

   @override
   void initState() {
     super.initState();
     // ✅ Инициализация UseCase
     formatDateUseCase = FormatDateUseCase();

     // ✅ Получение отформатированной строки даты
     deadlineString = formatDateUseCase.formatDate(widget.task.deadline);

     // ✅ Определение, просрочена ли задача
     isExpired = formatDateUseCase.isExpired(widget.task.deadline);
   }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<TaskEntity>(
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
    );
  }

  Widget _card({bool shadow = false}) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // 🔥 Красная точка + заголовок
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // 📅 Дата + красный чип "Просрочена"
        Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 16.sp, color: Colors.grey.shade600),
            SizedBox(width: 6.w),

            Text(
             deadlineString,
              style: TextStyle(
                  fontSize: 13.sp, color: Colors.grey.shade600),
            ),

            const Spacer(),

            if (isExpired)
              Container(
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
              )
          ],
        ),
      ],
    );
  }


}
