import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/merchant/stores/views/create_edit_store_screen.dart';
import 'package:orient/merchant/stores/views/my_stores_actions_screen.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/custom_floating_action_button.widget.dart';
import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../utils/components/general_components/custom_list_tile_widget.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../stores/view_models/stores.viewmodel.dart';

class MyStoresView extends StatefulWidget {
  const MyStoresView({super.key});

  @override
  State<MyStoresView> createState() => _MyStoresViewState();
}

class _MyStoresViewState extends State<MyStoresView> {
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoresViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
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
        onRefresh: () async =>
            await viewModel.initializeMyStoresScreen(context),
        title: AppStrings.myStores.tr(),
        floatingActionButton: CustomFloatingActionButton(
          iconPath: AppImages.addFloatingActionButtonIcon,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateEditStoreScreen(),
              ),
            );
          },
          tagSuffix: 'add',
          height: AppSizes.s16,
          width: AppSizes.s16,
        ),

        //   controller: controller,
        // appBar: AppBar(
        //   title: Text(
        //     AppStrings.myStores.tr(),
        //     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        //           fontWeight: FontWeight.w700,
        //           color: Color(0xFF224982),
        //         ),
        //     textAlign: TextAlign.center,
        //     maxLines: 2,
        //     overflow: TextOverflow.ellipsis,
        //     // fontSize: 16,
        //     // fontFamily: 'Poppins',
        //     // fontWeight: FontWeight.w700,
        //     // height: 0.09,
        //     // letterSpacing: 1,
        //   ),
        // ),
        // bodyWithoutScroll: false,

        body: GradientBgImage(
          child: Consumer<StoresViewModel>(
            builder: (context, viewModel, child) => viewModel.isLoading
                ? const LoadingPageWidget(
                    reverse: true,
                    height: AppSizes.s75,
                  )
                : Column(
                    children: viewModel.myStores.map((element) {
                      return GestureDetector(
                        onTap: () async {
                          //TODO: update this
                          // await context.pushNamed(AppRoutes.storeActions.name,
                          //     extra: element,
                          //     pathParameters: {
                          //       'lang': context.locale.languageCode
                          //     });

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyStoreActionsScreen(storeModel: element),
                            ),
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
      ),
    );
  }
}
