import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionStatusProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isOnline = true;

  Future<void> checkInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result != ConnectivityResult.none) {
        _isOnline = true;
        notifyListeners();
      } else {
        _isOnline = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isOnline = false;
      notifyListeners();
    }
  }

  bool get isOnline => _isOnline;
}
