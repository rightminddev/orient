import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/merchant/stores/models/my_stores_action_model.dart';
import 'package:orient/routing/app_router.dart';

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

  void goTo({
    required BuildContext context,
    required String page,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
  }) {
    Offset begin = const Offset(1.0, 0.0);
    context.pushNamed(
      page,
      extra: extra != null ? {"begin": begin, ...extra} : begin,
      pathParameters: {
        'lang': context.locale.languageCode,
        ...?pathParameters,
        //"id": (widget.storeModel.id ?? 0).toString()
      },
      queryParameters: queryParameters ?? {},
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Why? ... ${LocalizationService.isArabic(context: context)}");
    print("test --- > ${AppStrings.viewOrders.tr()}");
    return TemplatePage(
      backgroundColor: Colors.white,
      pageContext: context,
      title: context.locale.languageCode == 'en'
          ? widget.storeModel.names?.en ?? ''
          : widget.storeModel.names?.ar ?? '',
      body: GradientBgImage(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 18),
              GridView.count(
                primary: false,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                // crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: getMyStoresAction.map((element) {
                  return GestureDetector(
                    onTap: () {
                      print(" element.title is ${ element.title}");
                      print(" element.title is ${ element.title}");
                      goTo(
                        context: context,
                        page: element.goToLocation,
                        pathParameters: element.goToLocation !=
                                AppRoutes.editStore.name
                            ? {
                                "id": (widget.storeModel.id ?? 0).toString(),
                                ...element.pathParameters,
                              }
                            : element.pathParameters,
                        queryParameters: element.queryParameters,
                        extra: element.goToLocation == AppRoutes.editStore.name
                            ? {"storeModel": widget.storeModel}
                            : null,
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
                            element.title.tr().toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                  color: AppThemeService
                                      .colorPalette.secondaryTextColor.color,
                                ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            element.subtitle.tr(),
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
class MyStoresActionModel {
  final String icon;
  final String title;
  final String subtitle;
  final String goToLocation;
  final Map<String, String> pathParameters;
  final Map<String, dynamic> queryParameters;
  MyStoresActionModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.goToLocation,
    required this.pathParameters,
    required this.queryParameters,
  });
}

List<MyStoresActionModel> getMyStoresAction = [
  MyStoresActionModel(
    icon: AppIcons.bag,
    title: AppStrings.viewOrders,
    subtitle: AppStrings.theOrdersRequestedFromYouThroughTheApplication,
    goToLocation: AppRoutes.merchantStoreOrders.name,
    pathParameters: {},
    queryParameters: {},
  ),
  MyStoresActionModel(
    icon: AppIcons.availableShoppingCart,
    title: AppStrings.availabilityOfProducts,
    subtitle: AppStrings.selectTheProductsYouHaveAvailableForSaleOnline,
    goToLocation: AppRoutes.storeAvailableProducts.name,
    pathParameters: {},
    queryParameters: {"isInAvailable": "true"},
  ),
  MyStoresActionModel(
    icon: AppIcons.addReqShoppingCart,
    title: AppStrings.addRequestCap,
    subtitle: AppStrings.orderProductsForYourStoreFromTheCompanysStores,
    goToLocation: AppRoutes.storeAvailableProducts.name,
    pathParameters: {},
    queryParameters: {"isInAvailable": "false"},
  ),
  MyStoresActionModel(
    icon: AppIcons.notes,
    title: AppStrings.getMyInvoices,
    subtitle: AppStrings.viewYourPreviousInvoicesWithOrient,
    goToLocation: '',
    pathParameters: {},
    queryParameters: {},
  ),
  MyStoresActionModel(
    icon: AppIcons.edit,
    title: AppStrings.editStore,
    subtitle: AppStrings.editThisStoresData,
    goToLocation: AppRoutes.editStore.name,
    pathParameters: {},
    queryParameters: {},
  ),
];