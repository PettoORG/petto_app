import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: InkWell(
        child: Ink(
          width: double.infinity,
          height: 9.h,
          decoration: BoxDecoration(
            color: color.surfaceVariant,
            borderRadius: BorderRadius.circular(5.w),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: color.shadow,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
