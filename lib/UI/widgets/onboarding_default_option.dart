import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnboardingDefaultOption extends StatelessWidget {
  final String text;
  final Color color;
  final Function()? onTap;
  const OnboardingDefaultOption({
    super.key,
    required this.text,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(3.w),
        child: Ink(
          height: 6.5.h,
          width: 25.w,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3.w), boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(0, 0),
            )
          ]),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: (color == colors.primary) ? colors.background : Theme.of(context).textTheme.bodyLarge!.color,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
