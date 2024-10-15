import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/merchant/stores/models/my_stores_action_model.dart';

import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../components/gradient_bg_image.dart';
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
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              children: getMyStoresAction.map((element) {
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(element.goToLocation);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 42),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 14.10,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          element.icon,
                          colorFilter: ColorFilter.mode(
                            Color(AppColors.oc2),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(height: AppSizes.s8),
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
                        SizedBox(height: AppSizes.s8),
                        Text(
                          element.subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF1B1B1B),
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0.13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
