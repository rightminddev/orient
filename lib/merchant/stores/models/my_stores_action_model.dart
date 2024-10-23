import 'package:easy_localization/easy_localization.dart';
import 'package:orient/app.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/routing/app_router.dart';

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
    title: AppStrings.viewOrders.tr().toUpperCase(),
    subtitle: AppStrings.theOrdersRequestedFromYouThroughTheApplication.tr(),
    goToLocation: AppRoutes.merchantStoreOrders.name,
    pathParameters: {},
    queryParameters: {},
  ),
  MyStoresActionModel(
    icon: AppIcons.availableShoppingCart,
    title: AppStrings.availabilityOfProducts.tr().toUpperCase(),
    subtitle: AppStrings.selectTheProductsYouHaveAvailableForSaleOnline.tr(),
    goToLocation: AppRoutes.storeAvailableProducts.name,
    pathParameters: {},
    queryParameters: {"isInAvailable": "true"},
  ),
  MyStoresActionModel(
    icon: AppIcons.addReqShoppingCart,
    title: AppStrings.addRequestCap.tr(),
    subtitle: AppStrings.orderProductsForYourStoreFromTheCompanysStores.tr(),
    goToLocation: AppRoutes.storeAvailableProducts.name,
    pathParameters: {},
    queryParameters: {"isInAvailable": "false"},
  ),
  MyStoresActionModel(
    icon: AppIcons.notes,
    title: AppStrings.getMyInvoices.tr().toUpperCase(),
    subtitle: AppStrings.viewYourPreviousInvoicesWithOrient.tr(),
    goToLocation: '',
    pathParameters: {},
    queryParameters: {},
  ),
  MyStoresActionModel(
    icon: AppIcons.edit,
    title: AppStrings.editStore.tr().toUpperCase(),
    subtitle: AppStrings.editThisStoresData.tr(),
    goToLocation: AppRoutes.editStore.name,
    pathParameters: {},
    queryParameters: {},
  ),
];
