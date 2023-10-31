import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetProfileScreen extends StatelessWidget {
  static const name = 'pet-profile';

  const PetProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    List<OptionModel> options = [
      OptionModel(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('9', style: textStyle.bodySmall!.copyWith(color: color.primary)),
              Text('meses', style: textStyle.bodySmall!.copyWith(color: color.primary)),
            ],
          ),
          title: 'Edad',
          color: color.primaryContainer),
      OptionModel(
          child: Icon(
            BoxIcons.bx_female_sign,
            color: color.secondary,
          ),
          title: 'Genero',
          color: color.secondaryContainer),
      OptionModel(
          child: Icon(
            BoxIcons.bx_check_circle,
            color: color.primary,
          ),
          title: 'Vacunado',
          color: color.primaryContainer),
      OptionModel(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('8', style: textStyle.bodySmall!.copyWith(color: color.tertiary)),
              Text('Kg', style: textStyle.bodySmall!.copyWith(color: color.tertiary)),
            ],
          ),
          title: 'Peso',
          color: color.tertiaryContainer),
    ];
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            actions: [IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_edit)), SizedBox(width: 1.w)],
          ),
          SliverList.list(
            children: [
              SizedBox(
                height: 30.h,
                child: Stack(
                  children: [
                    _DecorationWidget(size: 40.w, left: -10.w, angle: 50),
                    _DecorationWidget(size: 50.w, right: -15.w, bottom: -2.h, angle: -40),
                    const _PetAvatar(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                decoration: BoxDecoration(
                  color: lightSurfaceVariant,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: lightShadowColor,
                      offset: Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.w),
                    topRight: Radius.circular(15.w),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre de la mascota',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Perro(raza)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          options.length,
                          (index) =>
                              Material(color: Colors.transparent, child: SharedOptionCard(option: options[index]))),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Text(
                          'Tipo de alimento: ',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          'Comercial',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _DecorationWidget extends StatelessWidget {
  final double size;
  final double angle;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const _DecorationWidget({
    required this.size,
    this.angle = 0,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      right: right,
      top: top,
      child: Transform.rotate(
        angle: angle * 3.1415926535897932 / 180,
        child: SvgPicture.asset(
          'assets/petto.svg',
          height: size,
          colorFilter: const ColorFilter.mode(lightPrimaryContainer, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _PetAvatar extends StatelessWidget {
  const _PetAvatar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45.w,
        width: 45.h,
        decoration: const BoxDecoration(
          color: lightSurfaceVariant,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: lightShadowColor,
              offset: Offset(0, 0),
            )
          ],
        ),
      ),
    );
  }
}
