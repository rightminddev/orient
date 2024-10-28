import 'package:flutter/material.dart';

class HomeAddsWidget extends StatelessWidget {
  List add = [
    {
      "title" : "Mastering paints since 1946",
      "type" : "blog",
      "image" : "assets/images/ecommerce/png/blog.png"
    },{
      "title" : "Mastering paints since 1946",
      "type" : "trend",
      "image" : "assets/images/ecommerce/png/trend.png"
    },{
      "title" : "Mastering paints since 1946",
      "type" : "blog",
      "image" : "assets/images/ecommerce/png/blog.png"
    },{
      "title" : "Mastering paints since 1946",
      "type" : "trend",
      "image" : "assets/images/ecommerce/png/trend.png"
    },
  ];

  HomeAddsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding:const EdgeInsets.symmetric(horizontal: 25),
      child: ListView.separated(
          shrinkWrap: true,
          reverse: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index)=> SizedBox(
            height: 145,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Image(image: AssetImage("${add[index]["image"]}"), height: 102,),
                    Padding(
                      padding: const EdgeInsets.only(top: 11, left: 15),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, const Color(0xff1B1B1B).withOpacity(0.5)],
                              begin: Alignment.center,
                              end: Alignment.center,
                            )
                        ),
                        child: Text(
                          "${add[index]['type']}".toUpperCase(),
                          style:const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 8
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${add[index]['title']}".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1B1B1B)
                  ),
                ),
                Row(
                  children: [
                    Text("see more".toUpperCase(),
                      style:const TextStyle(
                          color: Color(0xffE6007E),
                          fontSize: 10,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    const SizedBox(width: 5,),
                    const Icon(Icons.arrow_forward, color: Color(0xffE6007E),size: 14,)
                  ],
                )
              ],
            ),
          ),
          separatorBuilder: (context, index)=>const SizedBox(width: 14,),
          itemCount: add.length
      ),
    );
  }
}
