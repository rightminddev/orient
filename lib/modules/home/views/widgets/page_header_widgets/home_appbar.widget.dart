import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common_modules_widgets/vocation_list.widget.dart';
import '../../../../../constants/app_images.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../general_services/app_theme.service.dart';
import '../../../../../models/request.model.dart';
import '../../../../../models/settings/user_settings.model.dart';
import '../../../../../models/settings/user_settings_2.model.dart';
import '../../../../../routing/app_router.dart';
import '../../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'notification_icon.widget.dart';

class HomeAppbarWidget extends StatelessWidget {
  final bool? isExpanded;
  final UserSettingsModel? userSettings;
  final UserSettings2Model? user2Settings;
  final List<RequestModel>? requests;
  const HomeAppbarWidget(
      {super.key,
      this.requests,
      this.isExpanded = true,
      this.userSettings,
      this.user2Settings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage(AppImages.appbarBackground),
            fit: BoxFit.fill,
            opacity: 0.4),
        color: Theme.of(context).colorScheme.primary,
        borderRadius: isExpanded == true
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.s32),
                bottomRight: Radius.circular(AppSizes.s32))
            : null,
      ),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: AppSizes.s16,
          right: AppSizes.s16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            gapH18,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async => context.pushNamed(
                      AppRoutes.personalProfile.name,
                      pathParameters: {'lang': context.locale.languageCode}),
                  child: (userSettings?.photo == null ||
                          (userSettings?.photo?.isEmpty == true))
                      ? Container(
                          width: AppSizes.s40,
                          height: AppSizes.s40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: AppSizes.s28,
                          ),
                        )
                      : CircleAvatar(
                          radius: AppSizes.s22,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: userSettings!.photo!,
                              placeholder: (context, url) =>
                                  const ShimmerAnimatedLoading(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: AppSizes.s32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),
                gapW12,
                userSettings == null
                    ? const ShimmerAnimatedLoading(
                        height: AppSizes.s32,
                        width: AppSizes.s50,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(userSettings?.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: AppThemeService.colorPalette
                                          .quinaryTextColor.color)),
                          AutoSizeText(AppStrings.niceToMeetYou.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      letterSpacing: null,
                                      fontWeight: FontWeight.normal)),
                        ],
                      ),
                const Spacer(),
                NotificationIcon(
                  hasNewNotifications: true,
                  numOfUnreadNotifications:
                      userSettings?.newNotificationCount ?? 0,
                  // onTap: () async => await context.pushNamed(
                  //     AppRoutes.rewardsAndPenalties.name,
                  //     extra: {'employeeName': null, 'employeeId': null},
                  //     pathParameters: {'lang': context.locale.languageCode})
                  onTap: () => context.pushNamed(AppRoutes.employeesList.name,
                      pathParameters: {'lang': context.locale.languageCode}),
                )
              ],
            ),
            gapH32,
            if (isExpanded == true)
              VacationListWidget(
                userSettings: user2Settings,
                requests: requests,
              ),
          ],
        ),
      ),
    );
  }
}
