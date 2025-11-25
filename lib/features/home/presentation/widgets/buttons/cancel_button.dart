
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/text_styles.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback callback;
  const CancelButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor:  Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          AppStrings.buttonCancel,
          style: AppStyles.statusTitle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18.sp
          ),
        ),
      ),
    );
  }
}
