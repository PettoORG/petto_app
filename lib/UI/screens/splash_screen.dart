import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  static const name = 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SvgPicture.asset(
      'assets/petto.svg',
      height: 200,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
    )
                .animate(
                    onComplete: (_) =>
                        Future.delayed(const Duration(milliseconds: 400), () => context.pushReplacementNamed('home')))
                .fade(duration: const Duration(milliseconds: 700))
                .scale(duration: const Duration(milliseconds: 1000), curve: Curves.easeOutBack)));
  }
}
