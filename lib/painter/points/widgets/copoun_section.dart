import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_sizes.dart';
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
                "About Points program",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffE6007E),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "About program I am pleased to reach out to you today to offer a job opportunity as a Surgical Nurse with us. Given your experience and outstanding skills in the field",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff464646),
                  fontWeight: FontWeight.w400,
                ),
              ),
              gapH8,
              Center(
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
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xff464646),
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                  ),
                  SizedBox(height: 20,),
                  Container(
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
                          Image.asset("assets/images/png/verified.png"),
                          gapW4,
                          Text("SEND COUPON",style: TextStyle(
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
