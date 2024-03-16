import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:sizer/sizer.dart';

class GlobalReminderCard extends StatelessWidget {
  final Reminder reminder;
  const GlobalReminderCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyles = Theme.of(context).textTheme;
    String formattedDate = DateFormat('dd-MM-yyyy').format(reminder.startTime);
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: InkWell(
        child: Ink(
          padding: EdgeInsets.all(3.w),
          width: double.infinity,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.w),
                child: Image.network(
                  reminder.image!,
                  fit: BoxFit.cover,
                  height: 17.w,
                  width: 17.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formattedDate, style: textStyles.titleSmall),
                    Text(
                      reminder.title,
                      style: textStyles.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      reminder.description,
                      style: textStyles.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
