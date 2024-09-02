import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_sizes.dart';
import '../general_services/date.service.dart';
import '../general_services/settings.service.dart';
import '../models/request.model.dart';
import '../models/settings/user_settings.model.dart';
import '../routing/app_router.dart';
import '../services/requests.services.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;
  final GetRequestsTypes? reqType;

  const RequestCard({
    required this.request,
    this.reqType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.s16),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s14, horizontal: AppSizes.s16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.s10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 1,
          )
        ],
      ),
      child: InkWell(
        onTap: () async => reqType == null
            ? await context.pushNamed(AppRoutes.requestDetails.name,
                extra: request,
                pathParameters: {'lang': context.locale.languageCode})
            : await context.pushNamed(AppRoutes.requestDetails.name,
                extra: request,
                pathParameters: {
                    'type': reqType!.name,
                    'lang': context.locale.languageCode
                  }),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  AppSettingsService.getRequestTitleFromGenenralSettings(
                          context: context,
                          requestId: request.typeid?.toString()) ??
                      '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppSizes.s14,
                    letterSpacing: 0.75,
                    color: Color(0xFF09051C),
                    height: 1.1,
                  ),
                ),
                gapH4,
                Opacity(
                  opacity: 0.5,
                  child: AutoSizeText(
                    '${DateService.formatDate(request.dateFrom)} : ${DateService.formatDate(request.dateTo)} (${request.duration} days)',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizes.s12,
                      letterSpacing: 0.5,
                      color: Color(0xFF3B3B3B),
                    ),
                  ),
                ),
                if (request.username != null &&
                    request.username?.isNotEmpty == true &&
                    request.userId != null &&
                    request.userId !=
                        (AppSettingsService.getSettings(
                                settingsType: SettingsType.userSettings,
                                context: context) as UserSettingsModel)
                            .userId) ...[
                  gapH4,
                  AutoSizeText(
                    request.username!,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizes.s12,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ]
              ],
            ),
            const Spacer(),
            RequestsServices.getRequestsStatusIcon(
                context: context, status: request.status?.value),
          ],
        ),
      ),
    );
  }
}
