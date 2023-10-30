import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/screens/screens.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 1);
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
          const CalendarView(),
          const HomeView(),
          const UserProfileView(),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                GButton(icon: BoxIcons.bx_calendar, text: 'Calendar'),
                GButton(icon: BoxIcons.bx_home, text: 'home'),
                GButton(icon: BoxIcons.bx_user, text: 'profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
