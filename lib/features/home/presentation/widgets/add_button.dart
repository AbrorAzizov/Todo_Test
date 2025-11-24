import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Используем SizedBox для контроля размера и формы
    return SizedBox(
      width: 48.w, // Адаптивная ширина
      height: 48.h, // Адаптивная высота
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // Цвет фона, как в дизайне
          backgroundColor:Color(0xFF007D88),
          // Круглая форма (или сильно скругленный квадрат, как на скриншоте)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r), // Адаптивный радиус
          ),
          // Убираем внутренний отступ, чтобы иконка была по центру
          padding: EdgeInsets.zero,
          elevation: 4, // Небольшая тень для эффекта "плавающей" кнопки
        ),
        child: Icon(
          Icons.add,
          size: 30.sp, // Адаптивный размер иконки
          color: Colors.white,
        ),
      ),
    );
  }
}