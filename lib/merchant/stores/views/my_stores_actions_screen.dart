import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      pageContext: context,
      title: widget.storeModel.name ?? '',
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
                    onTap: () async {
                      //TODO: update this
                      // await context.pushNamed(AppRoutes.storeActions.name,
                      //     extra: element,
                      //     pathParameters: {
                      //       'lang': context.locale.languageCode
                      //     });

                      // available products
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => AvailableProductsScreen(
                      //         storeId: widget.storeModel.id!),
                      //   ),
                      // );

                      // orders
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         MyOrdersScreen(storeId: widget.storeModel.id!),
                      //   ),
                      // );
                      // edit store
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => CreateEditStoreScreen(
                      //         storeModel: widget.storeModel),
                      //   ),
                      // );

                      // ADD REQUEST
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AvailableProductsScreen(
                            storeId: widget.storeModel.id!,
                            isInAvailable: false,
                          ),
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
