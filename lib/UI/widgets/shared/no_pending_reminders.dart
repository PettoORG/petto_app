import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class NoPendingReminders extends StatelessWidget {
  const NoPendingReminders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textStyles = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.all(1.w),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/reminder.svg',
            height: 20.h,
          ),
          SizedBox(height: 2.h),
          Text(
            'No tienes recordatorios pendientes',
            style: textStyles.titleSmall,
          )
        ],
      ),
    );
  }
}
