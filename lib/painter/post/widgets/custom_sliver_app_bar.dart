import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';


class CustomSliverAppBar extends StatelessWidget {
  final socialGroupId;
  CustomSliverAppBar(this.socialGroupId);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF0D3B6F),
      surfaceTintColor: const Color(0xFF0D3B6F),
      shadowColor: const Color(0xFF0D3B6F),
      elevation: 0,
      pinned: true,
      centerTitle: true,
      title: Text(
        "Mas Stars".toUpperCase(),
        style: const TextStyle(
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
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: () {
                print("socialGroupId ---> $socialGroupId");
                context.pushNamed(AppRoutes.addPostScreen.name,
                    pathParameters: {'lang': context.locale.languageCode,
                      'id' : "$socialGroupId"
                    });
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              )),
        )
      ],
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              defaultFillImageAppbar(containerHeight: 450),
            ],
          ),
        ),
      ),
    );
  }
}
