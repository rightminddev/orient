import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';
import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/request_card.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../common_modules_widgets/vocation_list.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/layout.service.dart';
import '../../../routing/app_router.dart';
import '../../../services/requests.services.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../view_models/requests.viewmodel.dart';
import 'widgets/custom_requests_page_button.widget.dart';
import 'widgets/loading_appbar_loading_widget.dart';

class RequestsScreen extends StatefulWidget {
  final GetRequestsTypes? requestsType;
  const RequestsScreen({super.key, this.requestsType = GetRequestsTypes.mine});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  late final RequestsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = RequestsViewModel();
    viewModel.initializeRequestsScreen(
        context: context,
        requestsType: widget.requestsType ?? GetRequestsTypes.mine);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RequestsViewModel>(
        create: (_) => viewModel,
        child: TemplatePage(
            pageContext: context,
            floatingActionButton: const MainAppFabWidget(),
            bottomAppbarWidget: widget.requestsType == GetRequestsTypes.mine
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(AppSizes.s170),
                    child: Consumer<RequestsViewModel>(
                        builder: (context, viewModel, child) => Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizes.s12,
                                  right: AppSizes.s12,
                                  top: AppSizes.s10),
                              child: viewModel.isLoading
                                  ? const RequestsAppbarLoading()
                                  : VacationListWidget(
                                      userSettings: viewModel.userSettings2,
                                      isInRequestsPage: true,
                                      requests: viewModel.requests,
                                    ),
                            )),
                  )
                : null,
            title: viewModel.getRequestsScreenTitleDependsOnRequestsType(
                requestsType: widget.requestsType!),
            onRefresh: () async => viewModel.initializeRequestsScreen(
                context: context, requestsType: widget.requestsType!),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
                child: Consumer<RequestsViewModel>(
                    builder: (context, viewModel, child) => viewModel.isLoading
                        ? const LoadingPageWidget()
                        : viewModel.requests == null ||
                                viewModel.requests?.isEmpty == true
                            ? NoExistingPlaceholderScreen(
                                height: LayoutService.getHeight(context) * 0.6,
                                title: AppStrings.thereIsNoRequests.tr())
                            : Column(children: [
                                /// calender button for team requests appears only when the current user has the privilege to get team requests
                                if (widget.requestsType ==
                                    GetRequestsTypes.myTeam)
                                  CustomRequestsPageButton(
                                    onPressed: () async =>
                                        await context.pushNamed(
                                            AppRoutes.requestsCalendar.name,
                                            pathParameters: {
                                              'type': 'mine',
                                              'lang':
                                                  context.locale.languageCode
                                            },
                                            extra: viewModel.requests),
                                    title: AppStrings.viewTeamRequestsOnCalendar
                                        .tr(),
                                    icon: Icons.calendar_month_outlined,
                                  ),
                                gapH16,

                                /// general screen message widget for other requests types
                                const GeneralScreenMessageWidget(
                                    screenId: '/requests'),
                                ...viewModel.requests!.map(
                                  (req) => RequestCard(
                                    reqType: widget.requestsType ??
                                        GetRequestsTypes.mine,
                                    request: req,
                                  ),
                                )
                              ])))));
  }
}
