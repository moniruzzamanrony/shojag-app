import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/alert/presentation/create/widget/add_form_text_field.dart';
import 'package:app/feature/alert/presentation/create/widget/alert_add_location_widget.dart';
import 'package:app/feature/alert/presentation/create/widget/image_button_widget.dart';
import 'package:app/feature/alert/presentation/create/widget/incident_search_widget.dart';
import 'package:app/feature/alert/presentation/create/widget/info_notice_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../provider/alert_add_provider.dart';
import '../widget/alert_add_button_widget.dart';
import '../widget/mandatory_widget.dart';

/// UI [AlertFormCommunity] for community alert
class AlertFormCommunity extends StatelessWidget {
  const AlertFormCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _itemGap10(),
        const MandatoryWidget(),
        const IncidentSearchWidget(),
        _itemGap10(),
        const MandatoryWidget(),
        AddFormTextField(
          hintText: context.language.describeYourIncident,
          maxLines: 4,
          onChanged: (v) {
            context.read<AlertAddProvider>().description = v;
          },
        ),
        _itemGap10(),
        const MandatoryWidget(),
        const AlertAddLocationWidget(),
        _itemGap10(),
        AddFormTextField(
            hintText: context.language.egFlatNoRoadNo,
            onChanged: (v) {
              context.read<AlertAddProvider>().detailAddress = v;
            }),
        _itemGap20(),
        const ImageButtonWidget(),
        _itemGap20(),
       // const ShareAlsoWidget(currentType: AlertType.community),
        const AlertAddButtonWidget(currentType: AlertType.community),
        _itemGap20(),
        const InfoNoticeWidget(),
        MediaQuery.viewInsetsOf(context).bottom.gapH,
      ],
    );
  }

  Gap _itemGap10() => 10.gapH;

  Gap _itemGap20() => 20.gapH;
}
