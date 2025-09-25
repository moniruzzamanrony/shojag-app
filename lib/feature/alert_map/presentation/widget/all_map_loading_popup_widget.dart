import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/style/style.dart';
import '../provider/alert_map_provider.dart';

class AllMapLoadingPopupWidget extends StatelessWidget {
  const AllMapLoadingPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AlertMapProvider, bool>(
      selector: (_, provider) => provider.isLoading,
      builder: (_, isLoading, __) => isLoading
          ? Align(
              child: Dialog(
                backgroundColor: context.colorScheme.surface.withAlpha(220),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: .5.sw),
                  child: Padding(
                    padding: Styles.horizontalPadding.copyWith(
                      top: 12.h,
                      bottom: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${context.language.loading} . . .',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        SizedBox(
                          height: 24.r,
                          width: 24.r,
                          child: CircularProgressIndicator(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
