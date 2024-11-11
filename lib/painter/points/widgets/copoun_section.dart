import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/core/functions/show_progress_indicator.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_provider.dart';
import 'package:provider/provider.dart';


class CopounSection extends StatelessWidget {
  CopounSection({super.key});
  TextEditingController copounCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PrizeProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.aboutPointsProgram.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffE6007E),
                  fontWeight: FontWeight.w600,
                ),
              ),
               Text(
                AppStrings.aboutProgramIAmPleasedToReachOutToYouTodayToOfferAJobOpportunityAsASurgicalNurseWithUsGivenYourExperienceAndOutstandingSkillsInTheField.tr(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff464646),
                  fontWeight: FontWeight.w400,
                ),
              ),
              gapH8,
              const Center(
                  child:
                  Image(
                    image: AssetImage('assets/images/png/coupon.png'),
                    height: 120,
                    width: 181,
                    fit: BoxFit.contain,
                  )
              ),

              Column(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffE3E5E5)),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: copounCodeController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1B1B1B).withOpacity(0.5)
                          ),
                          labelStyle: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff191C1F)
                          ),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding:const EdgeInsets.only(top: 0),
                          hintText: '1294-1256-5523-5520',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        _NumberInputFormatter(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  if(provider.isLoading)const Center(
                    child: CircularProgressIndicator(),
                  ),
                  if(!provider.isLoading)Container(
                    height: 50,
                    width: 224,
                    decoration: BoxDecoration(
                      color: Color(0xFF0D3B6F),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(onPressed: () {
                      provider.sendCopoun(copounCode: copounCodeController.text).then((value) {
                        if(provider.isLoading == true){
                          showProgressIndicator(context);
                        }
                        else {
                          if (provider.copounModel!.status == true) {
                            Fluttertoast.showToast(
                                msg: provider.copounModel!.message!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            copounCodeController.clear();
                          }
                          else {
                            Fluttertoast.showToast(
                                msg: provider.copounModel!.message!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            copounCodeController.clear();
                          }
                        }
                      },);
                    },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/png/verified.svg"),
                          gapW4,
                          const Text(AppStrings.sendCoupon,style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),)
                        ],
                      ),
                    ),
                  ),
                   Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset('assets/images/png/coinImage.svg', height: 260,width: double.infinity,fit: BoxFit.cover)
                  )
                      //Image(image: AssetImage('assets/images/png/coinImage.svg'),height: 260,width: double.infinity,fit: BoxFit.fill,)),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}

class _NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', '');
    if (text.length > 16) text = text.substring(0, 16);
    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      formattedText += text[i];
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        formattedText += '-';
      }
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
