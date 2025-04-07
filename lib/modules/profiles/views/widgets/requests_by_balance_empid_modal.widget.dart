import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../common_modules_widgets/loading_page.widget.dart';
import '../../../../common_modules_widgets/request_card.widget.dart';
import '../../../../constants/app_strings.dart';
import '../../../../services/requests.services.dart';
import '../../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../../viewmodels/requests_by_balance_empid.viewmodel.dart';

class RequestsByBalanceAndEmployeeIdModal extends StatefulWidget {
  final String employeeId;
  final String? requestTypeId;
  final bool getLatestRequests;
  const RequestsByBalanceAndEmployeeIdModal(
      {super.key,
      required this.employeeId,
      required this.requestTypeId,
      this.getLatestRequests = false});

  @override
  State<RequestsByBalanceAndEmployeeIdModal> createState() =>
      _RequestsByBalanceAndEmployeeIdModalState();
}

class _RequestsByBalanceAndEmployeeIdModalState
    extends State<RequestsByBalanceAndEmployeeIdModal> {
  late final RequestsByBalanceAndEmployeeIdViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = RequestsByBalanceAndEmployeeIdViewModel();
    viewModel.initializeRequestByTypeIdAndEmpIdModal(
        context: context,
        requestId: widget.requestTypeId,
        latestRequestsWithoutRequestId: widget.getLatestRequests,
        empId: widget.employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Consumer<RequestsByBalanceAndEmployeeIdViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gapH20,
              Expanded(
                child: Consumer<RequestsByBalanceAndEmployeeIdViewModel>(
                    builder: (context, viewModel, child) => viewModel.isLoading
                        ? const LoadingPageWidget()
                        : viewModel.requests == null ||
                                viewModel.requests?.isEmpty == true
                            ? Center(
                                child: NoExistingPlaceholderScreen(
                                    title: AppStrings.thereIsNoRequests.tr()),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                    children: viewModel.requests!
                                        .map(
                                          (req) => RequestCard(
                                            request: req,
                                            reqType:
                                                GetRequestsTypes.allCompany,
                                          ),
                                        )
                                        .toList()),
                              )),
              ),
            ],
          );
        },
      ),
    );
  }
}
