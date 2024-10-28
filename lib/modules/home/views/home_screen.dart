import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/layout.service.dart';
import '../../../services/requests.services.dart';
import '../../../utils/base_page/mobile.header.dart';
import '../../../utils/base_page/mobile.scaffold.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../view_models/home.viewmodel.dart';
import 'widgets/loading/home_appbar_loading.dart';
import 'widgets/loading/home_body_loading.dart';
import '../../../common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';
import 'widgets/page_body_widgets/my_requests_widget.dart';
import 'widgets/page_body_widgets/notifications_section.dart';
import 'widgets/page_header_widgets/home_appbar.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel();
    viewModel.initializeHomeScreen(context);
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => viewModel,
      child: CoreMobileScaffold(
          backgroundColor: Colors.white,
          controller: viewModel.homeScrollController,
          headers: [
            CoreHeader.transform(
              pinned: true,
              color: Colors.white,
              shrinkHeight: AppSizes.s140,
              expandedHeight: AppSizes.s300,
              shrinkChild: Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) => HomeAppbarWidget(
                        userSettings: viewModel.userSettings,
                        user2Settings: viewModel.userSettings2,
                        requests: viewModel.myRequests,
                        isExpanded: false,
                      )),
              child: SingleChildScrollView(
                  controller: viewModel.homeScrollController,
                  child: Consumer<HomeViewModel>(
                      builder: (context, viewModel, child) =>
                          viewModel.isLoading
                              ? const HomeAppbarLoading()
                              : HomeAppbarWidget(
                                  userSettings: viewModel.userSettings,
                                  requests: viewModel.myRequests,
                                  user2Settings: viewModel.userSettings2))),
            )
          ],
          floatingActionButton: const MainAppFabWidget(),
          children: [
            Consumer<HomeViewModel>(
                builder: (context, viewModel, child) => viewModel.isLoading
                    ?  HomeLoadingPage(viewAppbar: true,)
                    : Padding(
                        padding: const EdgeInsets.only(top: AppSizes.s12),
                        child: Column(
                          children: [
                            if ((viewModel.myRequests == null ||
                                    (viewModel.myRequests?.isEmpty ?? true)) &&
                                (viewModel.myTeamRequests == null ||
                                    (viewModel.myTeamRequests?.isEmpty ??
                                        true)) &&
                                (viewModel.otherDepartmentRequests != null ||
                                    (viewModel.otherDepartmentRequests
                                            ?.isNotEmpty ??
                                        true)) &&
                                (viewModel.allCompanyRequests != null ||
                                    (viewModel.allCompanyRequests?.isNotEmpty ??
                                        true)) &&
                                (viewModel.notifications != null ||
                                    (viewModel.notifications?.isNotEmpty ??
                                        true)))
                              NoExistingPlaceholderScreen(
                                  height:
                                      LayoutService.getHeight(context) * 0.4,
                                  title:
                                      'There Is No Requests and Notifications  !'),
                            const GeneralScreenMessageWidget(screenId: '/'),
                            if (viewModel.myRequests != null &&
                                viewModel.myRequests?.isNotEmpty == true)
                              RequestsWidget(
                                  requests: viewModel.myRequests!,
                                  requestType: GetRequestsTypes.mine),
                            if (viewModel.myTeamRequests != null &&
                                viewModel.myTeamRequests?.isNotEmpty == true)
                              RequestsWidget(
                                  requests: viewModel.myTeamRequests!,
                                  requestType: GetRequestsTypes.myTeam),
                            if (viewModel.otherDepartmentRequests != null &&
                                viewModel.otherDepartmentRequests?.isNotEmpty ==
                                    true)
                              RequestsWidget(
                                  requests: viewModel.otherDepartmentRequests!,
                                  requestType:
                                      GetRequestsTypes.otherDepartment),
                            if (viewModel.allCompanyRequests != null &&
                                viewModel.allCompanyRequests?.isNotEmpty ==
                                    true)
                              RequestsWidget(
                                  requests: viewModel.allCompanyRequests!,
                                  requestType: GetRequestsTypes.allCompany),
                            gapH16,
                            if (viewModel.notifications != null &&
                                viewModel.notifications?.isNotEmpty == true)
                              NotificationsSection(
                                  notifications: viewModel.notifications!)
                          ],
                        ),
                      )),
          ]),
    );
  }
}
