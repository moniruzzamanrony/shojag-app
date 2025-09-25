import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/theme/app_colors.dart';

/// [AddFormTextField] : widget for add form text field
class AddFormTextField extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final String? initialText;
  final int? maxLines;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;

  const AddFormTextField(
      {super.key,
      this.onChanged,
      this.validator,
      this.hintText,
      this.labelText,
      this.maxLines,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.initialText});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: _borderRadius(),
      color: Colors.transparent,
      shadowColor: const Color(0x2006141A),
      child: TextFormField(
        initialValue:
            controller == null && initialText != null ? initialText : null,
        maxLines: maxLines,
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        onChanged: onChanged,
        style: _textStyle(),
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            hintStyle: _hintStyle(),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _focusBorder(context)),
      ),
    );
  }

  BorderRadius _borderRadius() => BorderRadius.circular(10.r);

  OutlineInputBorder _border() => OutlineInputBorder(
      borderRadius: _borderRadius(),
      borderSide: const BorderSide(color: AppColors.colorGreyExtraLight));

  OutlineInputBorder _focusBorder(BuildContext context) => OutlineInputBorder(
      borderRadius: _borderRadius(),
      borderSide: const BorderSide(color: AppColors.colorAppGreen));

  TextStyle _hintStyle() => const TextStyle(color: AppColors.colorGreyLight);

  TextStyle _textStyle() => TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      height: 1,
      color: AppColors.colorBlack);
}
