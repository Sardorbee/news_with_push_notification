import 'package:flutter/material.dart';
import 'package:news_with_push_notification/ui/ui_utils/colors.dart';

// ignore: must_be_immutable
class GlobalTextField extends StatelessWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    this.maxLines = 1,
    this.controller,
    required this.label,
    required this.onChanged,
  }) : super(key: key);
  final ValueChanged onChanged;
  final String hintText;
  int? maxLines;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  TextAlign textAlign;
  final bool obscureText;
  final TextEditingController? controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          // height: 55.h,
          child: TextField(
            onChanged: onChanged,
            maxLines: maxLines,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontFamily: "DMSans"),
            textAlign: textAlign,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c_676767,
                  fontFamily: "DMSans"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.cC8C8C8,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.cC8C8C8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.cC8C8C8,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.cC8C8C8,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.cC8C8C8,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
