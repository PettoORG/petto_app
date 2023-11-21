import 'package:flutter/material.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';

class GlobalCardOption extends StatelessWidget {
  final CardModel option;
  const GlobalCardOption(this.option, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: option.onTap,
      borderRadius: BorderRadius.circular(5.w),
      child: Ink(
        padding: EdgeInsets.all(4.w),
        width: double.infinity,
        height: 9.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(5.w),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
                height: 5.5.h,
                width: 5.5.h,
                decoration: BoxDecoration(color: lightPrimaryContainer, borderRadius: BorderRadius.circular(1.h)),
                child: Icon(option.icon, color: lightPrimary)),
            SizedBox(
              width: 3.w,
            ),
            Text(
              option.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 7.w,
              color: lightShadowColor,
            )
          ],
        ),
      ),
    );
  }
}

class CardModel {
  final String title;
  final IconData icon;
  final Function()? onTap;

  CardModel({required this.title, required this.icon, required this.onTap});
}
