import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';

class SingleChangeCountWidget extends StatefulWidget {
  const SingleChangeCountWidget({super.key});

  @override
  State<SingleChangeCountWidget> createState() => _SingleChangeCountWidgetState();
}

class _SingleChangeCountWidgetState extends State<SingleChangeCountWidget> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("${AppStrings.count.tr().toUpperCase()}:", style:const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xff1B1B1B)
          ),),
          const SizedBox(width: 8),
          Container(
            width: 97,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      count--;
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0xff0D3B6F)),
                    ),
                    child: const Icon(Icons.remove, color: Color(0xff0D3B6F), size: 16,),
                  ),
                ),
                Text(count.toString().padLeft(2, '0'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff1B1B1B)
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      count++;
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0xff0D3B6F)),
                    ),
                    child: const Icon(Icons.add, color: Color(0xff0D3B6F), size: 16,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
