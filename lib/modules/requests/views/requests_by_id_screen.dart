import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_floating_action_button.widget.dart';
import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/request_card.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/layout.service.dart';
import '../../../general_services/settings.service.dart';
import '../../../routing/app_router.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../view_models/requests_with_type_id_viewmodel.dart';
import 'widgets/custom_requests_page_button.widget.dart';

class RequestsByTypeIdScreen extends StatefulWidget {
  final String requestTypeId;
  final String? employeeId;
  const RequestsByTypeIdScreen(
      {super.key, required this.requestTypeId, this.employeeId});

  @override
  State<RequestsByTypeIdScreen> createState() => _RequestsByTypeIdScreenState();
}

class _RequestsByTypeIdScreenState extends State<RequestsByTypeIdScreen> {
  late final RequestsWithTypeIdViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = RequestsWithTypeIdViewModel();
    viewModel.initializeRequestScreenByTypeIdgetRequestsByTypeId(
        context: context,
        requestTypeId: widget.requestTypeId,
        employeeId: widget.employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RequestsWithTypeIdViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          pageContext: context,
          floatingActionButton: CustomFloatingActionButton(
            iconPath: AppImages.addFloatingActionButtonIcon,
            onPressed: () async => await context
                .pushNamed(AppRoutes.addRequest.name, pathParameters: {
              'type': 'mine',
              'lang': context.locale.languageCode
            }),
            tagSuffix: 'add',
            height: AppSizes.s16,
            width: AppSizes.s16,
          ),
          title: AppSettingsService.getRequestTitleFromGenenralSettings(
                  context: context, requestId: widget.requestTypeId) ??
              AppStrings.requestsC.tr(),
          onRefresh: () async =>
              viewModel.initializeRequestScreenByTypeIdgetRequestsByTypeId(
                  context: context,
                  requestTypeId: widget.requestTypeId,
                  employeeId: widget.employeeId),
          body: Padding(
              padding: const EdgeInsets.all(AppSizes.s12),
              child: Consumer<RequestsWithTypeIdViewModel>(
                  builder: (context, viewModel, child) => viewModel.isLoading
                      ? const LoadingPageWidget()
                      : viewModel.requestsById == null ||
                              viewModel.requestsById?.isEmpty == true
                          ? NoExistingPlaceholderScreen(
                              height: LayoutService.getHeight(context) * 0.6,
                              title: AppStrings.thereIsNoRequests.tr())
                          : Column(children: [
                              /// general screen message widget for other requests types
                              GeneralScreenMessageWidget(
                                  screenId:
                                      '/requests/type-id=${widget.requestTypeId}'),
                              gapH12,
                              if (viewModel.summaryReports != null &&
                                  viewModel.summaryReports?.isNotEmpty == true)
                                CustomRequestsPageButton(
                                  onPressed: () async => viewModel
                                      .showSummaryReports(context: context),
                                  title: AppStrings.summaryReports.tr(),
                                  icon: Icons.folder_copy_outlined,
                                ),
                              gapH16,
                              ...viewModel.requestsById!.map(
                                (req) => RequestCard(
                                  request: req,
                                ),
                              )
                            ])))),
    );
  }
}
