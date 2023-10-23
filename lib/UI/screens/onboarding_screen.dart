import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petto_app/utils/local_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: [
              _OnboardingFirstView(
                asset: 'assets/pet_friend.svg',
                assetSize: 80.w,
                title: AppLocalizations.of(context)!.yourWellCaredPet,
                text: AppLocalizations.of(context)!.pettoHelpsYourPet,
                leftBorderRadius: true,
                backgrounColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              _OnboardingFirstView(
                asset: 'assets/primary-calendar.svg',
                assetSize: 63.w,
                title: AppLocalizations.of(context)!.essentialReminders,
                text: AppLocalizations.of(context)!.pettoRemindsYou,
                backgrounColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
              _OnboardingFirstView(
                asset: 'assets/pettips.svg',
                assetSize: 75.w,
                title: AppLocalizations.of(context)!.pettips,
                text: AppLocalizations.of(context)!.pettoProvidesTips,
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
                            onPressed: () {
                              LocalStorage.prefs.setBool('showOnboarding', false);
                              return context.pushReplacement('/home');
                            },
                            child: Text(AppLocalizations.of(context)!.skip))
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
                            onPressed: () {
                              LocalStorage.prefs.setBool('showOnboarding', false);
                              return context.pushReplacement('/home/pet-register');
                            },
                            child: Text(AppLocalizations.of(context)!.letsGo))
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

class _OnboardingFirstView extends StatelessWidget {
  final String asset;
  final String title;
  final String text;
  final bool rightBorderRadius;
  final bool leftBorderRadius;
  final Color backgrounColor;
  final double assetSize;

  const _OnboardingFirstView({
    required this.asset,
    required this.title,
    required this.text,
    this.rightBorderRadius = false,
    this.leftBorderRadius = false,
    required this.backgrounColor,
    required this.assetSize,
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
              SvgPicture.asset(
                asset,
                height: assetSize,
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
