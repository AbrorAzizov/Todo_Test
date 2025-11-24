import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Инициализация ScreenUtil происходит здесь
    return ScreenUtilInit(
      // Устанавливаем размер дизайна
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // 2. MyHomePage используется как домашний экран
          home: const MyHomePage(title: 'Flutter Demo Home Page with ScreenUtil'),
        );
      },
    );
  }
}

