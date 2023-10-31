import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/utils/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  static const name = 'splash';

  const SplashScreen({Key? key}) : super(key: key);

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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 35.sp),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Tu mascota, bien cuidada',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 10.h),
                  SvgPicture.asset(
                    'assets/petto.svg',
                    height: 35.h,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  )
                      .animate(
                        onComplete: (_) async {
                          final bool isOnline =
                              await context.read<ConnectionStatusProvider>().checkInternetConnection();
                          final bool shouldShowOnboarding = LocalStorage.prefs.getBool('showOnboarding') == true;
                          if (!context.mounted) {
                            return;
                          }
                          if (shouldShowOnboarding) {
                            context.pushReplacementNamed('onboarding');
                          } else if (isOnline) {
                            context.pushReplacementNamed('home');
                          } else {
                            context.pushReplacementNamed('offline');
                          }
                        },
                      )
                      .scale(duration: const Duration(milliseconds: 1000), curve: Curves.easeOutBack)
                      .fade(
                        duration: const Duration(milliseconds: 500),
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
