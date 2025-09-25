/* * File for empty contact list widget when no contact is found in the list
 * of sent, pending and accepted friend and neighbor list.
 */

import 'package:app/shared/presentation/widget/drop_lottie_anim.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/assets.dart';

class EmptyContactListWidget extends StatelessWidget {
  const EmptyContactListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                  height: constraints.maxHeight,
                  child: const SimpleLottie(
                    Assets.contactEmptyAnimationJson,
                  )),
            ));
  }
}
