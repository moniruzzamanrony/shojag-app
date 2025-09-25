import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// UI [InfoNoticeWidget] for info notice
///
class InfoNoticeWidget extends StatelessWidget {
  const InfoNoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xff339900);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: color.shade(240), borderRadius: BorderRadius.circular(8.0)),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
                child: Icon(FontAwesomeIcons.circleInfo,
                    color: color, size: Dimens.iconSize12)),
            WidgetSpan(child: SizedBox(width: Dimens.padding8)),
            TextSpan(
              text: context.language.communityAlertCreateInfoNotice,
              style: TextStyle(
                fontSize: Dimens.fontSize11,
                fontWeight: FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: Dimens.fontSize11,
          fontWeight: FontWeight.normal,
          color: color,
        ),
      ),
    );
  }
}
