import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Здесь вы можете определить свои константы цветов, если они используются в дизайне
// class AppColors {
//   static const Color primaryText = Color(0xFF1E1E1E);
//   static const Color secondaryText = Color(0xFF6A6A6A);
//   static const Color accentColor = Color(0xFF00C4AA);
// }

class AppStyles {
  // -----------------------------------------------------------------------
  // 1. Стиль для заголовка приложения ('Todo')
  // Используем крупный, жирный шрифт.
  // -----------------------------------------------------------------------
  static final TextStyle headerTitle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500, // Bold
    color: Colors.black, // Предположим, черный
  );

  // -----------------------------------------------------------------------
  // 2. Стиль для заголовков статусов задач ('К выполнению', 'В работе' и т.д.)
  // Это основной текст в карточке статуса.
  // -----------------------------------------------------------------------
  static final TextStyle statusTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500, // Medium
    color: Colors.black87,
  );

  // -----------------------------------------------------------------------
  // 3. Стиль для счетчика задач (Цифра '1' рядом со статусом)
  // Шрифт чуть меньше, но тоже заметный.
  // -----------------------------------------------------------------------
  static final TextStyle statusCounter = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600, // Semi-bold
    color: Colors.black54,
  );

  // -----------------------------------------------------------------------
  // 4. Стиль для полей ввода (если мы на экране добавления задачи)
  // -----------------------------------------------------------------------
  static final TextStyle inputFieldText = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400, // Regular
    color: Colors.black,
  );

  // Стиль для placeholder'ов в полях ввода (например, 'Введите название задачи...')
  static final TextStyle inputFieldHint = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade600,
  );
}