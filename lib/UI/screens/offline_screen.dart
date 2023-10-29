import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  static const name = 'offline';
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('OfflineScreen'),
      ),
    );
  }
}
