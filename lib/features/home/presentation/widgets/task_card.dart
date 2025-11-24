import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/text_styles.dart';
import '../../data/entity/task_entity.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskEntity task;

  const TaskCardWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // Determine if the task is overdue (simple check)
    final isOverdue = task.deadline.isBefore(DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0));

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Red flag icon (using a filled flag for importance)
                Icon(Icons.flag, size: 18.sp, color: Colors.red.shade400),
                SizedBox(width: 8.w),
                // Task Title
                Expanded(
                  child: Text(
                    task.title,
                    style: AppStyles.inputFieldText.copyWith(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Deadline Date
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey.shade500),
                    SizedBox(width: 4.w),
                    Text(
                      '${task.deadline.day} ${['янв', 'фев', 'мар', 'апр', 'май', 'июн', 'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'][task.deadline.month - 1]}',
                      style: AppStyles.statusCounter.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),

                // Overdue Tag (if applicable)
                if (isOverdue && task.status != 'Выполнено')
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'Просрочена',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}