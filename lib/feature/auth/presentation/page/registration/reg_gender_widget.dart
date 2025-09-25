import 'package:app/core/utils/extension/context_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/gender.dart';
import '../../provider/registration_provider.dart';

class RegGenderWidget extends StatelessWidget {
  const RegGenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<RegistrationProvider, Gender?>(
      selector: (_, provider) => provider.selectGender,
      builder: (_, value, __) => DropdownButtonHideUnderline(
        child: DropdownButton2<Gender>(
          isExpanded: true,
          hint: Text(
            context.language.gender,
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            overflow: TextOverflow.ellipsis,
          ),
          style: TextStyle(
              fontSize: 12.sp, height: 1, color: context.colorScheme.primary),
          items: Gender.list
              .map((item) => DropdownMenuItem<Gender>(
                    value: item,
                    child: Text(
                      context.isBangla ? item.titleBn : item.titleEn,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: value,
          onChanged: (value) {
            context.read<RegistrationProvider>().selectGender = value;
          },
          buttonStyleData: ButtonStyleData(
            padding:
                EdgeInsets.only(top: 6.h, bottom: 6.h, right: 14.w),
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColors.colorGreyLight,
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
              borderRadius: BorderRadius.circular(10.r),
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
      ),
    );
  }
}
