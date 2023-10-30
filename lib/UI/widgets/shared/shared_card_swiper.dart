import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SharedCardSwiper extends StatefulWidget {
  final double viewportFraction;
  final int itemCount;
  final bool autoAdvance;
  const SharedCardSwiper(
      {super.key, required this.viewportFraction, required this.itemCount, this.autoAdvance = false});

  @override
  State<SharedCardSwiper> createState() => _SharedCardSwiperState();
}

class _SharedCardSwiperState extends State<SharedCardSwiper> {
  late final PageController _controller;
  late double _currentPage;
  Timer? timer;

  void _listener() {
    setState(() {
      _currentPage = _controller.page!;
    });
  }

  void _startAutoAdvance() {
    timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.itemCount - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoAdvance() {
    timer?.cancel();
  }

  @override
  void initState() {
    _currentPage = 0;
    _controller = PageController(viewportFraction: widget.viewportFraction);
    _controller.addListener(_listener);
    if (widget.autoAdvance) {
      _startAutoAdvance();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    _stopAutoAdvance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double opty;

    return SizedBox(
        height: 25.h,
        width: double.infinity,
        child: GestureDetector(
          onHorizontalDragCancel: () => _stopAutoAdvance(),
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            itemCount: widget.itemCount,
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
                child: _Card(opty: opty),
              );
            },
          ),
        ));
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.opty});
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
