import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_cubit.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_state.dart';
import 'package:orient/painter/points/logic/redeem_prize_cubit/redeem_prize_cubit.dart';
import 'package:orient/painter/points/logic/redeem_prize_cubit/redeem_prize_state.dart';


class DropDownAndButtonBottomSheet extends StatelessWidget {
  const DropDownAndButtonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PrizeCubit,PrizeState>(
          builder: (context, state) {
            if (state is GetPrizeSuccessState) {
              return DropdownButtonFormField(
                //validator: (value) => value == null ? messageForValidate : null,
                decoration: const InputDecoration(
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
                hint: const Text('Choose the prize',
                ),
                  items: state.prizeModel.prizes!.map(
                        (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  ).toList(),
                onChanged: (String? value) {
                  print(value);
                  PrizeCubit.get(context).prize = value!;
                },
                // onChanged: (value) {
                //   GovernoratesCubit.get(context).dropdownValue =
                //       value.id;
                //   AppConstants.govid = value.id;
                //   print(value.id.toString());
                // },
              );
            }
            else if (state is GetPrizeFailureState) {
              return const Text('error');
            }
            else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        const SizedBox(height: 30,),
        BlocConsumer<RedeemPrizeCubit,RedeemPrizeState>(
          listener: (context, state) {
            if (state is RedeemPrizeSuccessState) {
              if (state.redeemPrizeModel.status == true) {
                Fluttertoast.showToast(
                    msg: state.redeemPrizeModel.message!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }  else{
                Fluttertoast.showToast(
                    msg: state.redeemPrizeModel.message!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              Navigator.pop(context);
            }
            else if (state is RedeemPrizeFailureState) {
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is RedeemPrizeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }  else{
              return GestureDetector(
                onTap: (){
                  RedeemPrizeCubit.get(context).redeemPrize(prizeName: PrizeCubit.get(context).prize!);
                },
                child: Container(
                  height: 50,
                  width: 224,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3B6F),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/png/icon.png"),
                      gapW4,
                      const Text("REDEEM NOW",style: TextStyle(
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
