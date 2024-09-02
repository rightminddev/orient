import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/layout.service.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../view_models/payrolls_list.viewmodel.dart';
import 'widgets/payroll_list_item.widget.dart';
import '../../../common_modules_widgets/payrolls_and_penalties_and_rewards_loading_screens.widget.dart';

class PayrollsListScreen extends StatefulWidget {
  final String? empId;
  final String? empName;
  const PayrollsListScreen({super.key, this.empId, this.empName});

  @override
  State<PayrollsListScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<PayrollsListScreen> {
  late final PayrollsListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = PayrollsListViewModel();
    viewModel.initializePayrollsListScreen(
        context: context, empId: widget.empId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PayrollsListViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          floatingActionButton: const MainAppFabWidget(),
          pageContext: context,
          bottomAppbarWidget: widget.empId != null &&
                  widget.empId?.isNotEmpty == true &&
                  widget.empName != null &&
                  widget.empName?.isNotEmpty == true &&
                  viewModel.userSettings?.userId.toString() != widget.empId
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(AppSizes.s40),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s12, vertical: AppSizes.s6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          widget.empName!,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: AppSizes.s20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          title: 'Payrolls',
          onRefresh: () async => await viewModel.initializePayrollsListScreen(
              context: context, empId: widget.empId),
          body: Padding(
            padding: const EdgeInsets.all(AppSizes.s12),
            child: SingleChildScrollView(
              child: Consumer<PayrollsListViewModel>(
                  builder: (context, viewModel, child) => viewModel.isLoading
                      ? const PayrollsAndPenaltiesRewardsLoadingScreensWidget()
                      : viewModel.payrolls?.isEmpty == true ||
                              viewModel.payrolls == null
                          ? NoExistingPlaceholderScreen(
                              height: LayoutService.getHeight(context) * 0.6,
                              title: 'No Existing Payrolls')
                          : Column(children: [
                              /// general screen message widget for other requests types
                              const GeneralScreenMessageWidget(
                                  screenId: '/payrolls'),
                              ...viewModel.payrolls!.map((payroll) =>
                                  PayrollListItemWidget(payroll: payroll))
                            ])),
            ),
          )),
    );
  }
}
