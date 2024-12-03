import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/search/controller/search_controller.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:provider/provider.dart';

class SearchSizesWidget extends StatefulWidget {
  bool? viewSize = true;
  SearchSizesWidget({super.key, this.viewSize});

  @override
  State<SearchSizesWidget> createState() => _SearchSizesWidgetState();
}

class _SearchSizesWidgetState extends State<SearchSizesWidget> {
  int sizeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchControllerProvider>(
      builder: (context, value, child) {
        print("Product ----- > ${value.searchProductsAttributesSize}");
        return Container(
          height: 50,
          child: Row(
            mainAxisAlignment: (widget.viewSize == true)? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              if(widget.viewSize == true) Text("${AppStrings.size.tr().toUpperCase()}:", style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff1B1B1B)
              ),),
              const SizedBox(width: 8),
              Container(
                height: 24,
                alignment: Alignment.topLeft,
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: ListView.separated(
                    shrinkWrap: true,
                    reverse: false,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index)=> GestureDetector(
                      onTap: (){
                        setState(() {
                          sizeIndex = index;
                          SearchConstant.selectSizeId = value.searchProductsAttributesSize[index]['id'];
                        });
                      },
                      child: Container(
                        margin:const EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        height: 30,
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                          color: (sizeIndex != index) ? Colors.transparent : const Color(0xffE6007E),
                          border: Border.all(color:(sizeIndex != index) ? const Color(0xff000000).withOpacity(0.43): Colors.transparent),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(value.searchProductsAttributesSize[index]['title'], style: TextStyle(
                            color: (sizeIndex != index) ?const Color(0xff1B1B1B) : const Color(0xffFFFFFF),
                            fontSize: 8,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                    ),
                    separatorBuilder: (context, index)=>const SizedBox(width: 0,),
                    itemCount: value.searchProductsAttributesSize.length
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
