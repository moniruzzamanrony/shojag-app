import 'package:app/core/utils/enums/message_type.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/fnf/presentation/list/provider/fnf_list_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/colored_background_button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/location_sharing_time_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/loading_animated_button.dart';
import '../../../domain/entity/fnf_list_entity.dart';
import '../../list/provider/fnf_list_action_provider.dart';

/// Fnf Location permission time sheet
class FnfShareLocationTimeSheet extends StatelessWidget {
  final FnfListEntity model;

  const FnfShareLocationTimeSheet({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return _ShareLocationTimeWidget(model: model);
  }
}

class _ShareLocationTimeWidget extends StatefulWidget {
  final FnfListEntity model;

  const _ShareLocationTimeWidget({super.key, required this.model});

  @override
  State<_ShareLocationTimeWidget> createState() =>
      _ShareLocationTimeWidgetState();
}

class _ShareLocationTimeWidgetState extends State<_ShareLocationTimeWidget> {
  late final ValueNotifier<LocationSharingTimeType>
      _locationSharingTimeTypeNotifier;
  late final ValueNotifier<int> _selectedTimeInHourNotifier;

  @override
  void initState() {
    super.initState();
    _locationSharingTimeTypeNotifier = ValueNotifier<LocationSharingTimeType>(
        widget.model.selfLocationSharingTimeType);
    _selectedTimeInHourNotifier = ValueNotifier<int>(1);
  }

  @override
  void dispose() {
    _locationSharingTimeTypeNotifier.dispose();
    _selectedTimeInHourNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CurvedBottomBackground(
      child: Container(
        width: double.infinity,
        padding: Styles.horVerPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.language
                  .shareYourRealTimeLocationWithName(widget.model.userName),
              style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: const DottedLine(
                dashColor: AppColors.colorGreyLight,
              ),
            ),
            _buildOptions(context),
            32.gapH,
            _buildButtons(context)
          ],
        ),
      ),
    );
  }

  // buttons for update and close
  Widget _buildButtons(BuildContext context) {
    final buttonHeight = 40.h;
    final buttonWidth = 120.w;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Consumer(
            builder: (_, ref, __) {
              ref.listen<AsyncValue<void>>(fnfListActionProvider, (prev, next) {
                next.whenOrNull(
                  error: (err, _) {
                    showAppSnackBar(context, err.toString(), type: MessageType.error);
                  },
                );
              });
              return LoadingAnimatedButton(
                height: buttonHeight,
                width: buttonWidth,
                text: context.language.update,
                btnColor: ColoredButtonType.green,
                onTap: (startLoading, stopLoading, btnState) {
                  _updateLocationSharingTime(context, ref,
                      startLoading: startLoading, stopLoading: stopLoading);
                },
              );
            },
          ),
        ),
        32.gapW,
        Flexible(
          child: LoadingAnimatedButton(
            height: buttonHeight,
            width: buttonWidth,
            text: context.language.close,
            btnColor: ColoredButtonType.red,
            onTap: (startLoading, stopLoading, btnState) {
              context.pop();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(BuildContext context) {
    final titleTextStyle =
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold);
    final subtitleTextStyle =
        TextStyle(fontSize: 12.sp, color: AppColors.colorAppGrey);
    final contentPadding = EdgeInsets.zero;
    return ValueListenableBuilder(
      valueListenable: _locationSharingTimeTypeNotifier,
      builder: (_, type, __) => Column(children: [
        Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _selectedTimeInHourNotifier,
                builder: (_, hour, __) {
                  final updatedDate = DateTime.now().add(Duration(hours: hour));
                  String time;
                  if (updatedDate.day != DateTime.now().day) {
                    time = updatedDate.formatDate(pattern: 'dd MMM, hh:mm a');
                  } else {
                    time = updatedDate.formatDate(pattern: 'hh:mm a');
                  }

                  return RadioListTile.adaptive(
                      value: LocationSharingTimeType.limited,
                      contentPadding: contentPadding,
                      onChanged: (v) {
                        if (v != null) {
                          _locationSharingTimeTypeNotifier.value = v;
                        }
                      },
                      groupValue: type,
                      title: Text(context.language.forWithHour(hour),
                          style: titleTextStyle),
                      subtitle: type == LocationSharingTimeType.limited
                          ? Text(context.language.untilWithTime(time),
                              style: subtitleTextStyle.copyWith(
                                  color: context.colorScheme.primary))
                          : null);
                },
              ),
            ),
            if (type == LocationSharingTimeType.limited)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                    color: AppColors.colorGrey.shade(255),
                    borderRadius: BorderRadius.circular(30.r)),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: type == LocationSharingTimeType.unlimited
                          ? null
                          : () {
                              if (_selectedTimeInHourNotifier.value > 1) {
                                _selectedTimeInHourNotifier.value--;
                              }
                            },
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        foregroundColor: context.colorScheme.onPrimary,
                        disabledBackgroundColor: AppColors.colorGreyLight,
                        disabledForegroundColor: AppColors.colorWhite,
                        padding: EdgeInsets.zero,
                        iconSize: 14.sp,
                        visualDensity: const VisualDensity(
                            horizontal: -3.0, vertical: -3.0),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.minus),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _selectedTimeInHourNotifier,
                      builder: (_, hour, __) => SizedBox(
                        width: 32.w,
                        child: Text(
                          hour.toString().padLeft(2, '0'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: type == LocationSharingTimeType.unlimited
                                  ? AppColors.colorGrey
                                  : null,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: type == LocationSharingTimeType.unlimited
                          ? null
                          : () {
                              _selectedTimeInHourNotifier.value++;
                            },
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        foregroundColor: context.colorScheme.onPrimary,
                        disabledBackgroundColor: AppColors.colorGreyLight,
                        disabledForegroundColor: AppColors.colorWhite,
                        padding: EdgeInsets.zero,
                        iconSize: 14.sp,
                        visualDensity: const VisualDensity(
                            horizontal: -3.0, vertical: -3.0),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.plus),
                    ),
                  ],
                ),
              )
          ],
        ),
        RadioListTile.adaptive(
          value: LocationSharingTimeType.unlimited,
          contentPadding: contentPadding,
          onChanged: (v) {
            if (v != null) {
              _locationSharingTimeTypeNotifier.value = v;
            }
          },
          groupValue: type,
          title: Text(
            context.language.untilITurnThisOff,
            style: titleTextStyle,
          ),
        ),
        RadioListTile.adaptive(
          value: LocationSharingTimeType.off,
          contentPadding: contentPadding,
          onChanged: (v) {
            if (v != null) {
              _locationSharingTimeTypeNotifier.value = v;
            }
          },
          groupValue: type,
          title: Text(
            context.language.turnOff,
            style: titleTextStyle,
          ),
        ),
      ]),
    );
  }

  void _updateLocationSharingTime(BuildContext context, WidgetRef ref,
      {required Function startLoading, required Function stopLoading}) async {
    final token = context.apiToken;
    final userId = context.userId;
    final status = _locationSharingTimeTypeNotifier.value.name;
    String? timeLimit;
    if (_locationSharingTimeTypeNotifier.value ==
        LocationSharingTimeType.limited) {
      timeLimit = DateTime.now()
          .add(Duration(hours: _selectedTimeInHourNotifier.value))
          .toIso8601String();
    }

    startLoading.call();

    // shareLocationStatus
    ref
        .read(fnfListActionProvider.notifier)
        .shareLocationStatus(
            fnfId: widget.model.id,
            token: token,
            timeLimit: timeLimit,
            status: status)
        .then((isSuccess) {
      if (isSuccess) {
        ref
            .read(fnfListProvider.notifier)
            .loadList(token: token, userId: userId);

      }
    }).whenComplete(() {
      stopLoading.call();
      if (context.mounted) {
        context.pop();
      }
    });
  }
}
