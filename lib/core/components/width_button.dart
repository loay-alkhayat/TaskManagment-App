import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/constants/app_colors.dart';

class WidthButton extends StatelessWidget {
  final String textButton;
  final VoidCallback? onPress;
  double? paddingSize;

  WidthButton({
    super.key,
    required this.textButton,
    this.onPress,
    this.paddingSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingSize!),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(4.w),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.primary),
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColors.grey1),
                overlayColor: MaterialStateProperty.all(AppColors.primary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              onPressed: onPress,
              child: Text(
                textButton,
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
