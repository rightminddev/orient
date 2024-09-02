import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';
import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/notification_card.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/layout.service.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../view_models/notifications.viewmodel.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = NotificationViewModel();
    viewModel.initializeNotificationScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          pageContext: context,
          floatingActionButton: const MainAppFabWidget(),
          title: 'My Notifications',
          onRefresh: () async =>
              await viewModel.initializeNotificationScreen(context),
          body: Padding(
            padding: const EdgeInsets.all(AppSizes.s12),
            child: Consumer<NotificationViewModel>(
                builder: (context, viewModel, child) => viewModel.isLoading
                    ? const LoadingPageWidget(
                        height: AppSizes.s75,
                      )
                    : viewModel.notifications?.isEmpty == true ||
                            viewModel.notifications == null
                        ? NoExistingPlaceholderScreen(
                            height: LayoutService.getHeight(context) * 0.6,
                            title: 'There is no notification yet !')
                        : Column(children: [
                            const GeneralScreenMessageWidget(
                                screenId: '/notifications'),
                            ...viewModel.notifications!.map(
                              (notification) => NotificationCard(
                                notification: notification,
                              ),
                            )
                          ])),
          )),
    );
  }
}
