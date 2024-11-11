import 'package:flutter/material.dart';
import 'package:orient/routing/app_router.dart';
import 'package:provider/provider.dart';
import '../../../general_services/app_theme.service.dart';
import '../view_models/merchant_main_view_model.dart';
import 'package:orient/utils/components/general_components/general_components.dart';

//MerchantMainScreen
class MerchantMainScreen extends StatefulWidget {
  final MerchantNavbarPages navbarPages;
  final Widget child;
  const MerchantMainScreen({
    super.key,
    required this.navbarPages,
    required this.child,
  });
  @override
  State<MerchantMainScreen> createState() => _MerchantMainScreenState();
}

class _MerchantMainScreenState extends State<MerchantMainScreen> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MerchantMainViewModel>(context);
    viewModel.currentPage = widget.navbarPages;
    return Scaffold(
      backgroundColor: AppThemeService.colorPalette.bodyBackgroundColor.color,
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
          selectIndex: selectIndex,
          tapBarItemsWidth: MediaQuery.sizeOf(context).width * 0.9,
          onTapItem: (index) {
            setState(() {
              selectIndex = index;
            });
            if (index == 0) {
              viewModel.onItemTapped(
                  context: context,
                  page: MerchantNavbarPages.merchantHomeScreen);
              print(index);
            }
            if (index == 1) {
              viewModel.onItemTapped(
                  context: context,
                  page: MerchantNavbarPages.merchantStoresScreen);
            }
            if (index == 2) {
              viewModel.onItemTapped(
                  context: context, page: MerchantNavbarPages.notifications);
              print(index);
            }
            if (index == 3) {
              viewModel.onItemTapped(
                  context: context, page: MerchantNavbarPages.merchantMore);
              print(index);
            }
          },
        ),
      ),
    );
  }
}
