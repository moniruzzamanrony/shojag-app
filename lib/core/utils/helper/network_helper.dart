// this file [network_helper.dart] is for the network helper
// it is used to check if the device is connected to the internet

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/// check if the device is connected to the internet
Future<bool> get isNetworkAvailable async {
  // check if there is a valid network connection
  final connectivityResult = await Connectivity().checkConnectivity();

  return await hasInternetConnection(connectivityResult);
}

/// check if the device is connected to the internet
Future<bool> hasInternetConnection(
    List<ConnectivityResult> connectivityResult) async {
  bool hasConnection = false;
  for (var connection in connectivityResult) {
    if (connection == ConnectivityResult.mobile) {
      hasConnection = true;
    }
    if (connection == ConnectivityResult.wifi) {
      hasConnection = true;
    }
    if (connection == ConnectivityResult.vpn) {
      hasConnection = true;
    }
    if (connection == ConnectivityResult.ethernet) {
      hasConnection = true;
    }
  }

  if (!hasConnection) {
    return false;
  }

  // check if the network is really connected to Internet
  try {
    final result = await InternetAddress.lookup('8.8.8.8');
    if (result.isEmpty || result[0].rawAddress.isEmpty) {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }

  return true;
}

Stream<List<ConnectivityResult>> onInternetConnectivityChanged() {
  return Connectivity().onConnectivityChanged;
}
