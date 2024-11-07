import 'package:flutter/material.dart';
import 'package:orient/modules/ecommerce/main_screen/main_model.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

class ECommerceMainScreen extends StatefulWidget {
  final EcommerceNavbarPages ecommerceNavbarPages;
  final Widget child;
  ECommerceMainScreen(
      {super.key, required this.ecommerceNavbarPages, required this.child});
  @override
  State<ECommerceMainScreen> createState() => _ECommerceMainScreenState();
}

class _ECommerceMainScreenState extends State<ECommerceMainScreen> {


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EcommerceMainScreenViewModel>(context);
    viewModel.currentPage = widget.ecommerceNavbarPages;
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        height: 115,
        clipBehavior: Clip.none,
        color: const Color(0xffFFFFFF),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: defaultBottomNavigationBar(
            items: viewModel.navs,
            selectIndex: viewModel.selectIndexs,
            tapBarItemsWidth: MediaQuery.sizeOf(context).width * 0.9,
            onTapItem: (index) {
              setState(() {
                viewModel.selectIndexs = index;
              });
              if (index == 0) {
                viewModel.onItemTapped(
                    context: context,
                    page: EcommerceNavbarPages.eCommerceHomeScreen);
                print(index);
              }
              if (index == 1) {
                viewModel.onItemTapped(
                    context: context,
                    page: EcommerceNavbarPages.ecommerceTestScreen);
              }
              if (index == 2) {
                viewModel.onItemTapped(
                    context: context,
                    page: EcommerceNavbarPages.eCommerceShoppingCart);
                print(index);
              }
              if (index == 3) {
                viewModel.onItemTapped(
                    context: context,
                    page: EcommerceNavbarPages.eCommerceSearchScreen);
                print(index);
              }
              if (index == 4) {
                viewModel.onItemTapped(
                    context: context,
                    page: EcommerceNavbarPages.eCommerceMoreScreen);
                print(index);
              }
            }),
      ),
    );
  }
}
