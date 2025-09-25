import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/alert_map/presentation/view_model/category_set_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../provider/alert_map_provider.dart';

class MapFilterWidget extends StatefulWidget {
  final void Function() onSelection;

  const MapFilterWidget({super.key, required this.onSelection});

  @override
  State<MapFilterWidget> createState() => _MapFilterWidgetState();
}

class _MapFilterWidgetState extends State<MapFilterWidget> {
  late final ValueNotifier<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.read<AlertMapProvider>();
    final topCategories = mapProvider.categories;
    final categoriesKeyList = topCategories.keys.toList();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(16.r)),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.centerLeft,
          curve: Curves.decelerate,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isExpanded,
            builder: (_, isExpanded, __) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => _isExpanded.value = !_isExpanded.value,
                  child: CircleAvatar(
                    backgroundColor: isExpanded
                        ? AppColors.colorAppGreen
                        : AppColors.colorWhite,
                    radius: Dimens.borderRadius16,
                    child: Icon(
                      Icons.filter_alt_outlined,
                      size: Dimens.iconSize16,
                      color: isExpanded
                          ? AppColors.colorWhite
                          : AppColors.colorAppGreen,
                    ),
                  ),
                ),
                if (isExpanded)
                  _buildListview(categoriesKeyList, topCategories, mapProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListview(
      List<String> categoriesKeyList,
      Map<String, CategorySetViewModel> topCategories,
      AlertMapProvider mapProvider) {
    if (categoriesKeyList.isEmpty) {
      return Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          context.language.noAlertFound,
          style: const TextStyle(color: Colors.grey),
        ),
      ));
    }
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Selector<AlertMapProvider, String?>(
          selector: (_, provider) => provider.selectedCategory,
          builder: (_, selectedCategory, __) => ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final cKey = categoriesKeyList[index];
                final item = topCategories[cKey]!;
                final isSelected = selectedCategory == item.name;

                final bgColor = isSelected
                    ? AppColors.colorAppGreen
                    : AppColors.colorAppGreen.shade(240);
                final textColor =
                    isSelected ? AppColors.colorWhite : AppColors.colorGrey;

                return InkWell(
                  onTap: () {
                    if (!isSelected) {
                      mapProvider
                        ..selectedCategory = item.name
                        ..notify();
                    } else {
                      mapProvider
                        ..selectedCategory = null
                        ..notify();
                    }
                    widget.onSelection();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      '${item.name} (${item.count})',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12.sp,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          height: 1.0),
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => 4.gapW,
              itemCount: categoriesKeyList.length),
        ),
      ),
    );
  }
}
