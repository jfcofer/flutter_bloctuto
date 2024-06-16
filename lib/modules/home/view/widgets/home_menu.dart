import 'package:flutter/material.dart';
import 'package:flutter_users_bloc_sqflite/modules/home/view/widgets/home_menu_tile.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.topCenter,
      children: [HomeMenuUsersTile()],
    );
  }
}
