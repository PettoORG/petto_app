import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class AddReminderScreen extends StatelessWidget {
  static const name = 'add-reminder';
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const _SliverAppBar(),
        SliverList.list(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const _PetSelector(),
            ),
          ],
        )
      ],
    ));
  }
}

class _PetSelector extends StatelessWidget {
  const _PetSelector();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.h,
          height: 8.h,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 3.w),
        const Text('Pet Name')
      ],
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: const Text('Agregar recordatorio'),
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
