import 'package:flutter/widgets.dart';
/// [CustomScrollBehavior] is a class that extends [ScrollBehavior]
class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
