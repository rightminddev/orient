import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/authentication/views/widgets/phone_number_field.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/painter/points/widgets/send_point_confirm_bottomsheet.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';

class SendPointFriendBottomSheet extends StatelessWidget {
  const SendPointFriendBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => PointsProvider(),
    child: Consumer<HomeViewModel>(
      builder: (context, values, child) {
        return Consumer<PointsProvider>(builder: (context, value, child) {
          if(value.isRedeemSuccess == true){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allow full screen interaction
                  builder: (BuildContext context) {
                    return SendPointConfirmBottomsheet(amount: value.pointsController.text,
                      user: value.countryCodeController.text.isEmpty ? '+20${value.phoneController.text}' : "${value.countryCodeController.text}${value.phoneController.text}",
                    name: value.userName
                    );
                  }
              );
            });
            value.isRedeemSuccess = false;
          }
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Push above keyboard
            ),
            child: GestureDetector(
              onTap: () {}, // Prevent taps inside from closing the bottom sheet
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                  gradient: LinearGradient(
                    colors: [Color(0xffFDFDFD), Color(0xffF4F7FF)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.45,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Center(
                      child: Container(
                        height: 5,
                        width: 63,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffB9C0C9),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.sendToFriends.tr().toUpperCase(),
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Color(0xffE6007E),
                            ),
                          ),
                          PhoneNumberField(
                            controller: value.phoneController,
                            countryCodeController: value.countryCodeController,
                          ),
                          defaultTextFormField(
                              context: context,
                              keyboardType: TextInputType.number,
                              hintText: AppStrings.enterTheNumberOfPoints.tr().toUpperCase(),
                              controller: value.pointsController),
                          const SizedBox(height: 30),
                          if(value.isRedeemLoading) const Center(child: CircularProgressIndicator(),),
                          if(!value.isRedeemLoading) GestureDetector(
                            onTap: ()async{
                              value.postTransferPoints(context, confirmed: false);
                            },
                            child: Container(
                              height: 50,
                              width: 225,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(0xff0D3B6F)),
                              child: Text(
                                AppStrings.sendPoints.tr().toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },);
      },
    )
    );
  }
}
