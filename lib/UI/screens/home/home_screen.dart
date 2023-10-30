import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    List<_OptionModel> options = [
      _OptionModel(
          icon: BoxIcons.bx_health,
          title: AppLocalizations.of(context)!.health,
          color: color.primaryContainer,
          iconColor: color.primary),
      _OptionModel(
          icon: BoxIcons.bx_cut,
          title: AppLocalizations.of(context)!.grooming,
          color: color.secondaryContainer,
          iconColor: color.secondary),
      _OptionModel(
          icon: BoxIcons.bxs_cat,
          title: AppLocalizations.of(context)!.activity,
          color: color.primaryContainer,
          iconColor: color.primary),
      _OptionModel(
          icon: BoxIcons.bx_bowl_rice,
          title: AppLocalizations.of(context)!.food,
          color: color.tertiaryContainer,
          iconColor: color.tertiary),
    ];
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const _SliverAppbar(),
        SliverList.list(
          children: [
            const CardSwiper(viewportFraction: .7, itemCount: 5),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(options.length, (index) => _DefaultOption(option: options[index])),
                  ),
                  SizedBox(height: 2.h),
                  const _RemindersTitle(),
                  Column(children: List.generate(3, (index) => const _RemminderCard())),
                  SizedBox(height: 2.h),
                  Text(AppLocalizations.of(context)!.pettips, style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            const CardSwiper(viewportFraction: .8, itemCount: 5, autoAdvance: true),
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
          style: Theme.of(context).textTheme.titleSmall,
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

class _RemminderCard extends StatelessWidget {
  const _RemminderCard();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: InkWell(
        child: Ink(
          width: double.infinity,
          height: 9.h,
          decoration: BoxDecoration(
            color: color.surfaceVariant,
            borderRadius: BorderRadius.circular(5.w),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: color.shadow,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultOption extends StatelessWidget {
  final _OptionModel option;

  const _DefaultOption({required this.option});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(4.w),
          child: Ink(
            height: 15.w,
            width: 15.w,
            decoration: BoxDecoration(
              color: option.color,
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Icon(
              option.icon,
              color: option.iconColor,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          option.title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class _SliverAppbar extends StatelessWidget {
  const _SliverAppbar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 10.h,
      leading: IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_menu_alt_left)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_bell)), SizedBox(width: 1.w)],
    );
  }
}

class _OptionModel {
  final IconData icon;
  final String title;
  final Color color;
  final Color iconColor;

  _OptionModel({
    required this.icon,
    required this.title,
    required this.color,
    required this.iconColor,
  });
}
