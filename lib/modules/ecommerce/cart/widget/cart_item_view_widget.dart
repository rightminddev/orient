import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItemViewWidget extends StatefulWidget {
  const CartItemViewWidget({super.key});

  @override
  State<CartItemViewWidget> createState() => _CartItemViewWidgetState();
}

class _CartItemViewWidgetState extends State<CartItemViewWidget> {
  final List<Product> products = [
    Product(
      name: "PUTTY (ACRYLIC 1000) 233",
      price: 2512,
      oldPrice: 2512,
      quantity: 2,
      image: "assets/images/ecommerce/png/brown_paint.png",
    ),
    Product(
      name: "PUTTY (ACRYLIC 1000) 233",
      price: 2512,
      oldPrice: 2512,
      quantity: 2,
      image: "assets/images/ecommerce/png/brown_paint.png",
    ),
    Product(
      name: "PUTTY (ACRYLIC 1000) 233",
      price: 2512,
      oldPrice: 2512,
      quantity: 2,
      image: "assets/images/ecommerce/png/brown_paint.png",
    ),
  ];
  int count = 0;
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffFFFFFF)
      ),
      child: ListView.builder(
        shrinkWrap: true,
        reverse: false,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
             if(selectIndex == index+1) Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                alignment: Alignment.bottomCenter,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xff0D3B6F),
                  borderRadius: BorderRadius.circular(30),
                ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("SUBTOTAL".toUpperCase(),
                     style: const TextStyle(
                       fontWeight: FontWeight.w400,
                       fontSize: 15,
                       color: Color(0xffFFFFFF)
                     ),
                     ),
                     Text("34521 EGP".toUpperCase(),
                     style: const TextStyle(
                       fontWeight: FontWeight.w400,
                       fontSize: 15,
                       color: Color(0xffFFFFFF)
                     ),
                     ),
      
                   ],
                 ),
              ),
              GestureDetector(
                onTap: (){
                  if(selectIndex == index + 1){
                    print("yes");
                    setState(() {
                      selectIndex = 0;
                      print(selectIndex);
                    });
                  }else{
                    setState(() {
                      selectIndex = index+1;
                      print(selectIndex);
                    });
                  }
                },
                  child: defaultCartItem(product: products[index], count: count)),
            ],
          );
        },
      ),
    );
  }
}
class Product {
  final String name;
  final double price;
  final double oldPrice;
  final int quantity;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.quantity,
    required this.image,
  });
}

Widget defaultCartItem({product, count}){
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                product.image,
                width: 90,
                height: 99,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Color(0xffE6007E),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "${product.price} EGP",
                          style: const TextStyle(
                            color: Color(0xff1B1B1B),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${product.oldPrice} EGP",
                          style: TextStyle(
                            color: const Color(0xff1B1B1B).withOpacity(0.5),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
              ),
              GestureDetector(
                onTap: (){},
                child: SvgPicture.asset("assets/images/svg/delete.svg"),
              )
            ],
          ),
        );
      }
  );
}
