// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:orient/constants/app_colors.dart';
// import 'package:orient/constants/app_sizes.dart';
// import 'package:orient/constants/app_strings.dart';
// import 'package:orient/general_services/app_theme.service.dart';
// import 'package:orient/utils/base_page/mobile.header.dart';
// import 'package:orient/utils/cached_network_image_widget.dart';
// import 'package:orient/utils/media_query_values.dart';

// import '../../../utils/base_page/mobile.scaffold.dart';
// import '../models/order_model.dart';
// import '../../../models/stores/store_model.dart';

// class MyOrdersScreen extends StatefulWidget {
//   const MyOrdersScreen({super.key});

//   @override
//   State<MyOrdersScreen> createState() => _MyOrdersScreenState();
// }

// class _MyOrdersScreenState extends State<MyOrdersScreen> {
//   final ScrollController controller = ScrollController();

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CoreMobileScaffold(
//       controller: controller,
//       appBar: AppBar(
//         title: AutoSizeText(
//           AppStrings.myRequests,
//           style:
//               Theme.of(context).textTheme.displayLarge?.copyWith(height: 1.2),
//           textAlign: TextAlign.center,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       bodyWithoutScroll: false,
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppSizes.s24, vertical: AppSizes.s36),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment(0.44, 0.38),
//             radius: 0.54,
//             colors: [Color(0xFFFF007A), Color(0xFF00A1FF)],
//           ),
//         ),
//         child: Column(
//           children: orderModelList.map((element) {
//             return OrderItemWidget(orderModel: element);
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// class OrderItemWidget extends StatelessWidget {
//   final OrderModel orderModel;
//   const OrderItemWidget({super.key, required this.orderModel});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//           vertical: AppSizes.s18, horizontal: AppSizes.s16),
//       decoration: ShapeDecoration(
//         color: AppThemeService.colorPalette.appBarBackgroundColor.color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         shadows: const [
//           BoxShadow(
//             color: Color(0x0C000000),
//             blurRadius: 10,
//             offset: Offset(0, 1),
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: AppSizes.s12),
//           Expanded(
//             child: Column(
//               children: [
//                 Text(
//                   orderModel.date,
//                   style: Theme.of(context).textTheme.headlineSmall,
//                   //  textAlign: TextAlign.center,
//                   // style: TextStyle(
//                   //   color: Color(0xFFE6007E),
//                   //   fontSize: 16,
//                   //   fontFamily: 'Poppins',
//                   //   fontWeight: FontWeight.w600,
//                   //   height: 0,
//                   // ),
//                 ),
//                 Text(
//                   orderModel.amount.toString(),
//                   style: Theme.of(context).textTheme.displaySmall,
//                   //  textAlign: TextAlign.center,
//                   // style: TextStyle(
//                   //   color: Color(0xFFE6007E),
//                   //   fontSize: 16,
//                   //   fontFamily: 'Poppins',
//                   //   fontWeight: FontWeight.w600,
//                   //   height: 0,
//                   // ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
