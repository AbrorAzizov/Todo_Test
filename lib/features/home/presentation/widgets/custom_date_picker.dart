import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;
  final TextEditingController controller; // <-- declare the controller

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
    required this.controller, // <-- required in constructor
  });

  void _showDatePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // чтобы не перекрывала клавиатура
      builder: (BuildContext context) {
        return Container(
          height: 250.h,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Готово',
                        style: TextStyle(
                          color: Colors.teal.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 210.h,
                child: CupertinoDatePicker(
                  initialDateTime: initialDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (newDate) {
                    controller.text =
                    '${newDate.day}.${newDate.month}.${newDate.year}';
                    onDateChanged(newDate);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePickerSheet(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller, // <-- attach controller
          decoration: InputDecoration(
            labelText: 'Deadline',
            suffixIcon: Icon(Icons.calendar_today,
                size: 20.sp, color: Colors.grey.shade600),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r)),
            contentPadding:
            EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          ),
        ),
      ),
    );
  }
}
