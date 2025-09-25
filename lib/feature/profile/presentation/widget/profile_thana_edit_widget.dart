import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/auth/domain/entity/thana_entity.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../auth/presentation/provider/registration_provider.dart';

class ProfileThanaEditWidget extends HookWidget {
  final String hintText;
  final TextEditingController thanaController;
  final ValueChanged<ThanaEntity> onChanged;

  const ProfileThanaEditWidget(
      {super.key,
      required this.hintText,
      required this.thanaController,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final thanaNotifier = useValueNotifier<ThanaEntity?>(null);

    final borderRadius = BorderRadius.circular(5.r);
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

    return ValueListenableBuilder(
      valueListenable: thanaNotifier,
      builder: (_, value, __) => DropdownSearch<ThanaEntity?>(
        selectedItem: value,
        compareFn: (ThanaEntity? item1, ThanaEntity? item2) => item1 == item2,
        itemAsString: (item) => item?.name ?? context.language.selectThana,
        items: (filter, infiniteScrollProps) =>
            context.read<RegistrationProvider>().getThanaList(),
        decoratorProps: DropDownDecoratorProps(
          baseStyle: textStyle,
          decoration: inputDecoration,
        ),
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
          thanaNotifier.value = selection;
          if (selection != null) {
            onChanged.call(selection);
          }
        },
      ),
    );
  }
}
