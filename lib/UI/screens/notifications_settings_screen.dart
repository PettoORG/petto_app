import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationSettingScreen extends StatefulWidget {
  static const name = 'notifications-settings';
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    List<_SwitchModel> options = [
      _SwitchModel(title: AppLocalizations.of(context)!.email, icon: BoxIcons.bx_envelope, onTap: () {}),
      _SwitchModel(title: AppLocalizations.of(context)!.notifications, icon: BoxIcons.bx_bell, onTap: () {}),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.alertNotification, style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 3.h),
              Container(
                height: 30.h,
                width: 30.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.h), color: color.primary.withOpacity(0.2)),
                padding: EdgeInsets.all(4.w),
                child: SvgPicture.asset("assets/push_notifications.svg"),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(AppLocalizations.of(context)!.descriptionNotification,
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 5.h),
              ...List.generate(
                options.length,
                (index) => Column(
                  children: [
                    _IconNotification(option: options[index]),
                    SizedBox(height: 1.5.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _IconNotification extends StatefulWidget {
  final _SwitchModel option;
  const _IconNotification({required this.option});

  @override
  State<_IconNotification> createState() => _IconNotificationState();
}

class _IconNotificationState extends State<_IconNotification> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color.primary.withOpacity(0.3)),
            child: Icon(widget.option.icon, color: lightPrimary)),
        SizedBox(
          width: 2.w,
        ),
        Text(widget.option.title),
        Flexible(
          child: Container(
            alignment: Alignment.centerRight,
            child: Switch(
              value: light,
              activeColor: color.primary,
              onChanged: (bool value) {
                setState(
                  () {
                    light = value;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SwitchModel {
  final String title;
  final IconData icon;
  final Function()? onTap;

  _SwitchModel({required this.title, required this.icon, required this.onTap});
}