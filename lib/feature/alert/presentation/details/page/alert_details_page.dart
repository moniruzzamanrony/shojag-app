/*
* ui : alert details page
*/

import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/datetime_helper.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/alert/presentation/details/provider/alert_details_provider.dart';
import 'package:app/feature/alert/presentation/details/widget/alert_report_sheet.dart';
import 'package:app/feature/alert/presentation/details/widget/map_view_switch_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/colored_background_button.dart';
import 'package:float_column/float_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/custom_app_bar.dart';
import '../../../../../shared/presentation/widget/custom_app_refresh_indicator.dart';
import '../../../../fnf/presentation/search/widget/empty_contact_list_widget.dart';
import '../../../../response/presentation/page/response_section_widget.dart';
import '../../../domain/entity/alert_entity.dart';
import '../widget/image_view_dialog.dart';

class AlertDetailsPage extends StatefulWidget {
  const AlertDetailsPage({super.key});

  @override
  State<AlertDetailsPage> createState() => _AlertDetailsPageState();
}

class _AlertDetailsPageState extends State<AlertDetailsPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            CustomAppBar(title: context.language.alertDetails),
            Expanded(
              child: CurvedBottomBackground(
                backgroundColor: AppColors.scaffoldBackgroundColorPaleMintLight,
                child: Selector<AlertDetailsProvider, AlertEntity?>(
                  selector: (_, provider) => provider.currentAlert,
                  builder: (_, model, __) {
                    if (model == null) {
                      return const EmptyContactListWidget();
                    }

                    return CustomAppRefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<AlertDetailsProvider>()
                            .loadAlertDetailsWithResponses(
                                userId: context.userId,
                                apiToken: context.apiToken,
                                alertId: model.id,
                                refresh: true)
                            .onError(
                          (error, stackTrace) {
                            if (context.mounted) {
                              showAppSnackBar(context, error.toString(),
                                  type: MessageType.error);
                            }
                          },
                        );
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: Styles.horizontalPadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.gapH,
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(Dimens.padding10),
                                child: FloatColumn(
                                  children: [
                                    _alertTypes(context, model),
                                    _header(context.language.date),
                                    _content(model.createdAt?.formatDate(
                                            pattern: pattern_ddMMMyyyhhmma) ??
                                        ''),
                                    _separator(),
                                    _header(context.language.name),
                                    _content(model.userName),
                                    _separator(),
                                    _header(context.language.typeOfIncident),
                                    _content(model.incidentTitle),
                                    _separator(),
                                    _header(context.language.alertDescription),
                                    _content(model.description ?? ''),
                                    _separator(),
                                    if (model.image != null) ...[
                                      _buildImageView(model.image!, context),
                                      _separator(),
                                    ],
                                    _header(context.language.location),
                                    if (model.address != null)
                                      _content(model.address ?? ''),
                                    if (model.geoAddress != null)
                                      _content(model.geoAddress ?? ''),
                                    MapViewSwitchWidget(
                                        eventLatLng: LatLng(
                                            model.latitude, model.longitude),
                                        isOwnPost:
                                            model.userId == context.userId),
                                    if (context
                                            .isAPoliceOrFireServiceOrAmbulance &&
                                        model.userPhone != null &&
                                        model.userPhone!.isNotEmpty) ...[
                                      _separator(),
                                      _phoneSection(context, model.userPhone!,
                                          model.userName)
                                    ]
                                  ],
                                ),
                              ),
                            ),
                            //_separator(),
                           // _alertClosedMessagedSection(context),
                            _separator(),
                            ResponseSectionWidget(
                                scrollController: _scrollController),
                            _separator(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertClosedMessagedSection(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: AppColors.colorAppRed.shade(220),
            borderRadius: BorderRadius.circular(Dimens.borderRadius10)),
        child: Text(
          'The alert is automatically closed by system due to inactivity',
          style: TextStyle(fontSize: 11.sp, color: AppColors.colorAppRed),
        ));
  }

  Widget _phoneSection(BuildContext context, String phone, String userName) {
    return ColoredBackgroundButton(
      customChild: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.phoneVolume,
            size: 14.sp,
            color: Colors.white.shade(50),
          ),
          8.gapW,
          Text(' $userName',
              style: TextStyle(
                  fontSize: 14.sp,
                  height: 1,
                  color: Colors.white.shade(50),
                  fontWeight: FontWeight.bold)),
        ],
      ),
      onPressed: () async {
        if (phone.isEmpty) {
          showAppSnackBar(context, 'Invalid Phone', type: MessageType.error);
          return;
        }
        final uri = Uri.parse('tel:$phone');
        if (await canLaunchUrl(uri)) {
          launchUrl(uri);
        }
      },
      buttonColor: ColoredButtonType.green,
    );
  }

  Widget _separator() => 12.gapH;

  Widget _content(String text) => Text(
        text,
        //textAlign: TextAlign.justify,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.colorBlack),
      );

  Widget _header(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.colorAppGrey),
      );

  Widget _buildImageView(String url, BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            //barrierDismissible: false,
            context: context,
            builder: (context) => ImageViewDialog(url: url));
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(),
        visualDensity: Styles.minimumVisualDensity,
      ),
      child: Text(context.language.viewImage),
    );
  }

  Widget _alertTypes(BuildContext context, AlertEntity model) {
    final reportButton = Floatable(
      float: FCFloat.end,
      clear: FCClear.start,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => AlertReportSheet(model: model));
        },
        child: Tooltip(
          message: context.language.ifYouFindThisAlertPostCommentMisleading,
          margin: Styles.horizontalPadding,
          child: Icon(
            Icons.info,
            color: AppColors.colorAppGrey,
            size: 18.sp,
          ),
        ),
      ),
    );

    if (context.userId != model.userId) {
      //return SizedBox.shrink();
      return reportButton;
    }

    final alertTypes = model.alertCategories;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Wrap(
              spacing: 4.r,
              runSpacing: 4.r,
              children: List.generate(
                alertTypes.length,
                (index) {
                  final item = alertTypes[index];
                  return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: getCardColorByAlertType(item)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.isBangla ? item.titleBn : item.titleEn,
                            style: TextStyle(
                                fontSize: 9.sp,
                                height: 1.0,
                                color: getCardBorderColorByAlertType(item)),
                          ),
                          2.gapW,
                          SvgPicture.asset(getAssetsSvgByAlertType(item),
                              width: 9.r, height: 9.r),
                        ],
                      ));
                },
              ),
            ),
          ),
        ),
        reportButton,
      ],
    );
  }
}
