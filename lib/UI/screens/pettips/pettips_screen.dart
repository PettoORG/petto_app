import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petto_app/domain/entities/pettip.dart';
import 'package:sizer/sizer.dart';

class PettipsScreen extends StatefulWidget {
  static const name = 'pettips';
  final Pettip pettip;
  const PettipsScreen({super.key, required this.pettip});

  @override
  State<PettipsScreen> createState() => _PettipsScreenState();
}

class _PettipsScreenState extends State<PettipsScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pettip.title,
          style: textStyle.titleSmall,
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Image.asset(
                    widget.pettip.asset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Text(
                  widget.pettip.tip,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
