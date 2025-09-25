import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/premium/presentation/widget/package_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widget/custom_app_bar.dart';

class PackageSelectionPage extends StatefulWidget {
  const PackageSelectionPage({super.key});

  @override
  State<PackageSelectionPage> createState() => _PackageSelectionPageState();
}

class _PackageSelectionPageState extends State<PackageSelectionPage> {
  String paidStatus = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: HomeBackground(
        child: Column(
          children: [
            CustomAppBar(
              title: context.language.upgradeToShojagPro,
            ),
            const Expanded(
              child: PackageWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
