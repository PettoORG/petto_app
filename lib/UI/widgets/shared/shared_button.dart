import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GlobalGeneralButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  const GlobalGeneralButton({super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Center(
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(75.w, 6.5.h)),
            elevation: MaterialStateProperty.all(10),
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return BorderSide(color: colors.shadow);
                }
                return BorderSide(color: colors.primary);
              },
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
