import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_flutter_projects/features/home/presentation/widgets/ad_task_form.dart';
import 'package:new_flutter_projects/features/home/presentation/widgets/add_button.dart';

// Предполагаем, что AppStrings и AppStyles доступны
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onAddTaskPressed(BuildContext context) {
    // Вызов модального окна снизу
    showModalBottomSheet(
      context: context,
      // ВАЖНО: isScrollControlled позволяет форме занимать большую высоту
      // и корректно подниматься, когда появляется клавиатура.
      isScrollControlled: true,
      builder: (context) {
        // Возвращаем виджет с формой
        return const AddTaskForm();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Светлый фон, как в дизайне
      // 2. Тело экрана со списком статусов
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.appName, style: AppStyles.headerTitle),
                  AddButton(onPressed: () {_onAddTaskPressed(context);}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
