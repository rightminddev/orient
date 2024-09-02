import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../../../models/settings/user_settings_2.model.dart';
import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import '../../../../utils/modal_sheet_helper.dart';
import 'requests_by_balance_empid_modal.widget.dart';

class ProfileBalanceWidget extends StatelessWidget {
  final double? paddingBetweenVocations;
  final double? sectionPadding;
  final List<Balance>? balance;
  final String? employeeId;
  const ProfileBalanceWidget(
      {super.key,
      this.paddingBetweenVocations = AppSizes.s12,
      this.sectionPadding = AppSizes.s32,
      required this.employeeId,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    if (balance == null && balance?.isEmpty == true) {
      return const SizedBox.shrink();
    }

    List<Widget> balanceWidgets = balance!
        .map((bal) => Padding(
              padding: EdgeInsets.only(right: paddingBetweenVocations!),
              child: BalanceCard(
                balance: bal,
                sectionPadding: sectionPadding,
                paddingBetweenVocations: paddingBetweenVocations,
                employeeId: employeeId,
              ),
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s32),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: balance == null
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
              : balanceWidgets,
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final bool? isInRequestsPage;
  final double? sectionPadding;
  final Balance balance;
  final double? paddingBetweenVocations;
  final Widget? customBody;
  final String? employeeId;

  const BalanceCard(
      {super.key,
      this.isInRequestsPage = false,
      this.sectionPadding,
      required this.balance,
      this.paddingBetweenVocations,
      this.employeeId,
      this.customBody});

  @override
  Widget build(BuildContext context) {
    bool isTaken = balance.max == -1 && balance.available == -1;
    const mainTextStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: AppSizes.s12,
      height: 1.0,
      color: Colors.white,
    );
    return InkWell(
      //TODO: ADD REAL BALANCE ID AFTER ADDED FROM BACKEND
      onTap: employeeId != null && employeeId?.isNotEmpty == true
          ? () async => await ModalSheetHelper.showModalSheet(
              context: context,
              title: 'Requests',
              modalContent: RequestsByBalanceAndEmployeeIdModal(
                  employeeId: employeeId!, requestTypeId: '1'),
              height: LayoutService.getHeight(context) * 0.7)
          : null,
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
              balance.title ?? '-',
              textAlign: TextAlign.center,
              style: mainTextStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            gapH18,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(isTaken ? 'Taken' : 'Remaining',
                      textAlign: TextAlign.center, style: mainTextStyle),
                  gapH4,
                  AutoSizeText(
                      '${isTaken ? (balance.take?.toString() ?? '0') : (balance.available?.toString() ?? '0')} DAYS',
                      textAlign: TextAlign.center,
                      style: mainTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.s20,
                      )),
                  gapH4,
                  if (balance.max != -1 && balance.available != -1)
                    AutoSizeText(
                      'FROM ${(balance.max?.toString() ?? '0')}',
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
