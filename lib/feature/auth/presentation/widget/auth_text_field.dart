import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {
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
  final FocusNode? focusNode;

  const AuthTextField(
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
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.r);
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.colorGreyLight),
        borderRadius: borderRadius);

    final textStyle =
        TextStyle(color: context.colorScheme.primary, fontSize: 12.sp);
    final errorStyle = TextStyle(
        height: 1,
        color: context.colorScheme.error,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500);

    final hintStyle =
        const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal);

    return Material(
      elevation: 2,
      borderRadius: borderRadius,
      color: Colors.transparent,
      shadowColor: const Color(0x05010614),
      child: TextFormField(
        key: mKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: textStyle,
        validator: validator,
        controller: controller,
        readOnly: readOnly,
        focusNode: focusNode,
        cursorColor: context.colorScheme.primary,
        obscureText: obscureText,
        onSaved: onSaved,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        initialValue: controller == null ? initialText : null,
        decoration: InputDecoration(
          errorStyle: errorStyle,
          enabledBorder: border,
          focusedBorder: border.copyWith(
              borderSide: BorderSide(color: context.colorScheme.primary)),
          border: border,
          fillColor: Colors.white,
          isCollapsed: false,
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          hintText: hintText,
          labelText: labelText,
          isDense: true,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: suffixIcon,
          ),
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
          hintStyle: hintStyle,
        ),
      ),
    );
  }
}
