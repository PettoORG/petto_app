import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionStatusProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  Future<bool> checkInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result != ConnectivityResult.none) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
