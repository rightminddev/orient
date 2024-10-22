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
    title: 'VIEW\nORDERS',
    subtitle: 'The orders requested from you through the application',
    goToLocation: AppRoutes.merchantStoreOrders.name,
    pathParameters: {},
    queryParameters: {},
  ),
  MyStoresActionModel(
    icon: AppIcons.availableShoppingCart,
    title: 'AVAILABILITY OF PRODUCTS',
    subtitle: 'Select the products you have available for sale online',
    goToLocation: AppRoutes.storeAvailableProducts.name,
    pathParameters: {},
    queryParameters: {"isInAvailable": "true"},
  ),
  MyStoresActionModel(
    icon: AppIcons.addReqShoppingCart,
    title: 'ADD\nREQUEST',
    subtitle: 'Order products for your store from the company\'s stores',
    goToLocation: AppRoutes.storeAvailableProducts.name,
    pathParameters: {},
    queryParameters: {"isInAvailable": "false"},
  ),
  MyStoresActionModel(
    icon: AppIcons.notes,
    title: 'GET MY INVOICES',
    subtitle: 'View your previous Invoices with Orient',
    goToLocation: '',
    pathParameters: {},
    queryParameters: {},
  ),
  MyStoresActionModel(
    icon: AppIcons.edit,
    title: 'EDIT\nSTORE',
    subtitle: 'Edit this store\'s data',
    goToLocation: AppRoutes.editStore.name,
    pathParameters: {},
    queryParameters: {},
  ),
];
