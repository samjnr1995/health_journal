import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_journal/utils/styles.dart';
import '../../utils/colors.dart';

class CustomField extends StatelessWidget {
  final String hint;
  final AutovalidateMode? val;
  final String? actualHint;
  final Color? textColor;
  final bool isMap;
  final bool isDisabled;
  final bool readOnly;
  final IconData? icon;
  final IconData? preIcon;
  final int? maxlines;
  final int? maxlength;
  final Function()? click;
  final Color? color;
  final TextEditingController? data;
  final TextInputType type;
  final bool obs;
  final String? Function(String?)? validator;
  final Function(String)? submit;
  final Function(String)? onChanged;
  final TextCapitalization? tc;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  const CustomField({
    Key? key,
    required this.hint,
    this.color,
    required this.type,
    this.preIcon,
    this.actualHint,
    this.val,
    this.onChanged,
    this.icon,
    this.readOnly = false,
    this.maxlines,
    this.maxlength,
    this.click,
    this.textColor,
    this.data,
    this.validator,
    this.submit,
    this.tc,
    this.isMap = false,
    this.isDisabled = false,
    this.obs = false,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        readOnly: readOnly,
        autovalidateMode: val,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        maxLength: maxlength,
        enabled: !isDisabled,
        onFieldSubmitted: submit,
        textCapitalization: tc ?? TextCapitalization.none,
        validator: validator,
        onChanged: onChanged,
        obscureText: obs,
        keyboardType: type,
        controller: data,
        maxLines: maxlines ?? 1,
        cursorColor: Colors.grey,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.transparent),
            borderRadius: BorderRadius.circular(12)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors.defaultBlue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.8), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.8), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          hintText: hint,
          hintStyle: AppTextStyles.headerStyle
              .copyWith(color: Colors.grey, fontSize: 16.sp),
          prefixIcon: preIcon == null
              ? null
              : Icon(
            preIcon,
            color: const Color(0xff888888),
            size: 30,
          ),
          suffixIcon: IconButton(
            onPressed: click,
            icon: Icon(
              icon,
              size: 18,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
