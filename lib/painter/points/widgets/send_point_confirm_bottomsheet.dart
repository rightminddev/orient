import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/authentication/views/widgets/phone_number_field.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';

class SendPointConfirmBottomsheet extends StatelessWidget {
  var user;
  var amount;
  var name;
  SendPointConfirmBottomsheet({super.key, this.user, this.amount, this.name});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PointsProvider(),
      child: Consumer<HomeViewModel>(
        builder: (context, values, child) {
          return Consumer<PointsProvider>(
            builder: (context, value, child) {
              if(value.isRedeemSuccess == true){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  values.initializeHomeScreen(context);
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  defaultActionBottomSheet(
                    context: context,
                    home: false,
                    title:
                    "${AppStrings.pointsTransferredSuccessfully.tr().toUpperCase()}!",
                    buttonText: AppStrings.goToHome
                        .tr()
                        .toUpperCase(),
                    subTitle: AppStrings
                        .yourOrderWillBeDeliveredSoonThankYouForChoosingOurApp
                        .tr()
                        .toUpperCase(),
                    viewCheckIcon: true,
                    onTapButton: () {
                      if (context.mounted) {
                        Navigator.pop(context);
                        if (context.mounted) Navigator.pop(context);
                        if (context.mounted) Navigator.pop(context);
                      }
                    },
                    headerIcon: SvgPicture.asset(
                        "assets/images/ecommerce/svg/cart_success.svg",
                        height: 42,
                        width: 40),
                  );
                });
                value.isRedeemSuccess = false;
              }
              return GestureDetector(
                onTap:
                    () {}, // Prevent taps inside from closing the bottom sheet
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(35.0)),
                    gradient: LinearGradient(
                      colors: [Color(0xffFDFDFD), Color(0xffF4F7FF)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.46,
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffE6007E)
                                  .withOpacity(0.05),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffE6007E),
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/ecommerce/svg/cart_success.svg",
                                  height: 42,
                                  width: 40),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Color(0xff38CF71),
                              child: Icon(
                                Icons.check,
                                color: Color(0xffFFFFFF),
                                size: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.confirmSending
                                  .tr()
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: Color(0xffE6007E),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "${AppStrings.areYouSureThatPointsWillBeSentTo.tr()} $name"
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1B1B1B),
                                  fontFamily: "Poppins"),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: (!value.isRedeemLoading)?
                                  GestureDetector(
                                    onTap: () {
                                      print("USER IS $user");
                                      print("AMOUNT IS $amount");
                                      value.postTransferPoints(context, confirmed: true, amount: amount, user: user);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 225,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          color: const Color(0xff0D3B6F)),
                                      child: Text(
                                        AppStrings.sendPoints
                                            .tr()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffFFFFFF),
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ) : const Center(child: CircularProgressIndicator(),),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 225,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          color: const Color(0xffA60B0B)),
                                      child: Text(
                                        AppStrings.cancel
                                            .tr()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffFFFFFF),
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      )
    );
  }
}
