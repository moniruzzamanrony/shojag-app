import 'package:app/core/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/style/style.dart';
import '../../../domain/entity/alert_entity.dart';
import 'alert_list_single_item.dart';

class AlertListViewWidget extends StatefulWidget {
  final void Function() fetchMore;
  final List<AlertEntity> list;
  final bool isFetching;

  const AlertListViewWidget(
      {super.key,
      required this.fetchMore,
      required this.list,
      required this.isFetching});

  @override
  State<AlertListViewWidget> createState() => _AlertListViewWidgetState();
}

class _AlertListViewWidgetState extends State<AlertListViewWidget> {
  late ScrollController _vtScrollController;

  @override
  void initState() {
    super.initState();
    _vtScrollController = ScrollController();
    _vtScrollController.addListener(listener);
  }

  void listener() {
    if (_vtScrollController.position.pixels ==
        _vtScrollController.position.maxScrollExtent) {
      widget.fetchMore.call();
    }
  }

  @override
  void dispose() {
    _vtScrollController.removeListener(listener);
    _vtScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            controller: _vtScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (context, index) =>
                SizedBox(height: Dimens.padding16),
            padding: Styles.horizontalPadding.copyWith(bottom: 16.h),
            itemBuilder: (context, index) =>
                AlertListSingleItem(item: widget.list[index]),
            itemCount: widget.list.length,
          ),
        ),
        if (widget.isFetching)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator()),
          ),
      ],
    );
  }
}
