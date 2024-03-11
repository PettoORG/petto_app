import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GlobalPetOptionCard extends StatelessWidget {
  final OptionModel option;
  final Function()? onTap;
  const GlobalPetOptionCard({super.key, required this.option, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4.w),
          child: Ink(
              height: 16.w,
              width: 16.w,
              decoration: BoxDecoration(
                color: option.color,
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Center(
                child: option.child,
              )),
        ),
        SizedBox(height: 1.h),
        Text(
          option.title,
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}

class OptionModel {
  final Widget child;
  final String title;
  final Color color;

  OptionModel({
    required this.child,
    required this.title,
    required this.color,
  });
}
