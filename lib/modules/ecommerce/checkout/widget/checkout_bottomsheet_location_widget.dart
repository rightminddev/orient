import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_bottomsheet_edit_location_widget.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';

class CheckoutBottomsheetLocationWidget extends StatefulWidget {
  const CheckoutBottomsheetLocationWidget({super.key});

  @override
  State<CheckoutBottomsheetLocationWidget> createState() => _CheckoutBottomsheetLocationWidgetState();
}

class _CheckoutBottomsheetLocationWidgetState extends State<CheckoutBottomsheetLocationWidget> {
 int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
          color: Color(0xffFFFFFF)
      ),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.8,
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
               SizedBox(
                 height: MediaQuery.sizeOf(context).height * 0.62,
                 child: ListView.separated(
                   separatorBuilder: (context, index)=> const SizedBox.shrink(),
                   itemBuilder: (context, index)=> defaultLocationContainer(
                     context: context,
                     use: (selectIndex == index + 1) ? true : false,
                     onTap: (){
                       if(selectIndex == index + 1){
                         print("yes");
                         setState(() {
                           selectIndex = 0;
                           print(selectIndex);
                         });
                       }else{
                         setState(() {
                           selectIndex = index+1;
                           print(selectIndex);
                         });
                       }
                     },
                     onTapEdit: ()async{
                       Navigator.pop(context);
                       return await showModalBottomSheet(
                         context: context,
                         isScrollControlled: true,
                         shape: const RoundedRectangleBorder(
                           borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                         ),
                         builder: (BuildContext context) {
                           return const CheckoutBottomsheetEditLocationWidget();
                         },
                       );
                     }
                   ),
                   itemCount: 10,
                 ),
               ),
                const SizedBox(height: 20,),
                ButtonWidget(
                  title: "ADD address".toUpperCase(),
                  svgIcon: "assets/images/ecommerce/svg/add.svg",
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget defaultLocationContainer({context, bool use = false, void Function()? onTap, void Function()? onTapEdit})=>  GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s25, horizontal: AppSizes.s12),
      decoration: ShapeDecoration(
        color: AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/images/ecommerce/svg/checkout_location.svg"),
              const SizedBox(width: 10,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: const Text("90th Street, 5th settlement, New Cairo, Egypt.",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1B1B1B)
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              GestureDetector(
                onTap: onTapEdit,
                child: Text("Edit".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffE6007E)
                  ),
                ),
              ),
            ],
          ),
          if(use == true) const SizedBox(height: 15,),
          if(use == true)Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Container(
              width: 170,
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffE6007E)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const CircleAvatar(
                    radius: 10,
                    backgroundColor: Color(0xff38CF71),
                    child: Icon(
                      Icons.check,
                      color: Color(0xffFFFFFF),
                      size: 12,
                    ),
                  ),
                  Text("Use this address".toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xffFFFFFF),
                    fontWeight:FontWeight.w500,
                    fontSize: 12
                  ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
