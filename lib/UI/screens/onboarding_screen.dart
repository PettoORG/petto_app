import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/utils/local_storage.dart';
import 'package:petto_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends StatefulWidget {
  static const name = 'onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController controller;
  late int currentPage = 0;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PetProvider petProvider = context.read<PetProvider>();
    ReminderProvider reminderProvider = context.read<ReminderProvider>();
    UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: [
              _OnboardingView(
                asset: 'assets/animations/petto-space.json',
                title: 'yourWellCaredPet'.tr(),
                text: 'pettoHelpsYourPet'.tr(),
                leftBorderRadius: true,
                backgrounColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              _OnboardingView(
                asset: 'assets/animations/petto-planet.json',
                title: 'essentialReminders'.tr(),
                text: 'pettoRemindsYou'.tr(),
                backgrounColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
              _OnboardingView(
                asset: 'assets/animations/petto-moon.json',
                title: 'pettips'.tr(),
                text: 'pettoProvidesTips'.tr(),
                rightBorderRadius: true,
                backgrounColor: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            ],
          ),
          Positioned(
            bottom: 2.h,
            right: 0,
            left: 0,
            child: Container(
              height: 7.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: (currentPage == 0)
                        ? TextButton(
                            onPressed: () async {
                              LocalStorage.prefs.setBool('showOnboarding', false);
                              User? user = context.read<AuthenticationProvider>().getCurrentUser();
                              if (user == null) return context.pushReplacementNamed('auth');
                              try {
                                await userProvider.getUser();
                                await reminderProvider.getReminders();
                                await petProvider.getPets().then(
                                  (_) {
                                    if (petProvider.pets.isEmpty) {
                                      return context.pushReplacementNamed('pet-register');
                                    } else {
                                      return context.pushReplacementNamed('home');
                                    }
                                  },
                                );
                              } catch (e) {
                                if (!context.mounted) return;
                                showToast('error'.tr(), context);
                              }
                            },
                            child: Text('skip'.tr()))
                        : IconButton(
                            onPressed: () {
                              controller.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInQuint,
                              );
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ...List.generate(3, (index) {
                    return _Dot(
                      color: (currentPage == index)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onBackground,
                      size: (currentPage == index) ? 3.5.w : 2.5.w,
                    );
                  }),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    flex: 4,
                    child: (currentPage == 2)
                        ? TextButton(
                            onPressed: () async {
                              LocalStorage.prefs.setBool('showOnboarding', false);
                              User? user = context.read<AuthenticationProvider>().getCurrentUser();
                              if (user == null) return context.pushReplacementNamed('auth');
                              try {
                                await userProvider.getUser();
                                await reminderProvider.getReminders();
                                await petProvider.getPets().then(
                                  (_) {
                                    if (petProvider.pets.isEmpty) {
                                      return context.pushReplacementNamed('pet-register');
                                    } else {
                                      return context.pushReplacementNamed('home');
                                    }
                                  },
                                );
                              } catch (e) {
                                if (!context.mounted) return;
                                showToast('error'.tr(), context);
                              }
                            },
                            child: Text('letsGo'.tr()),
                          )
                        : IconButton(
                            onPressed: () {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInQuint,
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;

  const _Dot({
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      duration: const Duration(milliseconds: 200),
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: color,
      ),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  final String asset;
  final String title;
  final String text;
  final bool rightBorderRadius;
  final bool leftBorderRadius;
  final Color backgrounColor;

  const _OnboardingView({
    required this.asset,
    required this.title,
    required this.text,
    this.rightBorderRadius = false,
    this.leftBorderRadius = false,
    required this.backgrounColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: backgrounColor,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Column(
            children: [
              LottieBuilder.asset(
                asset,
                width: 95.w,
                fit: BoxFit.cover,
                repeat: true,
                reverse: true,
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                height: 37.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular((leftBorderRadius) ? 6.h : 0),
                    topRight: Radius.circular((rightBorderRadius) ? 6.h : 0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
