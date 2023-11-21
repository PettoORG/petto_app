import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showToast(String text, BuildContext context, {seconds = 2}) async {
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: _Toast(text: text),
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: seconds),
  );
}

class _Toast extends StatelessWidget {
  final String text;
  const _Toast({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Text(text, maxLines: 3, overflow: TextOverflow.ellipsis),
    );
  }
}
