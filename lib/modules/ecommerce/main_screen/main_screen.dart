import 'package:flutter/material.dart';
import 'package:orient/modules/ecommerce/home/home_screen.dart';
import 'package:orient/modules/ecommerce/search/search_screen.dart';
import 'package:orient/utils/components/general_components/general_components.dart';

class ECommerceMainScreen extends StatefulWidget {
  @override
  State<ECommerceMainScreen> createState() => _ECommerceMainScreenState();
}

class _ECommerceMainScreenState extends State<ECommerceMainScreen> {
  List<String> navs = [
    "assets/images/ecommerce/svg/nav1.svg",
    "assets/images/ecommerce/svg/nav2.svg",
    "assets/images/ecommerce/svg/nav3.svg",
    "assets/images/ecommerce/svg/nav4.svg",
    "assets/images/ecommerce/svg/nav5.svg",
  ];

  int? selectIndexs = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if(selectIndexs == 0)Container(
              height: MediaQuery.sizeOf(context).height * 1,
              child: ECommerceHomeScreen()
          ), if(selectIndexs == 1)Container(
              height: MediaQuery.sizeOf(context).height * 1,
              child: ECommerceHomeScreen()
          ), if(selectIndexs == 2)Container(
              height: MediaQuery.sizeOf(context).height * 1,
              child: ECommerceHomeScreen()
          ), if(selectIndexs == 3)Container(
              height: MediaQuery.sizeOf(context).height * 1,
              child:const ECommerceSearchScreen()
          ), if(selectIndexs == 4)Container(
              height: MediaQuery.sizeOf(context).height * 1,
              child: ECommerceHomeScreen()
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30,),
            child: defaultBottomNavigationBar(
                items: navs,
                tapBarItemsWidth: MediaQuery.sizeOf(context).width * 0.9,
                selectIndex: selectIndexs,
                onTapItem: (index){
                  setState(() {
                    selectIndexs = index;
                  });
                }
            ),
          )
        ],
      )
        ],
      ),
    );
  }
}
