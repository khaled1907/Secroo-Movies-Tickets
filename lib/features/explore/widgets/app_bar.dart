import 'package:final_project/core/constans/app_colores.dart';
import 'package:flutter/material.dart';

class ExpolreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExpolreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColores.backgroundColor,
      title: Text(
        "Explore Movies",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
