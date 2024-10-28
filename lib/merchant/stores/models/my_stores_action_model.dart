import 'package:orient/constants/settings/app_icons.dart';

class MyStoresActionModel {
  final String icon;
  final String title;
  final String subtitle;
  final String goToLocation;

  MyStoresActionModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.goToLocation,
  });
}

List<MyStoresActionModel> getMyStoresAction = [
  MyStoresActionModel(
      icon: AppIcons.bag,
      title: 'View orders',
      subtitle: 'The orders requested from you through the application',
      goToLocation: ''),
  MyStoresActionModel(
      icon: AppIcons.availableShoppingCart,
      title: 'Availability of products',
      subtitle: 'Select the products you have available for sale online',
      goToLocation: ''),
  MyStoresActionModel(
      icon: AppIcons.addReqShoppingCart,
      title: 'Add request',
      subtitle: 'Order products for your store from the company\'s stores',
      goToLocation: ''),
  MyStoresActionModel(
      icon: AppIcons.notes,
      title: 'Get my invoices',
      subtitle: 'View your previous Invoices with Orient',
      goToLocation: ''),
  MyStoresActionModel(
      icon: AppIcons.edit,
      title: 'Edit store',
      subtitle: 'Edit this store\'s data',
      goToLocation: ''),
];
