import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class CheckoutPaymentWidget extends StatefulWidget {
  @override
  State<CheckoutPaymentWidget> createState() => _CheckoutPaymentWidgetState();
}

class _CheckoutPaymentWidgetState extends State<CheckoutPaymentWidget> {
  int? selectedPaymentIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutControllerProvider>(
        builder: (context, value, child) {
          return Container(
            constraints: const BoxConstraints(
              minHeight: 0,
              maxHeight: 190,
            ),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
            ),
            child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                reverse: false,
                itemBuilder: (context, index)=>GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedPaymentIndex = index;
                      value.selectedPaymentId = value.checkoutPaymentMethods[index]['id'];
                    });
                    if(value.userAddressModel!.userAddress!.id != null && value.checkoutPaymentMethods[index]['id'] != null) {
                      value.updateCart(
                          context: context,
                          address_id: value.userAddressModel!.userAddress!.id,
                          payment_method_id: value.checkoutPaymentMethods[index]['id']
                      );
                    }
                  },
                  child: Container(
                    height: 48,
                    child: Row(
                      children: [
                        CachedNetworkImage(
                            imageUrl: (value.checkoutPaymentMethods[index]['logo'].isNotEmpty)?value.checkoutPaymentMethods[index]['logo'][0]['file']:"",
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                            placeholder: (context,
                                url) => const ShimmerAnimatedLoading(
                              circularRaduis:
                              AppSizes.s50,
                            ),
                            errorWidget: (context,
                                url, error) =>
                            const Icon(
                              Icons
                                  .image_not_supported_outlined,
                            )),
                        SizedBox(width: 10),
                        Text("${value.checkoutPaymentMethods[index]['title']}",
                          style: const TextStyle(
                              color: Color(0xff464646),
                              fontWeight: FontWeight.w400,
                              fontSize: 12
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (selectedPaymentIndex == index)?const Color(0xff027FEE) : Colors.transparent,
                              border: Border.all(color:const Color(0xff027FEE) )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index)=> SizedBox(height: 10, child: Divider(),),
                itemCount: value.checkoutPaymentMethods.length
            ),
          );
        },
    );
  }
}
