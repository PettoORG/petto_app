import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  static const name = 'notifications';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            floating: true,
            title: Text(AppLocalizations.of(context)!.notifications),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: List.generate(4, (index) => const _NotificationCard()),
            ),
          )
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(5.w),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: colorScheme.shadow,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 8.h,
            width: 8.h,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(5.w),
            ),
          ),
          SizedBox(width: 3.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vacuna pendiente para Kam.',
                  style: textTheme.titleSmall,
                ),
                Text(
                  '¡Hola Jorge! Es hora de la  vacuna de Kam. Programa su cita ahora. ¡Cuida de su salud!',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
