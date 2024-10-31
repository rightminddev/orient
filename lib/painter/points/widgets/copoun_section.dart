import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/core/functions/show_progress_indicator.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_cubit.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_state.dart';


class CopounSection extends StatelessWidget {
  CopounSection({super.key});
  TextEditingController copounCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrizeCubit,PrizeState>(
      listener: (context, state) {
        if (state is SendCouponSuccessState) {
          if (state.copounModel.status == true) {
            Fluttertoast.showToast(
                msg: state.copounModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }  else{
            Fluttertoast.showToast(
                msg: state.copounModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          Navigator.pop(context);
        }
        else if (state is SendCouponFailureState) {
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
        else if (state is SendCouponLoadingState) {
          showProgressIndicator(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "About Points program",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffE6007E),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "About program I am pleased to reach out to you today to offer a job opportunity as a Surgical Nurse with us. Given your experience and outstanding skills in the field",
                style: TextStyle(
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
                    width: 120,
                    fit: BoxFit.contain,
                  )
              ),

              Column(
                children: [
                  TextFormField(
                    controller: copounCodeController,
                      decoration: InputDecoration(
                        labelText: "Enter coupon code",
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff464646),
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: 224,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D3B6F),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(onPressed: () {
                      PrizeCubit.get(context).sendCopoun(copounCode: copounCodeController.text);
                    },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/png/verified.png"),
                          gapW4,
                          const Text("SEND COUPON",style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),)
                        ],
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                      child: Image(image: AssetImage('assets/images/png/coinimage.png'),height: 160,width: double.infinity,fit: BoxFit.fill,)),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}
