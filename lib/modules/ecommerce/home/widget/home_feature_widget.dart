import 'package:flutter/material.dart';

class HomeFeatureWidget extends StatelessWidget {
  List category = [
    {
      "name": "color trends",
      "image" : "assets/images/ecommerce/png/wall.png"
    },{
      "name": "Get inspired",
      "image" : "assets/images/ecommerce/png/indoor.png"
    }, {
      "name": "calculator",
      "image": "assets/images/ecommerce/png/outdoor.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Container(
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
    );
  }
}
