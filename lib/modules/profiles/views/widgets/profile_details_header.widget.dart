import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import '../../models/employee_profile.model.dart';

class EmployeeDetailsHeader extends StatelessWidget {
  const EmployeeDetailsHeader({
    super.key,
    required this.employee,
  });

  final EmployeeProfileModel? employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.s300,
      clipBehavior: Clip.antiAlias,
      width: LayoutService.getWidth(context),
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage(AppImages.appbarBackground),
            fit: BoxFit.fill,
            opacity: 0.4),
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes.s28),
            bottomRight: Radius.circular(AppSizes.s28)),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'EMPLOYEE INFO',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(AppSizes.s10),
              child: InkWell(
                onTap: () => context.pop(),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2)),
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: AppSizes.s18,
                  ),
                ),
              ),
            ),
          ),
          gapH12,
          employee?.avatar != null
              ? CircleAvatar(
                  radius: AppSizes.s50,
                  child: Center(
                    child: CachedNetworkImage(
                        imageUrl: employee!.avatar!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const ShimmerAnimatedLoading(
                              circularRaduis: AppSizes.s50,
                            ),
                        errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                            )),
                  ),
                )
              : CircleAvatar(
                  radius: AppSizes.s50,
                  child: Image.asset(
                    AppImages.profilePlaceHolder,
                    fit: BoxFit.cover,
                  ),
                ),
          gapH12,
          Text(
            employee?.name ?? '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: AppSizes.s20,
                fontWeight: FontWeight.w500),
          ),
          Text(
            employee?.jobTitle ?? '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: AppSizes.s14,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
