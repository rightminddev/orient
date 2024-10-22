import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/merchant/stores/views/create_edit_store_screen.dart';
import 'package:orient/merchant/stores/views/my_stores_actions_screen.dart';
import 'package:orient/models/stores/store_model.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/custom_floating_action_button.widget.dart';
import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../routing/app_router.dart';
import '../../../utils/components/general_components/custom_list_tile_widget.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../utils/components/general_components/pagination_widget.dart';
import '../../stores/view_models/stores.viewmodel.dart';

class MerchantStoresScreen extends StatefulWidget {
  const MerchantStoresScreen({super.key});

  @override
  State<MerchantStoresScreen> createState() => _MerchantStoresScreenState();
}

class _MerchantStoresScreenState extends State<MerchantStoresScreen> {
  final ScrollController controller = ScrollController();
  late final StoresViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = StoresViewModel();
    viewModel.initializeMyStoresScreen(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void goToAddStore({
    required BuildContext context,
    required String page,
  }) {
    Offset begin = const Offset(1.0, 0.0);
    context.pushNamed(page,
        extra: begin, pathParameters: {'lang': context.locale.languageCode});
  }

  void goToStoreActions({
    required BuildContext context,
    required String page,
    required StoreModel storeModel,
  }) {
    Offset begin = const Offset(1.0, 0.0);
    context.pushNamed(page,
        extra: {'begin': begin, "storeModel": storeModel},
        pathParameters: {'lang': context.locale.languageCode});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoresViewModel>.value(
      value: viewModel,
      child: Consumer<StoresViewModel>(
        builder: (context, viewModel, child) => TemplatePage(
          backgroundColor: Colors.white,
          /*
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
          */
          pageContext: context,
          //  title: 'EMPLOYEES LIST',
          // onRefresh: () async =>
          //     await viewModel.initializeMyStoresScreen(context),
          title: AppStrings.myStores.tr(),
          floatingActionButton: CustomFloatingActionButton(
            iconPath: AppImages.addFloatingActionButtonIcon,
            onPressed: () {
              goToAddStore(
                context: context,
                page: AppRoutes.addStore.name,
              );
            },
            tagSuffix: 'add',
            height: AppSizes.s16,
            width: AppSizes.s16,
          ),

          body: GradientBgImage(
            child: Column(
              children: [
                SizedBox(height: 0),
                PaginationWidget(
                  currentCount: viewModel.pageNumber,
                  isLoading: viewModel.isLoading,
                  firstFetch: () {
                    viewModel.pageNumber = 1;

                    viewModel.myStores = List.empty(growable: true);
                    viewModel.initializeMyStoresScreen(context);
                  },
                  scrollController: controller,
                  paginationFetch: () {
                    final hasMoreData =
                        viewModel.hasMoreData(viewModel.myStores.length);
                    if (hasMoreData) {
                      //      storesViewModel.pageNumber = storesViewModel.pageNumber + 1;

                      viewModel.initializeMyStoresScreen(context);
                    } else {}
                  },
                  scrollableWidget: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: viewModel.myStores.map((element) {
                        return GestureDetector(
                          onTap: () {
                            goToStoreActions(
                              context: context,
                              page: AppRoutes.storeActions.name,
                              storeModel: element,
                            );
                          },
                          child: CustomListTileWidget(
                            image: AppImages.storeDefault,
                            isImageUrl: false,
                            title: element.name ?? '',
                            subtitle:
                                '${element.state?.title}, ${element.country?.title}',
                            titleFontColor: AppThemeService
                                .colorPalette.secondaryTextColor.color,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
