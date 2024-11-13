import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/painter/home_screen/views/home_model.dart';
import 'package:provider/provider.dart';

class DefaultTextFieldCodeSendNow extends StatelessWidget {
    TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<HomeModelProvider>(
        builder: (context, value, child) {
          return Positioned(
            bottom: -26,
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SizedBox(
                width: width * 0.75,
                height: AppSizes.s53,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: codeController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1B1B1B).withOpacity(0.5),
                      ),
                      labelStyle: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff191C1F),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(top: 12),
                      hintText: '1294-1256-5523-5520',
                      suffixIcon: GestureDetector(
                        onTap: (){
                          if(codeController.text.isNotEmpty){
                            value.addRedeemGift(
                                context: context,
                                serial: codeController.text
                            );
                            codeController.clear();
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (value.isLoading)const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xffE6007E),
                                ),
                              ),
                            if(!value.isLoading)Image.asset(
                                AppImages.painterCodeLogo,
                                width: 20,
                                height: 20,
                              ),
                            const Text(
                              'Send Now',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffE6007E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      _NumberInputFormatter(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}class _NumberInputFormatter extends TextInputFormatter {
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