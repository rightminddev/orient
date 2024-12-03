import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/search/controller/search_controller.dart';
import 'package:orient/modules/ecommerce/search/widget/search_sizes_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_sizes_widget.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:provider/provider.dart';

class SearchFilterWidget extends StatefulWidget {
  BuildContext? contexts;
   SearchFilterWidget({super.key, this.contexts});

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  var selectIndex;
  int? selectId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchControllerProvider = Provider.of<SearchControllerProvider>(widget.contexts!, listen: false,);

        searchControllerProvider.getSearch(context: widget.contexts!, addAll: true, isNewPage: false ,pages: 1);
    });
  }
  @override
  Widget build(BuildContext context) {
    final searchControllerProvider = Provider.of<SearchControllerProvider>(widget.contexts!);
    final homeProvider = Provider.of<HomeProvider>(widget.contexts!);
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
          color: Color(0xffFFFFFF)
      ),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.72,
      alignment: Alignment.topCenter,
      child:(searchControllerProvider.isLoadingSearch)?
      HomeLoadingPage(viewAppbar: false)
      :SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Center(
              child:Container(
                width: 63,
                height: 5,
                decoration: BoxDecoration(
                    color:const Color(0xffB9C0C9),
                    borderRadius: BorderRadius.circular(100)
                ),
              ) ,
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultTitleText(title: AppStrings.productsCategory.tr()),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3,
                    ),
                    itemCount: searchControllerProvider.searchProductsCategories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectIndex = index;
                          SearchConstant.selectId = searchControllerProvider.searchProductsCategories[index]['id'];
                          print("selectId ---> $selectId");
                        });
                      },
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: (selectIndex != index) ? Colors.transparent : const Color(0xffE6007E),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: (selectIndex != index) ? Colors.grey : Colors.transparent,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${searchControllerProvider.searchProductsCategories[index]['title']}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: (selectIndex != index)
                                  ? const Color(0xff0D3B6F)
                                  : const Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  defaultTitleText(title: AppStrings.productsColors.tr()),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 25,
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: ListView.separated(
                        shrinkWrap: true,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: (){
                            searchControllerProvider.changeColorIndex(index);
                            SearchConstant.selectColorId = searchControllerProvider.searchProductsAttributesColor[index]['id'];
                          },
                            child: defaultCircleColor(
                                Color(int.parse("0xff${searchControllerProvider.searchProductsAttributesColor[index]['data']}")),
                                (searchControllerProvider.selectColorIndex == index)? const Color(0xffFFFFFF):Colors.transparent
                            )),
                        separatorBuilder: (context, index) =>const SizedBox.shrink(),
                        itemCount: searchControllerProvider.searchProductsAttributesColor.length
                    ),
                  ),
                  const SizedBox(height: 40,),
                  defaultTitleText(title: AppStrings.productsSize.tr()),
                  const SizedBox(height: 0),
                  SearchSizesWidget(viewSize: false,),
                  const SizedBox(height: 30,),
                  defaultTitleText(title: AppStrings.priceRange.tr()),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      defaultTextFormField(
                          hintText: AppStrings.minPrice.tr().toUpperCase(),
                          controller: SearchConstant.minPriceController
                      ),
                      const SizedBox(width: 10,),
                      defaultTextFormField(
                          hintText: AppStrings.maxPrice.tr().toUpperCase(),
                          controller: SearchConstant.maxPriceController
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: const Color(0xff0D3B6F)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding:const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            AppStrings.clear.tr().toUpperCase(),
                            style:const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff0D3B6F)
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          print("VALUE IS -> ${SearchConstant.minPriceController.text}");
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff0D3B6F),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/ecommerce/svg/apply_filter.svg"),
                              const SizedBox(width: 15,),
                              Text(
                                AppStrings.applyFilter.tr().toUpperCase(),
                                style:const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffFFFFFF)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget defaultTextFormField({
    TextEditingController? controller,
    String? hintText,
  }){
    return Container(
      height: 48,
      width: 120,
      alignment: Alignment.center,
      padding:const EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
          color:const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText ?? "Input",
            labelStyle: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff191C1F)
            ),
            hintStyle:const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff464646)
            ),
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          ),
          keyboardType: TextInputType.number,
      ),
    );
  }
  Widget defaultTitleText({
     title
})=> Text(
      title.toUpperCase(),
      style: const TextStyle(
          color: Color(0xff0D3B6F),
          fontWeight: FontWeight.w500,
          fontSize: 10
      ),
    );
  Widget defaultCircleColor(
      final Color? color,
      final Color? borderColor,
      ){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 4),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor!)
      ),
    );
  }
}
