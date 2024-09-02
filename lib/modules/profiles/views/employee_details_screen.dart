import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_sizes.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../models/employee_profile.model.dart';
import '../viewmodels/employee_details.viewmodel.dart';
import 'widgets/custom_profile_tab.widget.dart';
import 'widgets/employee_details_loading.widget.dart';
import 'widgets/employee_details_widgets/accounts_section.widget.dart';
import 'widgets/employee_details_widgets/contacts_section.widget.dart';
import 'widgets/employee_details_widgets/general_section.widget.dart';
import 'widgets/employee_details_widgets/requests_section.widget.dart';
import 'widgets/profile_details_header.widget.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final EmployeeProfileModel? employee;
  const EmployeeDetailsScreen({super.key, required this.employee});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late final EmployeeDetailsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = EmployeeDetailsViewModel();
    if (widget.employee?.id != null) {
      viewModel.initializeEmployeesListScreen(
          context: context, employeeId: widget.employee!.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainTextStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontSize: AppSizes.s10);
    return Scaffold(
      body: ChangeNotifierProvider<EmployeeDetailsViewModel>(
        create: (_) => viewModel,
        child: Consumer<EmployeeDetailsViewModel>(
            builder: (context, viewModel, child) => Column(
                  children: [
                    // Page Header
                    EmployeeDetailsHeader(employee: widget.employee),
                    if (
                        // if the current employee open his profile
                        ((widget.employee?.id ==
                                    viewModel.currentUserSettings?.userId) &&
                                (widget.employee?.id != null &&
                                    viewModel.currentUserSettings?.userId !=
                                        null)) ||
                            //if the current user is manager || the current user is leader of the opened employee profile
                            (viewModel.currentUserSettings?.managers?.keys
                                    .contains(
                                        widget.employee?.departmentId?.value) ==
                                true) ||
                            (viewModel.currentUserSettings?.isManagerIn !=
                                    null &&
                                (viewModel.currentUserSettings?.isManagerIn
                                        ?.isNotEmpty ??
                                    false)) ||
                            (viewModel.currentUserSettings?.isTeamleaderIn !=
                                    null &&
                                (viewModel.currentUserSettings?.isTeamleaderIn
                                        ?.isNotEmpty ??
                                    false)))
                      viewModel.isLoading
                          ? const EmployeeDetailsLoadingWidget()
                          : viewModel.employee == null
                              ? const NoExistingPlaceholderScreen(
                                  height: AppSizes.s300,
                                  title: 'There is no Employee Data Found !')
                              : Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.s8,
                                        vertical: AppSizes.s12),
                                    child: DefaultTabController(
                                      length: 4,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSizes.s30),
                                            ),
                                            height: AppSizes.s55,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: AppSizes.s6,
                                                vertical: AppSizes.s6),
                                            child: TabBar(
                                              indicator: BoxDecoration(
                                                color: const Color(0xff9C4995),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              labelColor: Colors.white,
                                              labelStyle: mainTextStyle,
                                              unselectedLabelStyle:
                                                  mainTextStyle,
                                              unselectedLabelColor:
                                                  Colors.white,
                                              indicatorSize:
                                                  TabBarIndicatorSize.tab,
                                              tabs: const [
                                                CustomProfileTabWidget(
                                                  tabTitle: 'CONTACT',
                                                ),
                                                CustomProfileTabWidget(
                                                  tabTitle: 'GENERAL',
                                                ),
                                                CustomProfileTabWidget(
                                                  tabTitle: 'ACCOUNTS',
                                                ),
                                                CustomProfileTabWidget(
                                                  tabTitle: 'REQUESTS',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: AppSizes.s8,
                                                      vertical: AppSizes.s8),
                                              child: TabBarView(
                                                children: [
                                                  // CONTACT SECTION
                                                  ContactsSectionWidget(
                                                      employee:
                                                          viewModel.employee),

                                                  //GENERAL SECTION
                                                  GeneralSectionWidget(
                                                      employee:
                                                          viewModel.employee),
                                                  //ACCOUNTS
                                                  AccountsSectionWidget(
                                                    employee:
                                                        viewModel.employee,
                                                  ),
                                                  //REQUESTS SECTION
                                                  RequestsSectionWidget(
                                                      employee:
                                                          viewModel.employee)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                  ],
                )),
      ),
    );
  }
}
