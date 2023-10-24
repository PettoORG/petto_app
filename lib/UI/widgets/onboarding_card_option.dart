import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CardOption extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final Color? borderColor;
  final Widget? child;

  const CardOption({
    super.key,
    this.onTap,
    required this.color,
    this.child,
    this.borderColor, // No es necesario el "required" aquí
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.w),
      child: Ink(
        height: 10.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: borderColor ?? Colors.transparent),
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Theme.of(context).colorScheme.shadow, offset: const Offset(0, 0))
          ],
        ),
        child: child,
      ),
    );
  }
}
