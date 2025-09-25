import 'package:app/core/utils/extension/context_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/gender.dart';
import '../../widget/profile_edit_text_field.dart';

class GenderEditWidget extends StatefulWidget {
  final void Function(Gender?)? onChanged;
  final Gender? selectedGender;

  const GenderEditWidget({super.key, this.onChanged, this.selectedGender});

  @override
  State<GenderEditWidget> createState() => _GenderEditWidgetState();
}

class _GenderEditWidgetState extends State<GenderEditWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.selectedGender?.titleEn ?? '';
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Gender>(
        isExpanded: true,
        customButton: ProfileEditTextField(
          hintText: 'Select your gender',
          labelText: context.language.gender,
          controller: _controller,
          //initialText: widget.selectedGender?.title,
          enabled: false,
          suffixIcon: const Icon(Icons.legend_toggle),
        ),
        style: TextStyle(
            fontSize: 12.sp, height: 1, color: context.colorScheme.primary),
        items: Gender.list
            .map((item) => DropdownMenuItem<Gender>(
                  value: item,
                  child: Text(
                    item.titleEn,
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: widget.selectedGender,
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.only(top: 6.h, bottom: 6.h, right: 14.w),
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: AppColors.colorAppGrey,
            ),
            color: Colors.white,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 16.r,
          iconEnabledColor: AppColors.colorAppGrey,
          iconDisabledColor: AppColors.colorAppGrey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: Colors.white,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: Radius.circular(40.r),
            thickness: WidgetStateProperty.all<double>(3),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
            height: 32.h,
            selectedMenuItemBuilder: (context, child) => ColoredBox(
                  color: context.colorScheme.primary.withAlpha(30),
                  child: child,
                ),
            padding: EdgeInsets.symmetric(horizontal: 6.r)),
      ),
    );
  }
}
