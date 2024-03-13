import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReminderFrecuencyScreen extends StatelessWidget {
  static const name = 'reminder-frecuency';
  const ReminderFrecuencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _SliverAppBar(),
          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Column(
              children: [
                ListTile(
                  onTap: () {},
                  // ignore: prefer_const_constructors
                  title: Text('No repetir'),
                ),
                const Divider()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: const Text('Repetir'),
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
