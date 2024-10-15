import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/merchant/stores/models/my_stores_action_model.dart';
import 'package:orient/merchant/stores/views/available_products_screen.dart';

import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../models/stores/store_model.dart';

class MyStoreActionsScreen extends StatefulWidget {
  final StoreModel storeModel;
  const MyStoreActionsScreen({super.key, required this.storeModel});

  @override
  State<MyStoreActionsScreen> createState() => _MyStoreActionsScreenState();
}

class _MyStoreActionsScreenState extends State<MyStoreActionsScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
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

      title: widget.storeModel.name ?? '',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 18),
              GridView.count(
                primary: false,
                shrinkWrap: true,
                //  padding: const EdgeInsets.symmetric(horizontal: 24),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                // crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: getMyStoresAction.map((element) {
                  return GestureDetector(
                    onTap: () {
                      //TODO: update this
                      // await context.pushNamed(AppRoutes.storeActions.name,
                      //     extra: element,
                      //     pathParameters: {
                      //       'lang': context.locale.languageCode
                      //     });

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AvailableProductsScreen(
                              storeId: widget.storeModel.id!),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      decoration: ShapeDecoration(
                        color: AppThemeService
                            .colorPalette.tertiaryColorBackground.color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0C000000),
                            blurRadius: 14.10,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            element.icon,
                            colorFilter: const ColorFilter.mode(
                              Color(AppColors.oc2),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: AppSizes.s8),
                          Text(
                            element.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppThemeService
                                      .colorPalette.secondaryTextColor.color,
                                ),
                          ),
                          Text(
                            element.subtitle,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppThemeService.colorPalette
                                          .quaternaryTextColor.color,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
