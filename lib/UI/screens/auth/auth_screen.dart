import 'package:flutter/material.dart';
import 'package:petto_app/UI/screens/screens.dart';

class AuthScreen extends StatefulWidget {
  static const name = 'auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late PageController controller;
  late int currentPage = 0;

  @override
  void initState() {
    controller = PageController(initialPage: 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            ForgotPasswordView(onPressed: () {
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInQuint);
            }),
            LoginView(
              onTap: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInQuint,
                );
              },
              onTapTwo: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInQuint,
                );
              },
            ),
            RegisterView(onTap: () {
              controller.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInQuint,
              );
            }),
          ],
        ),
      ),
    );
  }
}
