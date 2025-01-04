import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodDateOptionButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onMoodTap;

  const MoodDateOptionButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.iconData,
    this.onMoodTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Color(0xff1034A6) : Colors.black,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: GestureDetector(
        onTap: onMoodTap,
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.grey,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Color(0xff1034A6) : Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: const Color(0xff9FA2AD),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}