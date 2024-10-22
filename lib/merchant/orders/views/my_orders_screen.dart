import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/merchant/orders/view_models/orders.viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../utils/components/general_components/order_container_widget.dart';
import '../../../utils/components/general_components/pagination_widget.dart';

class MyOrdersScreen extends StatefulWidget {
  final int storeId;

  const MyOrdersScreen({super.key, required this.storeId});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final ScrollController controller = ScrollController();
  late final OrdersViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OrdersViewModel();
    viewModel.initializeMyOrdersScreen(context, widget.storeId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrdersViewModel>(
      create: (_) => viewModel,
      child: Consumer<OrdersViewModel>(
        builder: (context, viewModel, child) {
          return TemplatePage(
            backgroundColor: Colors.white,

            pageContext: context,
            //  title: 'EMPLOYEES LIST',
            // onRefresh: () async =>
            //     await viewModel.initializeMyOrdersScreen(context, widget.storeId),
            title: AppStrings.myOrders.tr(),

            body: GradientBgImage(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  PaginationWidget(
                    currentCount: viewModel.pageNumber,
                    isLoading: viewModel.isLoading,
                    firstFetch: () {
                      viewModel.pageNumber = 1;

                      viewModel.myOrders = List.empty(growable: true);
                      viewModel.initializeMyOrdersScreen(
                          context, widget.storeId);
                    },
                    scrollController: controller,
                    paginationFetch: () {
                      final hasMoreData =
                          viewModel.hasMoreData(viewModel.myOrders.length);
                      if (hasMoreData) {
                        viewModel.initializeMyOrdersScreen(
                            context, widget.storeId);
                      } else {}
                    },
                    scrollableWidget: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: viewModel.myOrders.map((element) {
                          return OrderContainerWidget(
                            orderModel: element,
                            storeId: widget.storeId,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
