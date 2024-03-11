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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 10.h,
            centerTitle: true,
            title: Text(
              widget.pettip.title,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: SizedBox(
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
          )
        ],
      ),
    );
  }
}
