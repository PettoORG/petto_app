import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/utils/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  static const name = 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      final bool shouldShowOnboarding = LocalStorage.prefs.getBool('showOnboarding') == true;
      if (shouldShowOnboarding) return context.pushReplacementNamed('onboarding');
      if (context.read<AuthenticationProvider>().getCurrentUser() != null) {
        return context.pushReplacementNamed('home');
      } else {
        return context.pushReplacementNamed('auth');
      }
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _controller.forward();
    _controller.addStatusListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              height: 75.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.h),
                  bottomRight: Radius.circular(20.h),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Petto',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 35.sp, fontFamily: 'Pacifico-Regular'),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Cuidado de otro mundo',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.h),
                  LottieBuilder.asset(
                    'assets/animations/petto-moon.json',
                    controller: _controller,
                    height: 80.w,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          ),
          Positioned(bottom: 5.h, right: 0.w, left: 0.w, child: const Center(child: Text('Version 1.0.0')))
        ],
      ),
    );
  }
}
