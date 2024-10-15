import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/utils/cached_network_image_widget.dart';
import 'package:orient/utils/media_query_values.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../components/custom_list_tile_widget.dart';
import '../../../components/gradient_bg_image.dart';
import '../../../models/stores/store_model.dart';
import '../../../routing/app_router.dart';
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
                          await context.pushNamed(AppRoutes.storeActions.name,
                              extra: element,
                              pathParameters: {
                                'lang': context.locale.languageCode
                              });
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
/*
class StoreItemWidget extends StatelessWidget {
  final StoreModel storeModel;
  const StoreItemWidget({super.key, required this.storeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s18, horizontal: AppSizes.s16),
      decoration: ShapeDecoration(
        color: AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CachedNetWokImageWidget(
            url: storeModel.imageUrl,
            width: context.width * 0.2,
            height: context.width * 0.2,
            radius: context.width * 0.1,
          ),
          const SizedBox(width: AppSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeModel.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppThemeService
                            .colorPalette.secondaryTextColor.color,
                      ),
                  //  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Color(0xFFE6007E),
                  //   fontSize: 16,
                  //   fontFamily: 'Poppins',
                  //   fontWeight: FontWeight.w600,
                  //   height: 0,
                  // ),
                ),
                Text(
                  '${storeModel.city}, ${storeModel.country}',
                  style: Theme.of(context).textTheme.displaySmall,
                  //  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Color(0xFFE6007E),
                  //   fontSize: 16,
                  //   fontFamily: 'Poppins',
                  //   fontWeight: FontWeight.w600,
                  //   height: 0,
                  // ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
*/