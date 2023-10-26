import 'package:flutter/material.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';

class UserProfileScreen extends StatelessWidget {
  static const name = 'user-profile';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          _DecorationBox(),
          _UserResume(),
        ],
      ),
    );
  }
}

class _UserResume extends StatelessWidget {
  const _UserResume();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12.h,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.w),
        margin: EdgeInsets.symmetric(horizontal: 7.w),
        height: 35.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
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
            Container(
              height: 12.h,
              width: 12.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.w),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Theme.of(context).colorScheme.shadow,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
            SizedBox(height: .5.h),
            const Text('Jorge Arrieta'),
            SizedBox(height: .5.h),
            const Text('jorge.arrieta@gmail.com'),
            SizedBox(height: 2.h),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => const _PetAvatar(),
                      itemCount: 5,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PetAvatar extends StatelessWidget {
  const _PetAvatar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(color: lightSurfaceVariant, borderRadius: BorderRadius.circular(10.w)),
      ),
    );
  }
}

class _DecorationBox extends StatelessWidget {
  const _DecorationBox();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        height: 35.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.h), bottomRight: Radius.circular(5.h))),
      ),
    );
  }
}
