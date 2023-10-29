import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/screens/screens.dart';
import 'package:sizer/sizer.dart';

class HomeViews extends StatefulWidget {
  static const name = 'home';
  const HomeViews({Key? key}) : super(key: key);

  @override
  State<HomeViews> createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  late int _currentIndex;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _currentIndex = _controller.initialPage;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          const HomeScreen(),
          Container(color: Colors.black),
          Container(color: Colors.green),
          const UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: color.surfaceVariant,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: color.shadow,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .8.h),
            child: GNav(
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                  _controller.jumpToPage(index);
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              tabBackgroundColor: color.primaryContainer,
              color: color.onSurfaceVariant,
              activeColor: color.primary,
              rippleColor: color.primaryContainer,
              hoverColor: color.primaryContainer.withOpacity(.3),
              gap: 1.w,
              tabs: const [
                GButton(icon: BoxIcons.bx_home, text: 'home'),
                GButton(icon: BoxIcons.bx_calendar, text: 'Calendar'),
                GButton(icon: BoxIcons.bx_bulb, text: 'profile'),
                GButton(icon: BoxIcons.bx_user, text: 'care'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
