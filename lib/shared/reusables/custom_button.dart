import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_journal/utils/styles.dart';
class CustomButton extends StatelessWidget {
  final Color? textColor;
  final String? text;
  final bool loading;
  final Color? color;
  final TextStyle? style;
  final double? width;
  final Function() onTap;

  const CustomButton({
    this.loading = false,
    this.color,
    this.width,
    this.style,
    required this.onTap,
    this.text = 'Submit',
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50.h,
          //width: 200.w,
          child: (loading)
              ? const SizedBox(
            height: 30,
            width: 40,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          )
              : Text(
              text!,
              style: style ?? AppTextStyles.headerStyle.copyWith(
                color: textColor ?? const Color(0xffFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )
          ),
        ),
      ),
    );
  }
}