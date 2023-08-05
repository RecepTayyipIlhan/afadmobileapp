import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';

enum NetworkStatus {
  NotDetermined,
  On,
  Off;

  bool get isOff => this == NetworkStatus.Off;
  bool get isOn => this == NetworkStatus.On;
}

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  NetworkDetectorNotifier._() : super(NetworkStatus.NotDetermined) {}

  NetworkStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return NetworkStatus.On;
      case ConnectivityResult.none:
        return NetworkStatus.Off;
      default:
        return NetworkStatus.NotDetermined;
    }
  }

  Future<void> initialize() async {
    var connectivity = Connectivity();

    final initStat = await connectivity.checkConnectivity();
    state = _getStatusFromResult(initStat);

    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        final lastResult = _getStatusFromResult(result);
        state = lastResult;
      },
    );
  }

  Future<void> refresh(BuildContext context) async {
    try {
      Loading.load(context);
      final connectivity = Connectivity();

      // the user is not seeing the loading screen
      // so we need to wait a bit
      // because checkConnectivity is fast
      await Future.delayed(
        const Duration(seconds: 1),
      );

      final initStat = await connectivity.checkConnectivity();
      state = _getStatusFromResult(initStat);
      Loading.unload(context);
    } catch (e) {
      Loading.unload(context);
    }
  }
}

final networkAwareProvider =
    StateNotifierProvider<NetworkDetectorNotifier, NetworkStatus>(
  (ref) {
    return NetworkDetectorNotifier._();
  },
);
