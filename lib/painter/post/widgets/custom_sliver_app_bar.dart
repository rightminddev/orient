import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/general_components.dart';


class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF0D3B6F),
      surfaceTintColor: const Color(0xFF0D3B6F),
      shadowColor: const Color(0xFF0D3B6F),
      elevation: 0,
      pinned: true,
      centerTitle: true,
      title: const Text(
        "Mass Stars",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ))
      ],
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              defaultFillImageAppbar(containerHeight: 400),
            ],
          ),
        ),
      ),
    );
  }
}