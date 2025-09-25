/*
 * profile edit text field widget
 * */

import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileEditTextField extends StatelessWidget {
  final bool obscureText;
  final Function(String? newValue)? onSaved;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Key? mKey;
  final bool readOnly;
  final bool enabled;
  final FocusNode? focusNode;
  final void Function()? onTap;

  const ProfileEditTextField(
      {super.key,
      this.mKey,
      this.obscureText = false,
      this.initialText,
      this.onSaved,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.validator,
      this.inputFormatters,
      this.keyboardType,
      this.readOnly = false,
      this.enabled = true,
      this.focusNode,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.colorAppGrey),
        borderRadius: BorderRadius.circular(5.r));

    return TextFormField(
      key: mKey,
      onTap: onTap,
      style: TextStyle(
          color: AppColors.colorBlack,
          fontSize: 12.sp,
          height: 1,
          fontWeight: FontWeight.w600),
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      enabled: enabled,
      focusNode: focusNode,
      cursorColor: context.colorScheme.primary,
      obscureText: obscureText,
      onSaved: onSaved,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      initialValue: controller == null ? initialText : null,
      decoration: InputDecoration(
        errorStyle: const TextStyle(height: 1),
        enabledBorder: border,
        focusedBorder: border.copyWith(
            borderSide: BorderSide(color: context.colorScheme.primary)),
        border: border,
        disabledBorder: border,
        labelStyle: const TextStyle(color: AppColors.colorAppGrey),
        //fillColor: context.,
        isCollapsed: false,
        filled: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffixIconConstraints: const BoxConstraints(minWidth: 48),
        prefixIconColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.focused)
                ? context.colorScheme.primary
                : Colors.grey),
        suffixIconColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.focused)
                ? context.colorScheme.primary
                : Colors.grey),
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
      ),
    );
  }
}
