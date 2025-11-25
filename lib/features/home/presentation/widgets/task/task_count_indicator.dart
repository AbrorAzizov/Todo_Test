import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskCountIndicator extends StatelessWidget {
  final int count;
  const TaskCountIndicator({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Text('$count', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp));
  }
}