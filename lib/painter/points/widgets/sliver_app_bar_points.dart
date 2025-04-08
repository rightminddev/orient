import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/models/settings/user_settings_2.model.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/view_models/user_cont.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/points/data/repositories/prize_repository/prize_repository_implementation.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_provider.dart';
import 'package:orient/painter/points/logic/redeem_prize_cubit/redeem_prize_provider.dart';
import 'package:orient/painter/points/widgets/drop_down_and_button_bottom_sheet.dart';
import 'package:orient/painter/points/widgets/redeem_now_button.dart';
import 'package:orient/painter/points/widgets/send_point_friend_bottomsheet.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_edge.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

import '../data/repositories/redeem_prize_repository/redeem_prize_repository_implementation.dart';

class SliverAppBarPoints extends StatelessWidget {
  bool arrow = true;
  SliverAppBarPoints({required this.arrow});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PointsProvider(),
      child: Consumer<PointsProvider>(
        builder: (context, pointsProvider, child) {
          return Consumer<HomeViewModel>(
            builder: (context, value, child) {
              final json2String = CacheHelper.getString("US2");
              var us2Cache;
              if (json2String != null && json2String != "") {
                us2Cache = json.decode(json2String)
                    as Map<String, dynamic>; // Convert String back to JSON
                print("S111111 IS --> ${us2Cache['points']['available']}");
              }
              // value.userSettings2!.balance!.forEach((key, balance) {
              //   balancePoints = balance.max;
              //   availablePoints = balance.available;
              // });
              return SliverAppBar(
                elevation: 0,
                pinned: true,
                title: Text(
                  AppStrings.myPoints.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: (arrow == true) ? Colors.white : Colors.transparent,
                    size: 18,
                  ),
                  onPressed: () {
                    if (arrow == true) {
                      Navigator.of(context).pop();
                    } else {
                      null;
                    }
                  },
                ),
                expandedHeight: 275,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.white,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        defaultFillImageAppbar(containerHeight: 400),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.myPointsEarned.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                gapW8,
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.question_mark_sharp,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                            gapH16,
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: us2Cache['points']['available'].toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "\t ${AppStrings.points.tr()}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ])),
                            Text(
                              "${AppStrings.from.tr().toUpperCase()} ${us2Cache['points']['total'].toString()} ${AppStrings.myPoints.tr()}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRoutes.prizePointsViewScreen.name,
                                    pathParameters: {'lang': context.locale.languageCode,});

                                // showModalBottomSheet(
                                //   backgroundColor: Colors.white,
                                //   context: context,
                                //   shape: const RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.only(
                                //       topLeft: Radius.circular(50),
                                //       topRight: Radius.circular(50),
                                //     ),
                                //   ),
                                //   clipBehavior: Clip.antiAlias,
                                //   builder: (context) {
                                //     return MultiProvider(
                                //       providers: [
                                //         ChangeNotifierProvider(
                                //           create: (context) => PrizeProvider(
                                //               GetPrizeRepositoryImplementation(
                                //                   ApiServicesImplementation(),
                                //                   context),
                                //               RedeemPrizeRepositoryImplementation(
                                //                   ApiServicesImplementation(),
                                //                   context))
                                //             ..getPrize(),
                                //         ),
                                //       ],
                                //       child: StatefulBuilder(
                                //         builder: (context, setState) {
                                //           return SizedBox(
                                //             width: double.infinity,
                                //             child: Padding(
                                //               padding: EdgeInsets.all(12.0),
                                //               child: Column(
                                //                 mainAxisSize: MainAxisSize.min,
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.center,
                                //                 children: [
                                //                   const SizedBox(
                                //                     height: 5,
                                //                   ),
                                //                   const BottomSheetEdge(),
                                //                   const SizedBox(
                                //                     height: 15,
                                //                   ),
                                //                   Text(
                                //                       AppStrings.redeemNow
                                //                           .tr()
                                //                           .toUpperCase(),
                                //                       style: const TextStyle(
                                //                         fontSize: 16,
                                //                         fontWeight:
                                //                             FontWeight.bold,
                                //                         color:
                                //                             Color(0xFFE6007E),
                                //                       )),
                                //                   const SizedBox(
                                //                     height: 25,
                                //                   ),
                                //                   const DropDownAndButtonBottomSheet()
                                //                 ],
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //       ),
                                //     );
                                //   },
                                // );
                              },
                              child: RedeemNowButton(
                                friends: false,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true, // Allow full screen interaction
                                    builder: (BuildContext context) {
                                      return const SendPointFriendBottomSheet();
                                    });
                              },
                              child: const RedeemNowButton(
                                friends: true,
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
