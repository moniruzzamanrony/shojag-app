import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/presentation/widget/drop_lottie_anim.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedTopRadiusToChild(
      child: CurvedBottomBackground(
        hasBackground: false,
        //backgroundColor: AppColors.scaffoldBackgroundColorPaleMint,
        child: _buildInfo(context),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      children: [
        16.gapH,
        SizedBox(
          height: 300.h,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const PulseLottieAnim(
                color: AppColors.colorAppRed,
              ),
              InkWell(
                onTap: _tryCallingEmergency,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40.r,
                  child: FaIcon(
                    FontAwesomeIcons.phoneVolume,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        20.gapH,
        Text(context.language.wantToGetDirectHelp,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.sp, fontWeight: FontWeight.bold, height: 1.0)),
        12.gapH,
        StyledText(
            text: context.language.callNowToTalk,
            tags: {
              'call': StyledTextWidgetBuilderTag((ctx, data, value) {
                return InkWell(
                    onTap: _tryCallingEmergency,
                    child: Text(
                      value ?? '',
                      style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorAppRed),
                    ));
              }),
            },
            style: TextStyle(fontSize: 14.sp, color: Colors.grey, height: 1.0)),
      ],
    );
  }

  void _tryCallingEmergency() async {
    try {
      final uri = Uri.parse('tel:999');
      if (await canLaunchUrl(uri)) {
        launchUrl(uri);
      }
    } catch (_) {}
  }
}
