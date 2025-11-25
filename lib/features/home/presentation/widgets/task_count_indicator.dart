import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskCountIndicator extends StatelessWidget {
  final int count;
  const TaskCountIndicator({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.12)),
      ),
      child: Text('$count', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp)),
    );
  }
}
