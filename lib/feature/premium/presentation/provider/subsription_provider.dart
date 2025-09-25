// import 'package:app/core/config/provider/base_provider.dart';
//
// class SubscriptionProvider extends BaseProvider {
//   final double amount = 20;
//   final int days = 30;
//
//   @override
//   void notify() => notifyListeners();
//
//   @override
//   void resetAll() {}
// }
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscriptionProvider = Provider<SubscriptionData>((ref) {
  return const SubscriptionData(amount: 20, days: 30);
});

class SubscriptionData {
  final double amount;
  final int days;

  const SubscriptionData({
    required this.amount,
    required this.days,
  });
}