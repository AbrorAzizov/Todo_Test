import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/entity/task_entity.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskEntity task;

  const TaskCardWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<TaskEntity>(
      data: task,
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: shadow ? [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0,6))
        ] : [],
        border: Border.all(color: Colors.grey.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          // status dot
          Container(
            width: 10.w,
            height: 10.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: _colorForStatus(task.status),
              shape: BoxShape.circle,
            ),
          ),

          // title + deadline
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 6.h),
                Text(
                  _formatDate(task.deadline),
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // optional more icon
          Icon(Icons.more_horiz, size: 18.sp, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2,'0')}.${dt.month.toString().padLeft(2,'0')}.${dt.year}';
  }

  Color _colorForStatus(String status) {
    switch (status) {
      case 'to_do':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'review':
        return Colors.purple;
      case 'done':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
