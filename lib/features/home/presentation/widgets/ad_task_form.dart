import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/text_styles.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); // Инициализируем текущей датой

  @override
  void initState() {
    super.initState();
    // Инициализируем поле срока текущей датой при загрузке
    _updateDeadlineText(_selectedDate);
  }

  void _updateDeadlineText(DateTime date) {
    // Форматирование даты
    _deadlineController.text = '${date.day}.${date.month}.${date.year}';
  }

  // Функция для показа CupertinoDatePicker
  void _showDatePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250.h,
          color: Colors.white,
          child: Column(
            children: [
              // Кнопка "Готово" для закрытия
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
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              // Сам CupertinoDatePicker
              SizedBox(
                height: 210.h,
                child: CupertinoDatePicker(
                  initialDateTime: _selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _updateDeadlineText(newDate);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveTask() {
    if (_taskController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название задачи')),
      );
      return;
    }
    // Здесь должна быть логика вызова AddTaskBloc

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _taskController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Внимание: isScrollControlled: true должен быть установлен в showModalBottomSheet,
    // чтобы этот Padding работал корректно с клавиатурой.
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, MediaQuery.of(context).viewInsets.bottom + 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок окна (точность Figma)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.addTaskTitle,
                style: AppStyles.headerTitle.copyWith(fontSize: 22.sp),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 28.sp, color: Colors.grey.shade600),
                onPressed: () => Navigator.pop(context), // Закрывает модальное окно
              ),
            ],
          ),
          SizedBox(height: 25.h),

          // 1. Поле ввода задачи (Название)
          TextField(
            controller: _taskController,
            style: AppStyles.inputFieldText,
            decoration: InputDecoration(
              labelText: AppStrings.hintTaskName,
              labelStyle: AppStyles.inputFieldHint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
              contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            ),
          ),
          SizedBox(height: 15.h),

          // 2. Поле ввода срока истекания (Вызов Cupertino Date Picker)
          GestureDetector(
            onTap: () => _showDatePickerSheet(context),
            child: AbsorbPointer(
              child: TextField(
                controller: _deadlineController,
                style: AppStyles.inputFieldText,
                decoration: InputDecoration(
                  labelText: AppStrings.labelDeadline,
                  labelStyle: AppStyles.inputFieldHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                  suffixIcon: Icon(Icons.calendar_today, size: 20.sp, color: Colors.grey.shade600),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.h),

          // Кнопка сохранения (точность Figma)
          SizedBox(
            width: double.infinity,
            height: 55.h,
            child: ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007D88), // Ваш цвет #007D88
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                AppStrings.buttonSave,
                style: AppStyles.statusTitle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}