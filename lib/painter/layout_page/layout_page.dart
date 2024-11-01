import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/layout_page/logic/layout_provider.dart';
import 'package:orient/routing/app_router.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  radius: 0.8,
                  stops: [0.1, 1.0],
                  center: Alignment.centerLeft,
                  colors: [
                    Color.fromRGBO(255, 0, 123, 0.06),
                    Color.fromRGBO(0, 161, 255, 0.06)
                  ])),
          child: Stack(
            children: [
              Consumer<LayoutProvider>(
                builder: (context, provider, child) {
                  return provider.navList[provider.navIndex];
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: navBar())
            ],
          ),
        ),
      ),
    );
  }
  Widget navBar() {
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 70,
          margin: EdgeInsets.only(
              bottom: 24,
              left: 10,
              right: 10
          ),
          decoration: BoxDecoration(
            color: Color(0xFF0D3B6F),
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
            children:provider.navIcon.map((icon) {
              int index = provider.navIcon.indexOf(icon);
              bool isSelected = provider.navIndex == index;
              return Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: (){
                    provider.changeIndex(context,index);
                  },
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 7,
                      right: 7,
                    ),
                    child: Icon(
                      icon,
                      color: isSelected?Color(0xFFE6007E):Colors.white,
                    ),
                  ),
                ),
              );
            } ,).toList(),
          ),
        );
      },
    );
  }
}
