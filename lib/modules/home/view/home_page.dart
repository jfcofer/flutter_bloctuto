import 'package:flutter/material.dart';
import 'package:flutter_users_bloc_sqflite/modules/home/view/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: const _HomePageBody(),
      bottomNavigationBar: const HomeBottomAppBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    return const HomeMenu();
  }
}
