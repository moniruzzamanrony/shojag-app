import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/auth/domain/entity/thana_entity.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../provider/registration_provider.dart';

class RegThanaWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController thanaController;

  const RegThanaWidget(
      {super.key, required this.hintText, required this.thanaController});

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

    final inputDecoration = InputDecoration(
      errorStyle: errorStyle,
      enabledBorder: border,
      focusedBorder: border.copyWith(
          borderSide: BorderSide(color: context.colorScheme.primary)),
      border: border,
      fillColor: Colors.white,
      isCollapsed: false,
      filled: true,

      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      hintText: hintText,
      //labelText: labelText,
      isDense: true,
      // suffixIcon: suffixIcon,
      // prefixIcon: prefixIcon,
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
    );

    return DropdownSearch<ThanaEntity?>(
      selectedItem: Provider.of<RegistrationProvider>(context, listen: false)
          .selectedThana,
      compareFn: (ThanaEntity? item1, ThanaEntity? item2) => item1 == item2,
      itemAsString: (item) => item?.name ?? context.language.selectThana,
      items: (filter, infiniteScrollProps) =>
          Provider.of<RegistrationProvider>(context, listen: false)
              .getThanaList(),
      decoratorProps: DropDownDecoratorProps(
        baseStyle: textStyle,
        decoration: inputDecoration,
      ),
      // validator: (value) => FieldValidators.thanaValidator!('123'),
      popupProps: PopupProps.menu(
          showSearchBox: true,
          showSelectedItems: true,
          searchFieldProps: TextFieldProps(
            controller: thanaController,
            style: textStyle,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: inputDecoration.copyWith(
                hintText: context.language.search,
                border: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.colorGreyExtraLight)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.colorGreyExtraLight)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: context.colorScheme.primary))),
          ),
          constraints: BoxConstraints(maxHeight: 200.h)),
      onChanged: (selection) {
        context.read<RegistrationProvider>().selectedThana = selection;
      },
    );
  }
}
