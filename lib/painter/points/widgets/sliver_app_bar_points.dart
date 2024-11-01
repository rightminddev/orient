import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/points/data/repositories/prize_repository/prize_repository_implementation.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_provider.dart';
import 'package:orient/painter/points/logic/redeem_prize_cubit/redeem_prize_provider.dart';
import 'package:orient/painter/points/widgets/drop_down_and_button_bottom_sheet.dart';
import 'package:orient/painter/points/widgets/redeem_now_button.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_edge.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

import '../data/repositories/redeem_prize_repository/redeem_prize_repository_implementation.dart';

class SliverAppBarPoints extends StatelessWidget {
  const SliverAppBarPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color(0xFF0D3B6F),
      surfaceTintColor: Color(0xFF0D3B6F),
      shadowColor: Color(0xFF0D3B6F),
      elevation: 0,
      pinned: true,
      title: Text(
        "My Points",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () {
          Navigator.of(context).pop();
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
                  Spacer(flex: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "My Points earned",
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
                      text: "54,271",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "\t Points",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ])),
                  Text(
                    "From 60000 Points",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH16,
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(

                        backgroundColor: Colors.white,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        builder: (context) {
                          return  MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                create: (context) => PrizeProvider(GetPrizeRepositoryImplementation(ApiServicesImplementation()))..getPrize(),
                              ),
                              ChangeNotifierProvider(create: (context) => RedeemPrizeProvider(RedeemPrizeRepositoryImplementation(ApiServicesImplementation()))),
                            ],
                            child: StatefulBuilder(builder: (context, setState) {
                              return SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 5,),
                                      BottomSheetEdge(),
                                      SizedBox(height: 15,),
                                      Text('REDEEM NOW',style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE6007E),
                                      )),
                                      SizedBox(height: 15,),
                                      DropDownAndButtonBottomSheet()
                                    ],
                                  ),
                                ),
                              );
                            },),
                          );
                        },
                      );
                    },
                    child: RedeemNowButton(),
                  ),
                  Spacer(flex: 1,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
