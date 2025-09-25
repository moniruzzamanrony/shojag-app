import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:app/feature/fnf/presentation/map/page/fnf_map_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/constants/assets.dart';
import '../../map/provider/current_fnf_model_provider.dart';

class FnfViewMapButton extends StatelessWidget {
  final FnfListEntity model;

  const FnfViewMapButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: InkWell(
        onTap: () => _mapViewButtonAction(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Skeleton.shade(
              child: SvgPicture.asset(
                Assets.navMapSvg,
                height: 20.r,
                width: 20.r,
              ),
            ),
            Text(
              context.language.viewMap
              //.split(' ').join('\n')
              ,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  void _mapViewButtonAction(BuildContext context) {
    //   final providers = [
    //     ChangeNotifierProvider(create: (_) => FnfMapViewProvider(model)),
    //     ChangeNotifierProxyProvider<FnfMapViewProvider,
    //         FnfMapViewAddressProvider>(
    //       create: (ctx) => FnfMapViewAddressProvider(
    //           ctx.read<FnfMapViewProvider>().model.locations),
    //       update: (_, value, __) =>
    //           FnfMapViewAddressProvider(value.model.locations),
    //     ),
    //   ];
    //
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProviderScope(
          overrides: [
            currentFnfModelProvider.overrideWith(
              (ref) => model,
            ),
          ],
          child: const FnfMapViewPage(),
        ),
      ),
    );
    // }
  }
}
