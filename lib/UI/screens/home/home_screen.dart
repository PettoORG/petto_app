import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leadingWidth: 21.w,
          toolbarHeight: 10.h,
          leading: Padding(
            padding: EdgeInsets.all(4.w),
            child: InkWell(
              borderRadius: BorderRadius.circular(1.h),
              child: Ink(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(1.h),
                ),
                child: const Icon(Icons.person),
              ),
            ),
          ),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))],
        ),
        SliverList.list(children: const [_PetViewSwiper()])
      ],
    );
  }
}

class _PetViewSwiper extends StatefulWidget {
  const _PetViewSwiper();

  @override
  State<_PetViewSwiper> createState() => _PetViewSwiperState();
}

class _PetViewSwiperState extends State<_PetViewSwiper> {
  late final PageController _controller;
  late double _currentPage;

  void _listener() {
    setState(() {
      _currentPage = _controller.page!;
    });
  }

  @override
  void initState() {
    _currentPage = 0;
    _controller = PageController(viewportFraction: 0.7);
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double opty;

    return SizedBox(
        height: 25.h,
        width: double.infinity,
        child: PageView.builder(
          controller: _controller,
          itemCount: 5,
          itemBuilder: (context, index) {
            double scale = 1.3;
            if (index == _currentPage) {
              opty = 1;
              scale = 1.3;
            } else if (index < _currentPage) {
              opty = max(1 - (_currentPage - index), 0.5);
              scale = max(1.3 - (_currentPage - index), 0.9);
            } else {
              opty = max(1 - (index - _currentPage), 0.5);
              scale = max(1.3 - (index - _currentPage), 0.9);
            }
            return Transform.scale(
              scale: scale,
              child: _PetView(opty: opty),
            );
          },
        ));
  }
}

class _PetView extends StatelessWidget {
  const _PetView({required this.opty});
  final double opty;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opty,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 5,
                offset: const Offset(0, 0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
