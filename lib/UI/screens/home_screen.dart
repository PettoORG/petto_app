import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.pushNamed('user-profile');
                },
                icon: const Icon(Icons.person))
          ],
        )
      ],
    ));
  }
}
