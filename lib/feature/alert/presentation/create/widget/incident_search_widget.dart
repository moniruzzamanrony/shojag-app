import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/feature/alert/presentation/create/widget/add_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../domain/entity/incident_type_view_model.dart';
import '../../incident_provider.dart';
import '../provider/alert_add_provider.dart';

/// UI [IncidentSearchWidget] for incident search
class IncidentSearchWidget extends StatefulWidget {
  const IncidentSearchWidget({super.key});

  @override
  State<IncidentSearchWidget> createState() => _IncidentSearchWidgetState();
}

class _IncidentSearchWidgetState extends State<IncidentSearchWidget> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AlertAddProvider, IncidentTypeViewModel?>(
      selector: (_, provider) => provider.selectedIncidentType,
      builder: (_, value, __) {
        return SizedBox(
          height: 40.h,
          child: TypeAheadField<IncidentTypeViewModel?>(
            controller: _textEditingController,
            focusNode: _focusNode,
            suggestionsCallback: (search) => _suggestionsCallback(search),
            emptyBuilder: (context) {
              context.read<AlertAddProvider>()
                ..selectedIncidentType = null
                ..customIncident = _textEditingController.text.trim().isEmpty
                    ? null
                    : _textEditingController.text.trim();
              return const SizedBox.shrink();
            },
            builder: (context, controller, focusNode) {
              return AddFormTextField(
                controller: controller,
                focusNode: focusNode,
                hintText: context.language.selectIncidentType,
              );
            },
            animationDuration: const Duration(milliseconds: 100),
            debounceDuration: Duration.zero,
            constraints: BoxConstraints(maxHeight: 200.h),
            itemBuilder: (_, item) {
              final isBangla = context.isBangla;
              final title = isBangla ? item?.titleBn : item?.titleEn;
              final subTitle = isBangla ? item?.titleEn : item?.titleBn;

              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                dense: true,
                visualDensity: Styles.minimumVisualDensity,
                title: Text(title ?? '',
                    style: TextStyle(
                        height: 1.0,
                        fontSize: 12.sp,
                        color: AppColors.colorBlack)),
                subtitle: Text(
                  subTitle ?? '',
                  style: TextStyle(
                      height: 1.0, color: AppColors.colorGrey, fontSize: 10.sp),
                ),
              );
            },
            onSelected: (item) {
              _textEditingController.text = item?.titleEn ?? '';
              context.read<AlertAddProvider>().updateSelectedType(item);
            },
          ),
        );
      },
    );
  }

  List<IncidentTypeViewModel> _suggestionsCallback(String search) {
    final typeList = context.read<IncidentProvider>().incidentTypeList;

    final filteredList = typeList.where(
      (element) {
        final tags = element.tags.join();
        return element.titleEn.toLowerCase().contains(search.toLowerCase()) ||
            element.titleBn.contains(search.toLowerCase()) ||
            tags.toLowerCase().contains(search.toLowerCase());
      },
    ).toList();
    if (filteredList.isNotEmpty) {
      context.read<AlertAddProvider>().customIncident =
          _textEditingController.text;
    }

    return filteredList;
  }
}
