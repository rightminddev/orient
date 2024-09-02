import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_sizes.dart';
import '../general_services/layout.service.dart';
import '../models/request.model.dart';
import '../models/settings/user_settings_2.model.dart';
import '../routing/app_router.dart';
import '../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class VacationListWidget extends StatelessWidget {
  final bool? isInRequestsPage;
  final double? paddingBetweenVocations;
  final double? sectionPadding;
  final UserSettings2Model? userSettings;
  final List<RequestModel>? requests;

  const VacationListWidget(
      {super.key,
      this.requests,
      required this.userSettings,
      this.paddingBetweenVocations = AppSizes.s12,
      this.sectionPadding = AppSizes.s32,
      this.isInRequestsPage = false});

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, Balance>> vacationBalance =
        userSettings?.balance?.entries.toList() ?? [];
    List<Widget> vacationWidgets = vacationBalance
        .map((entry) => Padding(
              padding: EdgeInsets.only(right: paddingBetweenVocations!),
              child: VacationCard(
                vocation: entry,
                sectionPadding: sectionPadding,
                paddingBetweenVocations: paddingBetweenVocations,
              ),
            ))
        .toList();
    if (requests != null && requests?.isNotEmpty == true) {
      vacationWidgets.insert(
        0,
        Padding(
            padding: EdgeInsets.only(right: paddingBetweenVocations!),
            child: InkWell(
              onTap: () async => await context.pushNamed(
                  AppRoutes.requestsCalendar.name,
                  pathParameters: {
                    'type': 'mine',
                    'lang': context.locale.languageCode
                  },
                  extra: requests),
              child: Container(
                width: (LayoutService.getWidth(context) -
                        (AppSizes.s32 +
                            ((paddingBetweenVocations ?? AppSizes.s0) * 2))) /
                    3,
                height: AppSizes.s120,
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.s14, horizontal: AppSizes.s6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(AppSizes.s8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                      size: AppSizes.s32,
                    ),
                    gapH18,
                    Expanded(
                      child: AutoSizeText('VIEW ON CALENDAR',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge),
                    )
                  ],
                ),
              ),
            )),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s32),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: userSettings == null
              ? List.generate(
                  3,
                  (index) => Padding(
                      padding: EdgeInsets.only(right: paddingBetweenVocations!),
                      child: ShimmerAnimatedLoading(
                        width: (LayoutService.getWidth(context) -
                                (AppSizes.s32 +
                                    ((paddingBetweenVocations ?? AppSizes.s0) *
                                        3))) /
                            3,
                        height: AppSizes.s120,
                      )))
              : vacationWidgets,
        ),
      ),
    );
  }
}

class VacationCard extends StatelessWidget {
  final bool? isInRequestsPage;
  final double? sectionPadding;
  final MapEntry<String, Balance> vocation;
  final double? paddingBetweenVocations;
  final Widget? customBody;
  final String? userId;

  const VacationCard(
      {super.key,
      this.isInRequestsPage = false,
      this.sectionPadding,
      required this.vocation,
      this.paddingBetweenVocations,
      this.userId,
      this.customBody});

  @override
  Widget build(BuildContext context) {
    bool isTaken = vocation.value.max == -1 && vocation.value.available == -1;
    return InkWell(
      onTap: () async => isInRequestsPage == false
          ? await context.pushNamed(AppRoutes.requestsById.name,
              pathParameters: {
                  'type': 'mine',
                  'id': vocation.key,
                  'lang': context.locale.languageCode
                },
              extra: {
                  'offset': const Offset(1.0, 0.0),
                  'userId': userId
                })
          // if the old page is request page , so i dont need to pass type as path parameter becouse the current location is already contain type parameter
          : await context.pushNamed(AppRoutes.requestsById.name,
              pathParameters: {
                  'id': vocation.key,
                  'lang': context.locale.languageCode
                },
              extra: {
                  'userId': userId
                }),
      child: Container(
        width: (LayoutService.getWidth(context) -
                (AppSizes.s32 +
                    ((paddingBetweenVocations ?? AppSizes.s0) * 2))) /
            3,
        height: AppSizes.s120,
        padding: const EdgeInsets.symmetric(
            vertical: AppSizes.s14, horizontal: AppSizes.s6),
        decoration: BoxDecoration(
          color: const Color(0xff2C376C),
          borderRadius: BorderRadius.circular(AppSizes.s8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              vocation.value.title ?? '-',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            gapH18,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    isTaken ? 'Taken' : 'Remaining',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  gapH4,
                  AutoSizeText(
                      '${isTaken ? (vocation.value.take?.toString() ?? '0') : (vocation.value.available?.toString() ?? '0')} DAYS',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.s20,
                          )),
                  gapH4,
                  if (vocation.value.max != -1 &&
                      vocation.value.available != -1)
                    AutoSizeText(
                      'FROM ${(vocation.value.max?.toString() ?? '0')}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        height: 1.0,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
