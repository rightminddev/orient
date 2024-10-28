import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';

class CheckoutBottomsheetEditLocationWidget extends StatefulWidget {
  const CheckoutBottomsheetEditLocationWidget({super.key});

  @override
  State<CheckoutBottomsheetEditLocationWidget> createState() => _CheckoutBottomsheetEditLocationWidgetState();
}

class _CheckoutBottomsheetEditLocationWidgetState extends State<CheckoutBottomsheetEditLocationWidget> {
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
          color: Color(0xffFFFFFF)
      ),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Center(
            child:Container(
              width: 63,
              height: 5,
              decoration: BoxDecoration(
                  color: const Color(0xffB9C0C9),
                  borderRadius: BorderRadius.circular(100)
              ),
            ) ,
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                defaultTextFormField(hintText: "Phone", containerHeight: 64),
                defaultTextFormField(hintText: "Address", containerHeight: 64),
                defaultTextFormField(hintText: "Country", containerHeight: 64),
                defaultTextFormField(hintText: "State/Province/Region", containerHeight: 64),
                defaultTextFormField(hintText: "City", containerHeight: 64),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ButtonWidget(
                onPressed: (){
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                svgIcon: "assets/images/ecommerce/svg/verifiy.svg",
                title: "Save Changes"
            ),
          )
        ],
      ),
    );
  }

}
