import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/utils/components/general_components/general_components.dart';

class HomeAppbarWidget extends StatelessWidget {
  List category = [
    {
      "name": "wall",
      "image" : "assets/images/ecommerce/png/wall.png"
    },{
      "name": "indoor",
      "image" : "assets/images/ecommerce/png/indoor.png"
    },{
      "name": "outdoor",
      "image" : "assets/images/ecommerce/png/outdoor.png"
    },{
      "name": "wall",
      "image" : "assets/images/ecommerce/png/wall.png"
    },{
      "name": "indoor",
      "image" : "assets/images/ecommerce/png/indoor.png"
    },{
      "name": "outdoor",
      "image" : "assets/images/ecommerce/png/outdoor.png"
    },
  ];

  HomeAppbarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Image(image: AssetImage("assets/images/ecommerce/png/ecommerce_home_background.png")),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 150, // Adjust height for the gradient coverage
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff1A3033).withOpacity(0),
                          const Color(0xff1A3033), // Gradient color
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding:const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: defaultProfileContainer(
                            imageUrl: "https://t4.ftcdn.net/jpg/07/08/47/75/360_F_708477508_DNkzRIsNFgibgCJ6KoTgJjjRZNJD4mb4.jpg",
                            userName: "Amr Nasser",
                            userRole: "Mas Group",
                            context: context
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset("assets/images/ecommerce/svg/notification.svg"),
                            SvgPicture.asset("assets/images/ecommerce/svg/cart.svg"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 35,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                          height: 70,
                          child: SvgPicture.asset("assets/images/ecommerce/svg/ecommerce_home_logo.svg")),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Image.asset("assets/images/ecommerce/png/logo_name.png",
                          width: 200,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: SizedBox(
                    height: 115,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        reverse: false,
                        itemBuilder: (context, index)=> CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 58,
                          backgroundImage: AssetImage("${category[index]['image']}"),
                          child: Text("${category[index]['name']}".toUpperCase(),
                            style:const TextStyle(color: Color(0xffFFFFFF), fontSize: 12,
                                fontWeight: FontWeight.w700),),
                        ),
                        separatorBuilder: (context, index)=> const SizedBox(width: 10,),
                        itemCount: category.length
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
