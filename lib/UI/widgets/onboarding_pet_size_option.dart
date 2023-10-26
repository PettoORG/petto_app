import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class OnboardingPetSizeOption extends StatelessWidget {
  final String asset;
  final Color color;
  final String text;
  final double width;
  final Function()? onTap;

  const OnboardingPetSizeOption({
    super.key,
    required this.asset,
    required this.color,
    required this.text,
    this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.w),
      child: Ink(
        padding: EdgeInsets.all(2.5.w),
        width: width,
        height: 15.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(
            color: (color == Theme.of(context).colorScheme.primaryContainer)
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                asset,
                height: 20.w,
              ),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
