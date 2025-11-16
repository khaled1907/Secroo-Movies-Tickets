import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:flutter/material.dart';

class MyCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyCustomAppBar({super.key, required this.name});
  final String name;

  @override
  State<MyCustomAppBar> createState() => _MyCustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyCustomAppBarState extends State<MyCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColores.backgroundColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome ${widget.name}',
              style: AppTextStyels.hint_14_bold_400,
            ),
            Text(
              "Movie",
              style: AppTextStyels.white_18_bold_500,
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: AssetImage("assets/icons/AppBarImage.png"),
                fit: BoxFit.cover,
              ),
              color: AppColores.hintColor,
            ),
          ),
        )
      ],
    );
  }
}
