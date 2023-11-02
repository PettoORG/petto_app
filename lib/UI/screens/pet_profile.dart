import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetProfileScreen extends StatelessWidget {
  static const name = 'pet-profile';

  const PetProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
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
              const _PetAvatarSection(),
              const _BasicInformation(),
              SizedBox(height: 3.h),
              const _GeneralInformation(),
            ],
          ),
        ],
      ),
    );
  }
}

class _GeneralInformation extends StatelessWidget {
  const _GeneralInformation();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General',
            style: textStyle.titleMedium,
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(5.w),
            child: Ink(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: color.surfaceVariant,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [
                  BoxShadow(
                    color: color.shadow,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  InfoRow(title: 'Tipo de alimento', body: 'Comercial'),
                  InfoRow(title: 'Ultima sesion veterinaria', body: '1/11/2023'),
                  InfoRow(title: 'Ultima desparazitacion', body: '1/11/2023'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BasicInformation extends StatelessWidget {
  const _BasicInformation();

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
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
              children: List.generate(options.length, (index) => SharedOptionCard(option: options[index]))),
        ],
      ),
    );
  }
}

class _PetAvatarSection extends StatelessWidget {
  const _PetAvatarSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Stack(
        children: [
          _DecorationWidget(size: 40.w, left: -10.w, angle: 50),
          _DecorationWidget(size: 50.w, right: -15.w, bottom: -2.h, angle: -40),
          Center(
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
          )
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String body;

  const InfoRow({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$title: ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              body,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
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
