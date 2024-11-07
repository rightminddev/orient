import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

import '../../post/post_details_screen.dart';
import '../data/models/groups_model.dart';

class GroupsItem extends StatelessWidget {
  const GroupsItem({super.key, required this.data});
  final Group data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15,),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                    imageUrl:(data.imageData!.isNotEmpty)? data.imageData![0].file : '',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    placeholder: (context,
                        url) =>
                    const ShimmerAnimatedLoading(
                      circularRaduis:
                      AppSizes.s50,
                    ),
                    errorWidget: (context,
                        url, error) =>
                    const Icon(
                      Icons
                          .image_not_supported_outlined,
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1B1B1B),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${data.postsCount} POSTS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff1B1B1B).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 24,
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
                            'id': data.id.toString(),
                            'lang': context.locale.languageCode
                          },
                        );

                      },
                      child: const Text(
                        'DISCOVER',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffFFFFFF),
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
