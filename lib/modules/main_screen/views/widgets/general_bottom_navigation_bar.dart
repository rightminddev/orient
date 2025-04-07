// import 'package:employees/constants/app_images.dart';
// import 'package:employees/constants/app_strings.dart';
// import 'package:employees/routing/app_router.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../constants/app_sizes.dart';

// enum NavbarPages { home, requests, fingerprint, notifications, more }

// class GeneralBottomNavBar extends StatelessWidget {
//   final NavbarPages currentNavbarPage;
//   const GeneralBottomNavBar({super.key, required this.currentNavbarPage});

//   @override
//   Widget build(BuildContext context) {
//     Future<void> onItemTapped(NavbarPages page) async {
//       // Perform actions based on the tapped item index
//       switch (page) {
//         case NavbarPages.home:
//           if (currentNavbarPage == NavbarPages.home) return;
//           await context.pushNamed(AppRoutes.home.name);
//           return;
//         case NavbarPages.fingerprint:
//           if (currentNavbarPage == NavbarPages.fingerprint) return;
//           await context.pushNamed(AppRoutes.fingerprint.name);
//           return;
//         case NavbarPages.requests:
//           if (currentNavbarPage == NavbarPages.requests) return;
//           await context.pushNamed(AppRoutes.requests.name);
//           return;
//         case NavbarPages.notifications:
//           if (currentNavbarPage == NavbarPages.notifications) return;
//           await context.pushNamed(AppRoutes.notifications.name);
//           return;
//         case NavbarPages.more:
//           if (currentNavbarPage == NavbarPages.more) return;
//           await context.pushNamed(AppRoutes.home.name);
//           return;
//         default:
//           await context.pushNamed(AppRoutes.home.name);
//           return;
//       }
//     }

//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: AppSizes.s10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(AppSizes.s20),
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(AppSizes.s26),
//             topLeft: Radius.circular(AppSizes.s26)),
//         child: BottomAppBar(
//           color: Colors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               BottomNavItem(
//                 icon: AppImages.homeBottomBarIcon,
//                 label: AppStrings.home,
//                 isSelected: currentNavbarPage == NavbarPages.home,
//                 onTap: () async => await onItemTapped(NavbarPages.home),
//               ),
//               BottomNavItem(
//                 icon: AppImages.requestsBottomBarIcon,
//                 label: AppStrings.requests,
//                 isSelected: currentNavbarPage == NavbarPages.requests,
//                 onTap: () async => await onItemTapped(NavbarPages.requests),
//               ),
//               BottomNavItem(
//                 icon: AppImages.fingerprintBottomBarIcon,
//                 label: AppStrings.fingerprint,
//                 isSelected: currentNavbarPage == NavbarPages.fingerprint,
//                 onTap: () async => await onItemTapped(NavbarPages.fingerprint),
//               ),
//               BottomNavItem(
//                 icon: AppImages.notificationBottomBarIcon,
//                 label: AppStrings.notifications,
//                 isSelected: currentNavbarPage == NavbarPages.notifications,
//                 onTap: () async =>
//                     await onItemTapped(NavbarPages.notifications),
//               ),
//               BottomNavItem(
//                 icon: AppImages.moreBottomBarIcon,
//                 label: AppStrings.more,
//                 isSelected: currentNavbarPage == NavbarPages.more,
//                 onTap: () async => await onItemTapped(NavbarPages.more),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BottomNavItem extends StatelessWidget {
//   final String icon;
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const BottomNavItem({
//     super.key,
//     required this.icon,
//     required this.label,
//     this.isSelected = false,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             icon,
//             height: AppSizes.s20,
//             width: AppSizes.s20,
//             colorFilter: ColorFilter.mode(
//               isSelected
//                   ? Theme.of(context).colorScheme.secondary
//                   : const Color(0xFF676D75),
//               BlendMode.srcIn,
//             ),
//           ),
//           const SizedBox(height: AppSizes.s6),
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: AppSizes.s10,
//               letterSpacing: 1,
//               color: isSelected
//                   ? Theme.of(context).colorScheme.secondary
//                   : const Color(0xFF676D75),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
