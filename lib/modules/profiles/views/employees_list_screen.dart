import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/layout.service.dart';
import '../../../routing/app_router.dart';
import '../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../viewmodels/employees_list.viewmodel.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({super.key});

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  late final EmployeesListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = EmployeesListViewModel();
    viewModel.initializeEmployeesListScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmployeesListViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          backgroundColor: Colors.white,
          bottomAppbarWidget: PreferredSize(
            preferredSize: const Size.fromHeight(AppSizes.s70),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.s12, vertical: AppSizes.s12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: viewModel.updateSearchQuery,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search by name',
                          fillColor:
                              Theme.of(context).primaryColor.withOpacity(0.05),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed:
                                  viewModel.releaseSearchValuesAndFilters),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(AppSizes.s8)),
                    ),
                  ),
                  gapW4,
                  IconButton(
                    icon: Image.asset(
                      AppImages.profileFilter,
                      width: AppSizes.s22,
                      height: AppSizes.s22,
                      fit: BoxFit.cover,
                    ),
                    onPressed: () async =>
                        await viewModel.showDepartmentFilterModal(context),
                  ),
                ],
              ),
            ),
          ),
          pageContext: context,
          title: 'EMPLOYEES LIST',
          onRefresh: () async =>
              await viewModel.initializeEmployeesListScreen(context),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.s12),
                child: Consumer<EmployeesListViewModel>(
                    builder: (context, viewModel, child) => viewModel.isLoading
                        ? const LoadingPageWidget(
                            reverse: true,
                            height: AppSizes.s75,
                          )
                        : viewModel.employees == null ||
                                viewModel.employees?.isEmpty == true
                            ? NoExistingPlaceholderScreen(
                                height: LayoutService.getHeight(context) * 0.6,
                                title: 'There is no Employees !')
                            : Column(children: [
                                const GeneralScreenMessageWidget(
                                    screenId: '/employees-list'),
                                ...viewModel.filteredEmployees.map((employee) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: employee.avatar != null
                                            ? CircleAvatar(
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          employee.avatar!,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          const ShimmerAnimatedLoading(
                                                            circularRaduis:
                                                                AppSizes.s50,
                                                          ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                            Icons
                                                                .image_not_supported_outlined,
                                                          )),
                                                ),
                                              )
                                            : CircleAvatar(
                                                child: Image.asset(
                                                  AppImages.profilePlaceHolder,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        title: Text(employee.name ?? ''),
                                        subtitle: employee.jobTitle != null &&
                                                    employee.jobTitle
                                                            ?.isNotEmpty ==
                                                        true ||
                                                employee.phone != null &&
                                                    employee.phone
                                                            ?.isNotEmpty ==
                                                        true
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (employee.jobTitle != null)
                                                    Text(employee.jobTitle!),
                                                  if (employee.phone != null)
                                                    Text(
                                                        '${employee.countryKey ?? ''}${employee.phone!}'),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                        onTap: () async => await context
                                            .pushNamed(
                                                AppRoutes.employeeDetails.name,
                                                extra: employee,
                                                pathParameters: {
                                              'lang':
                                                  context.locale.languageCode
                                            }),
                                      ),
                                      Divider(
                                        color: Colors.grey.withOpacity(0.2),
                                        height: AppSizes.s1,
                                      )
                                    ],
                                  );
                                })
                              ])),
              ),
            ],
          )),
    );
  }
}
