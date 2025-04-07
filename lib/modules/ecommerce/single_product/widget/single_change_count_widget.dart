import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:provider/provider.dart';

class SingleChangeCountWidget extends StatefulWidget {
  const SingleChangeCountWidget({super.key});

  @override
  State<SingleChangeCountWidget> createState() => _SingleChangeCountWidgetState();
}

class _SingleChangeCountWidgetState extends State<SingleChangeCountWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SingleProductProvider>(
        builder: (context, value, child) {
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
                            value.count--;
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
                      Text(value.count.toString().padLeft(2, '0'),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff1B1B1B)
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            value.count++;
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
        },
    );
  }
}
