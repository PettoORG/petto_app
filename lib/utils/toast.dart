import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';

Future<void> showToast(String toast_message, String toast_subMessage, BuildContext context, {seconds = 2}) async {
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: _Toast(toast_message: toast_message, toast_subMessage: toast_subMessage,),
    gravity: ToastGravity.TOP,
    toastDuration: Duration(seconds: seconds),
  );
}

class _Toast extends StatelessWidget {
  final String toast_message;
  final String toast_subMessage;

  const _Toast({required this.toast_message, required this.toast_subMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.w),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: ListTile(
                leading: Icon(BoxIcons.bx_error),
                title:  Text(toast_message, style: Theme.of(context).textTheme.titleSmall,),
                subtitle: Text(toast_subMessage, style: Theme.of(context).textTheme.bodySmall,),
                )
    );
  }
}
