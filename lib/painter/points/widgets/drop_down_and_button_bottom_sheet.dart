import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_provider.dart';
import 'package:orient/painter/points/logic/redeem_prize_cubit/redeem_prize_provider.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';


class DropDownAndButtonBottomSheet extends StatefulWidget {
  const DropDownAndButtonBottomSheet({super.key});

  @override
  State<DropDownAndButtonBottomSheet> createState() => _DropDownAndButtonBottomSheetState();
}

class _DropDownAndButtonBottomSheetState extends State<DropDownAndButtonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<PrizeProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              if (provider.prizeModel!.status == true) {
                return defaultDropdownField(
                  value: provider.prize,
                  title: provider.prize ?? AppStrings.chooseThePrize.tr(),
                    items: provider.prizeModel!.prizes!.map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e, style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff464646)
                        ),),
                      ),
                    ).toList(),
                  onChanged: (String? value) {
                    print(value);
                    setState(() {
                      provider.prize = value!;
                    });
                  },
                );
              }  else{
                return Text(AppStrings.somethingWentWrong.tr().toUpperCase());
              }
            }

          },
        ),
        const SizedBox(height: 30,),
        Consumer<RedeemPrizeProvider>(
          builder: (context, provider, child) {
            if (provider.status == RedeemPrizeStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return  GestureDetector(
                onTap: (){
                  provider.redeemPrize(prizeName: Provider.of<PrizeProvider>(context, listen: false).prize!).then((value) {
                    if (provider.redeemPrizeModel!.status == true) {
                      Fluttertoast.showToast(
                          msg: provider.redeemPrizeModel!.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.pop(context);
                    }else{
                      Fluttertoast.showToast(
                          msg: provider.redeemPrizeModel!.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.pop(context);
                    }
                  },);
                },
                child: Container(
                  height: 50,
                  width: 224,
                  decoration: BoxDecoration(
                    color: Color(0xFF0D3B6F),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/png/icon.png"),
                      gapW4,
                       Text(AppStrings.redeemNow.tr().toUpperCase(),style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),)
                    ],
                  ),
                ),
              );
            }

          },
        )
      ],
    );
  }
}