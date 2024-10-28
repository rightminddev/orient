import 'package:flutter/material.dart';

class SingleDetailsAndColorsWidget extends StatelessWidget {
  const SingleDetailsAndColorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'PUTTY (ACRYLIC 1000) 233'.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff0D3B6F),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Color(0xffE6007E), size: 20,),
            const SizedBox(width: 5),
            Text("4.1 (578 Reviews)",
              style: TextStyle(
                  color: const Color(0xff1B1B1B).withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                  fontSize: 11
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Show Review".toUpperCase(),
              style: const TextStyle(
                  color:  Color(0xffE6007E),
                  fontSize: 11,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text("COLOURS:",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff1B1B1B)),),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultCircleColor(Colors.black),
            defaultCircleColor(Colors.grey),
            defaultCircleColor(Colors.pink),
            defaultCircleColor(Colors.red),
            defaultCircleColor(Colors.orange),
          ],
        ),
      ],
    );
  }
  Widget defaultCircleColor(
      final Color? color
      ){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
