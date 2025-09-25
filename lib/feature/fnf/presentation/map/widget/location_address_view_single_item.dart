import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

import '../../../domain/entity/fnf_list_entity.dart';

class LocationAddressViewSingleItem extends StatelessWidget {
  final FnfLocationsEntity item;
  final LatLng baseLocation;

  final VoidCallback onDelete;
  final VoidCallback onTap;

  const LocationAddressViewSingleItem({
    super.key,
    required this.item,
    required this.baseLocation,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final addressLocation = LatLng(item.latitude, item.longitude);
    final distanceInMeters = const Distance(roundResult: false).as(LengthUnit.Kilometer, baseLocation, addressLocation);

    final label = item.label;
    final distance = distanceInMeters.kmToDistanceModel;

    return InkWell(
      onTap: onTap,
      // onTap: () async {
      // final controller = context.read<FnfMapViewProvider>().mapController;
      // final cameraState = await controller?.getCameraState();
      // final point =
      //     Point(coordinates: Position(item.longitude, item.latitude));
      //
      // controller?.flyTo(
      //     CameraOptions(
      //         center: point,
      //         zoom: cameraState?.zoom,
      //         bearing: cameraState?.bearing,
      //         pitch: cameraState?.pitch),
      //     MapAnimationOptions(duration: 1000));
      // },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: context.colorScheme.primary.withValues(alpha: 0.85),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flag, color: context.colorScheme.primary.shade(220), size: 12.sp),
            2.gapW,
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.normal,
                  color: context.colorScheme.primary.shade(220),
                  height: 1.0,
                ),
              ),
            ),
            2.gapW,
            Text(
              context.language.toKMConverter(distance.unit.name, distance.distance),
              maxLines: 1,
              style: TextStyle(
                fontSize: 11.sp,
                height: 1.0,
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            2.gapW,
            InkWell(
              onTap: onDelete,
              child: CircleAvatar(
                radius: 8.r,
                backgroundColor: context.colorScheme.primary.shade(100),
                child: Icon(Icons.close, color: context.colorScheme.onPrimary, size: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext ctx, WidgetRef ref) async {
    // showAppDialog(ctx,
    //     dialogWidget: ChangeNotifierProvider.value(
    //       value: ctx.read<FnfMapViewProvider>(),
    //       builder: (context, _) => ChangeNotifierProvider.value(
    //         value: ctx.read<FnfMapViewAddressProvider>(),
    //         builder: (context, __) => AlertDialog(
    //           title: Text(context.language.confirmation),
    //           content: Text(
    //             context.language.areYouSureYouWantToRemoveAddress,
    //             style: const TextStyle(color: AppColors.colorBlack),
    //           ),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 context.pop();
    //               },
    //               child: Text(context.language.cancel),
    //             ),
    //             LoadingAnimatedButton(
    //               height: listPopupButtonHeight,
    //               width: listPopupButtonWidth,
    //               minWidth: listPopupButtonMinWidth,
    //               text: context.language.confirm,
    //               btnColor: ColoredButtonType.green,
    //               onTap: (startLoading, stopLoading, btnState) {
    //                 _delete(context, item,
    //                     startLoading: startLoading, stopLoading: stopLoading);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
  }

  void _delete(
    BuildContext context,
    FnfLocationsEntity model, {
    required Function startLoading,
    required Function stopLoading,
  }) {
    // startLoading.call();
    // context
    //     .read<FnfMapViewAddressProvider>()
    //     .deleteAddress(
    //       fnfLocationId: model.id,
    //       token: context.apiToken,
    //     )
    //     .onError((error, stacktrace) {
    //   if (context.mounted) {
    //     showAppSnackBar(context, error.toString(), type: MessageType.error);
    //   }
    //   return false;
    // }).then((v) async {
    //   if (v && context.mounted) {
    //     final listProvider = context.read<OutgoingFnfListProvider>();
    //     final fnfMapViewProvider = context.read<FnfMapViewProvider>();
    //     context.pop();
    //
    //     showAppSnackBar(context, context.language.addressDeletedSuccessfully,
    //         type: MessageType.success);
    //
    //     await listProvider.fetchList(
    //         token: context.apiToken, userId: context.userId);
    //     final updatedModel =
    //         listProvider.getFnfById<AcceptedOutgoingFnfListEntity>(model.fnfId);
    //     if (updatedModel != null) {
    //       fnfMapViewProvider.setModel(updatedModel);
    //     }
    //   }
    // }).whenComplete(() {
    //   stopLoading.call();
    // });
  }
}
