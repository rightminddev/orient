import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/merchant/orders/view_models/orders.viewmodel.dart';
import 'package:orient/utils/components/general_components/order_container_widget.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../utils/components/general_components/pagination_widget.dart';

class MyInvoicesScreen extends StatefulWidget {
  final int storeId;
  final int orderId;
  const MyInvoicesScreen({super.key, required this.storeId, required this.orderId});

  @override
  State<MyInvoicesScreen> createState() => _MyInvoicesScreenState();
}

class _MyInvoicesScreenState extends State<MyInvoicesScreen> {
  final ScrollController controller = ScrollController();
  late final OrdersViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OrdersViewModel();
    viewModel.initializeGetMyOrdersInvoices(context, widget.storeId, widget.orderId);
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
            title: AppStrings.myInvoices.tr(),

            body: GradientBgImage(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 0),
                  PaginationWidget(
                    currentCount: viewModel.pageNumber,
                    isLoading: viewModel.isLoading,
                    firstFetch: () {
                      viewModel.pageNumber = 1;
                      viewModel.myInvoices = List.empty(growable: true);
                      viewModel.initializeGetMyOrdersInvoices(
                          context, widget.storeId, widget.orderId);
                    },
                    scrollController: controller,
                    paginationFetch: () {
                      final hasMoreData =
                      viewModel.hasMoreData(viewModel.myInvoices.length);
                      if (hasMoreData) {
                        viewModel.initializeGetMyOrdersInvoices(
                            context, widget.storeId, widget.orderId);
                      } else {}
                    },
                    scrollableWidget: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: viewModel.myInvoices.map((element) {
                          return OrderContainerWidget(
                              invoiceModel: element,
                              storeId: widget.storeId,
                              invoice : "yes",
                            orderId: widget.orderId,
                            invoiceDetails: true,
                          );
                        }).toList()
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
