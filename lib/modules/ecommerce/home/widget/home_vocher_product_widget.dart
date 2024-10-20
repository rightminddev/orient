import 'package:flutter/material.dart';

class HomeVocherProductWidget extends StatelessWidget {
  const HomeVocherProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.only(top: 55),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xff584330),
                    const Color(0xffAA845F),
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xffFFFFFF))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 160,
                      height: 12,
                      child: Text("wall Paints".toUpperCase(),
                        maxLines: 1,
                        style:const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 140,
                      // height: 30,
                      child: Text("HIGH PLAST SILK 787".toUpperCase(),
                        maxLines: 2,
                        style:const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      children: [
                        Text("see more".toUpperCase(),
                          style:const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 10,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward, color: Color(0xffFFFFFF),size: 14,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Image.asset("assets/images/ecommerce/png/brown_paint.png",
            height: 180,
            width: 180,
          )
        ],
      ),
    );
  }
}
