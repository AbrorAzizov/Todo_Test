import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_flutter_projects/features/home/presentation/widgets/cancel_button.dart';
import 'package:new_flutter_projects/features/home/presentation/widgets/save_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/text_styles.dart';
import '../../data/entity/task_entity.dart';
import '../bloc/task_cubit.dart';
import 'custom_date_picker.dart';

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


  void _saveTask() {
    if (_taskController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название задачи')),
      );
      return;
    }

    final task = TaskEntity(
      status:'toImplementation' ,
      title: _taskController.text,
      deadline: _selectedDate,
    );

    // Add task using HomeCubit
    context.read<HomeCubit>().addTask(task);

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
          CustomDatePicker(
            initialDate: _selectedDate,
            controller: _deadlineController, // <-- pass controller
            onDateChanged: (newDate) {
              setState(() {
                _selectedDate = newDate;
                _updateDeadlineText(newDate);
              });
            },
          ),

          SizedBox(height: 30.h),

          // Кнопка сохранения (точность Figma)
          Row(
            children: [
              Expanded(
                child: CancelButton(callback: () => Navigator.pop(context)),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: SaveButton(callback: () => _saveTask()),
              ),
            ],
          )

        ],
      ),
    );
  }
}