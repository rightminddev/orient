import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common_modules_widgets/request_card.widget.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../models/request.model.dart';
import '../../../../../routing/app_router.dart';
import '../../../../../services/requests.services.dart';

/// Used to get requests for current user ( my requests - my team requests - other Departments requests
class RequestsWidget extends StatelessWidget {
  final List<RequestModel> requests;
  final GetRequestsTypes requestType;
  const RequestsWidget(
      {super.key, required this.requests, required this.requestType});

  @override
  Widget build(BuildContext context) {
    /// get request type String from GetRequestsTypes
    String getRequestsTypeStr() {
      switch (requestType) {
        case GetRequestsTypes.mine:
          return AppStrings.mineRequests.tr();
        case GetRequestsTypes.myTeam:
          return AppStrings.teamRequests.tr();
        case GetRequestsTypes.otherDepartment:
          return AppStrings.otherDepartmentRequests.tr();
        case GetRequestsTypes.allCompany:
          return AppStrings.allCompanyRequests.tr();
      }
    }

    /// navigate to requests screens with passing the kind of the wanted requests
    Future<void> pushToRequestsScreenWithRequestsType(
        {required GetRequestsTypes reqType,
        required BuildContext context}) async {
      await context.pushNamed(AppRoutes.requests.name, pathParameters: {
        'type': reqType.name,
        'lang': context.locale.languageCode
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(getRequestsTypeStr(),
                  style: Theme.of(context).textTheme.bodyMedium),
              TextButton(
                onPressed: () async =>
                    await pushToRequestsScreenWithRequestsType(
                        context: context, reqType: requestType),
                child: AutoSizeText(AppStrings.viewAll.tr(),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
          gapH16,
          ...requests.map(
            (req) => RequestCard(
              request: req,
              reqType: requestType,
            ),
          )
        ],
      ),
    );
  }
}
