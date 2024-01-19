import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/utils/utils.dart';
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
  String version = '';
  void _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() => version = packageInfo.version);
  }

  void _listener(AnimationStatus status) async {
    bool? onboarding = LocalStorage.prefs.getBool('showOnboarding');
    User? user = context.read<AuthenticationProvider>().getCurrentUser();
    PetProvider petsProvider = context.read<PetProvider>();
    ReminderProvider reminderProvider = context.read<ReminderProvider>();
    UserProvider userProvider = context.read<UserProvider>();
    if (status == AnimationStatus.completed) {
      reminderProvider.requestNotificationPermission();
      if (onboarding == true || onboarding == null) return context.pushReplacementNamed('onboarding');
      if (user == null) return context.pushReplacementNamed('auth');
      try {
        await userProvider.getUser();
        await reminderProvider.getReminders();
        await petsProvider.getPets();
        if (!context.mounted) return;
        if (petsProvider.pets.isEmpty) {
          return context.pushReplacementNamed('pet-register');
        } else {
          return context.pushReplacementNamed('home');
        }
      } catch (e) {
        logger.e('GETPETS ERROR IN SPLASH: $e');
        showToast('error'.tr(), context);
      }
    }
  }

  @override
  void initState() {
    _getVersion();
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 35.sp,
                          fontFamily: 'Pacifico-Regular',
                          color: Colors.black,
                        ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'yourWellCaredPet'.tr(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
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
          Positioned(bottom: 5.h, right: 0.w, left: 0.w, child: Center(child: Text(version)))
        ],
      ),
    );
  }
}
