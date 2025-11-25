
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/text_styles.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback callback;
  const SaveButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007D88),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          AppStrings.buttonSave,
          style: AppStyles.statusTitle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18.sp
          ),
        ),
      ),
    );
  }
}
