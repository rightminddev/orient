import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/routing/app_router.dart';

import '../../post/post_details_screen.dart';
import '../data/models/groups_model.dart';

class GroupsItem extends StatelessWidget {
  const GroupsItem({super.key, required this.data});

  final Group data;

  // File? file;
  @override
  Widget build(BuildContext context) {
    // if (data.image != null) {
    //  file  = new File(data.image![0].file!);
    // }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0,
                offset: const Offset(0, 1),
                blurRadius: 10)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              data.imageData != null && data.imageData!.isNotEmpty
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(data.imageData![0].file),
                    )
                  : const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/png/image.png'),
                    ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff464646),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${data.postsCount} POSTS",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xffE6007E),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        context.pushNamed(
                          AppRoutes.postDetailsScreen.name,
                          pathParameters: {
                            'id': data.id.toString()
                          },
                        );

                      },
                      child: const Text(
                        'DISCOVER',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
