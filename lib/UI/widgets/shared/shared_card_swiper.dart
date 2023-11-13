import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SharedCardSwiper extends StatefulWidget {
  final double viewportFraction;
  final int itemCount;
  final bool autoAdvance;
  final List<Widget>? children;
  final Function()? onTap;
  const SharedCardSwiper(
      {super.key,
      required this.viewportFraction,
      required this.itemCount,
      this.autoAdvance = false,
      this.onTap,
      this.children});

  @override
  State<SharedCardSwiper> createState() => _SharedCardSwiperState();
}

class _SharedCardSwiperState extends State<SharedCardSwiper> {
  late final PageController _controller;
  late double _currentPage;
  late Timer? autoPlayTimer;
  late Timer? inactivityTimer;

  void _listener() {
    setState(() {
      _currentPage = _controller.page!;
      _resetInactivityTimer();
    });
  }

  void _resetInactivityTimer() {
    inactivityTimer?.cancel();
    inactivityTimer = Timer(const Duration(seconds: 10), () {
      if (widget.autoAdvance) {
        _startAutoAdvance();
        _resetInactivityTimer();
      }
    });
  }

  void _startAutoAdvance() {
    autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.itemCount - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => _controller.animateToPage(0, duration: const Duration(milliseconds: 1500), curve: Curves.easeInOutBack),
        );
      }
    });
  }

  void _stopAutoAdvance() {
    autoPlayTimer?.cancel();
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
    inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double opty;

    return SizedBox(
        height: 25.h,
        width: double.infinity,
        child: GestureDetector(
          onHorizontalDragCancel: () {
            _stopAutoAdvance();
            _resetInactivityTimer();
          },
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
                child: _Card(
                  opty: opty,
                  onTap: widget.onTap,
                  child: widget.children?[index] ?? Container(),
                ),
              );
            },
          ),
        ));
  }
}

class _Card extends StatelessWidget {
  final double opty;
  final Function()? onTap;
  final Widget? child;
  const _Card({required this.opty, required this.onTap, this.child});
  @override
  Widget build(BuildContext context) {
    final double borderRadius = 5.w;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: opty,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
