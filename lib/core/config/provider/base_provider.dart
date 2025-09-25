// This [base_provider.dart] is for base provider class.
// It is used to create provider with common methods

import 'package:flutter/foundation.dart';

abstract class BaseProvider extends ChangeNotifier {
  void resetAll();

  void notify();
}
