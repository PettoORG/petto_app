import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/pet_provider.dart';
import 'package:petto_app/UI/providers/pettips_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:petto_app/domain/entities/pet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPet = 0;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    TextTheme textStyles = Theme.of(context).textTheme;
    List<Pet> pets = context.watch<PetProvider>().pets;
    List<OptionModel> options = [
      OptionModel(
          child: Icon(BoxIcons.bx_health, color: colors.primary),
          title: AppLocalizations.of(context)!.health,
          color: colors.primaryContainer),
      OptionModel(
          child: Icon(BoxIcons.bx_cut, color: colors.secondary),
          title: AppLocalizations.of(context)!.grooming,
          color: colors.secondaryContainer),
      OptionModel(
          child: Icon(BoxIcons.bxs_cat, color: colors.primary),
          title: AppLocalizations.of(context)!.activity,
          color: colors.primaryContainer),
      OptionModel(
          child: Icon(BoxIcons.bx_bowl_rice, color: colors.tertiary),
          title: AppLocalizations.of(context)!.food,
          color: colors.tertiaryContainer),
    ];
    if (pets.isEmpty) {
      return PettoLoading(color: Colors.red, size: 50);
    }
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const _SliverAppbar(),
        SliverList.list(
          children: [
            SharedCardSwiper(
              viewportFraction: .7,
              itemCount: pets.length,
              onTap: (_) {
                context.pushNamed('pet-profile', extra: {'pet': pets[currentPet]});
              },
              listener: (page) => setState(() {
                currentPet = page;
              }),
              children: List.generate(pets.length, (index) {
                Pet pet = pets[index];
                return Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Row(
                    children: [
                      Ink(
                        height: 30.w,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.w),
                          child: Image.network(
                            pet.image!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: lightSurfaceVariant,
                                    borderRadius: BorderRadius.circular(5.w),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pet.name, style: textStyles.bodySmall),
                          Text(pet.specie, style: textStyles.bodySmall),
                          Text('${pet.age} años', style: textStyles.bodySmall),
                          Text(pet.gender, style: textStyles.bodySmall),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TODO: IMPLEMENTAR PANTALLAS DE REGISTRO Y SEGUIMIENTO

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: List.generate(options.length, (index) => GlobalPetOptionCard(option: options[index])),
                  // ),
                  // SizedBox(height: 2.h),
                  const _RemindersTitle(),
                  (pets[currentPet].reminders == null)
                      ? Container(
                          margin: EdgeInsets.all(1.w),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/reminder.svg',
                                height: 20.h,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'No tienes recordatorios pendientes',
                                style: textStyles.titleSmall,
                              )
                            ],
                          ),
                        )
                      : Column(children: List.generate(3, (index) => const GlobalReminderCard())),
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
              onTap: (index) => context.pushNamed('pettips', extra: {"pettip": snapshot.data![index]}),
              listener: (page) {},
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
