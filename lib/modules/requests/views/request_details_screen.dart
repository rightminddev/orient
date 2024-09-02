import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/layout.service.dart';
import '../../../models/request.model.dart';
import '../../../utils/modal_sheet_helper.dart';
import '../view_models/request_details.viewmodel.dart';
import 'widgets/modals/management_response.modal.dart';
import 'widgets/custom_request_details_button.widget.dart';
import 'widgets/custom_tabbar_view.widget.dart';
import 'widgets/request_details_header_widget.dart';

class RequestDetailsScreen extends StatelessWidget {
  final RequestModel request;
  const RequestDetailsScreen({super.key, required this.request});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<RequestDetailsViewModel>(
      create: (_) =>
          RequestDetailsViewModel()..initializeRequestDetails(context: context),
      child: Consumer<RequestDetailsViewModel>(
        builder: (context, viewModel, child) => Column(
          children: [
            RequestDetailsHeaderWidget(
              height: AppSizes.s300,
              request: request,
            ),
            Expanded(child: CustomTabbarViewRequestDetails(request: request)),
            if ((viewModel.userSettings?.userId == request.userId &&
                request.userId != null &&
                viewModel.userSettings?.userId != null))
              // Case  : the current request is my request
              (request.status?.value?.trim() == 'waiting_seen' ||
                      request.status?.value?.trim() == 'waiting' ||
                      request.status?.value?.trim() == 'approved' ||
                      request.status?.value?.trim() == 'refused')
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.s6, horizontal: AppSizes.s8),
                      margin: const EdgeInsets.all(AppSizes.s8),
                      width: LayoutService.getWidth(context),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(AppSizes.s50)),
                      child: Row(children: [
                        if (request.status?.value?.trim() == 'waiting_seen' ||
                            request.status?.value?.trim() == 'waiting') ...[
                          CustomRequestDetailsButton(
                            title: AppStrings.askRemember.tr(),
                            onPressed: () async =>
                                await viewModel.askToRemember(
                                    context: context,
                                    requestId: request.id?.toString()),
                          ),
                          gapW8,
                          CustomRequestDetailsButton(
                            title: AppStrings.askIgnore.tr(),
                            onPressed: () async => await viewModel.askToIgnore(
                                context: context,
                                requestId: request.id?.toString()),
                          ),
                        ],
                        if ((request.status?.value?.trim() == 'approved' ||
                            request.status?.value?.trim() == 'refused')) ...[
                          gapW8,
                          CustomRequestDetailsButton(
                              title: AppStrings.complaint.tr(),
                              onPressed: () async =>
                                  await viewModel.askToComplain(
                                      context: context,
                                      requestId: request.id?.toString()))
                        ]
                      ]),
                    )
                  : const SizedBox.shrink()
            else
              // Case: the current request not my request [Manager || Team leader case]
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.s6, horizontal: AppSizes.s8),
                margin: const EdgeInsets.all(AppSizes.s8),
                width: LayoutService.getWidth(context),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(AppSizes.s50)),
                child: Row(children: [
                  if (request.user?.id != null) ...[
                    // case: the current user is Manager
                    CustomRequestDetailsButton(
                        title: AppStrings.statistics.tr(),
                        onPressed: () async =>
                            await viewModel.showAndGetEmployeeStatistics(
                                context, request.user!.id.toString())),
                    gapW8,
                  ],
                  if ((request.status?.value?.trim() == 'waiting_seen' ||
                          request.status?.value?.trim() == 'waiting') &&
                      request.id != null)
                    CustomRequestDetailsButton(
                      title: AppStrings.managementResponse.tr(),
                      onPressed: () async =>
                          await ModalSheetHelper.showModalSheet(
                              context: context,
                              modalContent: ManagementResponseModal(
                                requestId: request.id.toString(),
                              ),
                              title: 'Management Response',
                              height: (LayoutService.getHeight(context) * 0.5)),
                    )
                ]),
              )
          ],
        ),
      ),
    ));
  }
}
