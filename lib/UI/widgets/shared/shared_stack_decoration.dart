import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SharedStackDecoration extends StatelessWidget {
  final double size;
  final double angle;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const SharedStackDecoration({
    super.key,
    required this.size,
    this.angle = 0,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Positioned(
      left: left,
      bottom: bottom,
      right: right,
      top: top,
      child: Transform.rotate(
        angle: angle * 3.1415926535897932 / 180,
        child: SvgPicture.asset(
          'assets/petto.svg',
          height: size,
          colorFilter: ColorFilter.mode(color.primaryContainer, BlendMode.srcIn),
        ),
      ),
    );
  }
}
