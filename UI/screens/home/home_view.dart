import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    List<OptionModel> options = [
      OptionModel(
          child: Icon(BoxIcons.bx_health, color: color.primary),
          title: AppLocalizations.of(context)!.health,
          color: color.primaryContainer),
      OptionModel(
          child: Icon(BoxIcons.bx_cut, color: color.secondary),
          title: AppLocalizations.of(context)!.grooming,
          color: color.secondaryContainer),
      OptionModel(
          child: Icon(BoxIcons.bxs_cat, color: color.primary),
          title: AppLocalizations.of(context)!.activity,
          color: color.primaryContainer),
      OptionModel(
          child: Icon(BoxIcons.bx_bowl_rice, color: color.tertiary),
          title: AppLocalizations.of(context)!.food,
          color: color.tertiaryContainer),
    ];
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const _SliverAppbar(),
        SliverList.list(
          children: [
            SharedCardSwiper(
              viewportFraction: .7,
              itemCount: 5,
              onTap: () {
                context.pushNamed('pet-profile');
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(options.length, (index) => SharedOptionCard(option: options[index])),
                  ),
                  SizedBox(height: 2.h),
                  const _RemindersTitle(),
                  Column(children: List.generate(3, (index) => const SharedReminderCard())),
                  SizedBox(height: 2.h),
                  Text(AppLocalizations.of(context)!.pettips, style: textStyle.titleMedium),
                ],
              ),
            ),
            SharedCardSwiper(
              viewportFraction: .8,
              itemCount: 5,
              autoAdvance: true,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Image.asset(
                      'assets/images/balanced_diet.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 2.w,
                    left: 2.w,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      height: 10.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: color.surfaceVariant.withOpacity(.7),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Center(
                          child: Text(
                        'Alimentacion balanceada',
                        style: textStyle.bodyLarge,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _RemindersTitle extends StatelessWidget {
  const _RemindersTitle();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.upcomingReminders,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              BoxIcons.bx_plus_circle,
              color: color.primary,
            ))
      ],
    );
  }
}

class _SliverAppbar extends StatelessWidget {
  const _SliverAppbar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_menu_alt_left)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_bell)), SizedBox(width: 1.w)],
    );
  }
}
