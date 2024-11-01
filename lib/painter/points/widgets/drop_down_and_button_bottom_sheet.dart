import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_provider.dart';
import 'package:orient/painter/points/logic/redeem_prize_cubit/redeem_prize_provider.dart';
import 'package:provider/provider.dart';


class DropDownAndButtonBottomSheet extends StatelessWidget {
  const DropDownAndButtonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<PrizeProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading == true) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              if (provider.prizeModel!.status == true) {
                return DropdownButtonFormField(
                  //validator: (value) => value == null ? messageForValidate : null,
                  decoration: InputDecoration(
                    //fillColor: AppColors.grey50,
                    // filled: true,
                    // isDense: true,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(8),
                  hint: Text('Choose the prize',
                  ),
                  items: provider.prizeModel!.prizes!.map(
                        (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  ).toList(),
                  onChanged: (String? value) {
                    print(value);
                    provider.prize = value!;
                  },
                  // onChanged: (value) {
                  //   GovernoratesCubit.get(context).dropdownValue =
                  //       value.id;
                  //   AppConstants.govid = value.id;
                  //   print(value.id.toString());
                  // },
                );
              }  else{
                return Text('Something went wrong');
              }
            }

          },
        ),
        SizedBox(height: 30,),
        Consumer<RedeemPrizeProvider>(
          builder: (context, provider, child) {
            if (provider.status == RedeemPrizeStatus.loading) {
              return Center(
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
                      Text("REDEEM NOW",style: TextStyle(
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