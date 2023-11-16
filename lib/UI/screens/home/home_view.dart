import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/pettips_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
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
                  Text(AppLocalizations.of(context)!.pettips, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
            const _Pettips(),
          ],
        )
      ],
    );
  }
}

class _Pettips extends StatelessWidget {
  const _Pettips();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    return FutureBuilder(
      future: context.read<PettipsProvider>().getGeneralPettips(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SharedCardSwiper(
              viewportFraction: .8,
              itemCount: snapshot.data!.length,
              autoAdvance: true,
              children: List.generate(
                snapshot.data!.length,
                (index) => Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(
                        snapshot.data![index].asset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 2.w,
                        left: 2.w,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.w),
                            color: color.surfaceVariant.withOpacity(.6),
                          ),
                          child: Text(
                            snapshot.data![index].title,
                            style: textStyle.bodySmall,
                          ),
                        ))
                  ],
                ),
              ));
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 25.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: lightSurfaceVariant,
                  borderRadius: BorderRadius.circular(5.w),
                ),
              ),
            ),
          );
        }
      },
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
    TextTheme textStyle = Theme.of(context).textTheme;
    return SliverAppBar(
      floating: true,
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context)!.petto,
        style: textStyle.bodyLarge!.copyWith(fontFamily: 'Pacifico-Regular', fontSize: 17.sp),
      ),
      actions: [
        IconButton(onPressed: () => context.pushNamed('notifications'), icon: const Icon(BoxIcons.bx_bell)),
        SizedBox(width: 1.w)
      ],
    );
  }
}
