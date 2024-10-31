import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/layout_page/logic/layout_state.dart';
import 'package:orient/routing/app_router.dart';

import 'logic/layout_cubit.dart';

class LayoutPage extends StatefulWidget {
  final PainterNavbarPages painterNavbarPages;

  LayoutPage({
    super.key,
    required this.painterNavbarPages,
  });

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<LayoutCubit, LayoutState>(
                builder: (context, state) {
                  return LayoutCubit.get(context)
                      .navList[LayoutCubit.get(context).navIndex];
                },
              ),
              Align(alignment: Alignment.bottomCenter, child: navBar())
            ],
          ),
        ),
      ),
    );
  }

  Widget navBar() {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Container(
          height: 70,
          margin: const EdgeInsets.only(bottom: 24, left: 10, right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF0D3B6F),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: LayoutCubit.get(context).navIcon.map(
              (icon) {
                int index = LayoutCubit.get(context).navIcon.indexOf(icon);
                bool isSelected = LayoutCubit.get(context).navIndex == index;
                return Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      LayoutCubit.get(context).changeIndex(context, index);
                    },
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 7,
                        right: 7,
                      ),
                      child: Icon(
                        icon,
                        color:
                            isSelected ? const Color(0xFFE6007E) : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
