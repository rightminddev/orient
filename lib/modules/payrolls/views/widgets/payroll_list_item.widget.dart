import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';
import '../../models/payroll.model.dart';
import '../../services/payroll.service.dart';

class PayrollListItemWidget extends StatelessWidget {
  final PayrollModel payroll;
  const PayrollListItemWidget({super.key, required this.payroll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async => await context.pushNamed(
              AppRoutes.payrollDetails.name,
              extra: payroll,
              pathParameters: {'lang': context.locale.languageCode}),
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.s14, horizontal: AppSizes.s16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.s10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  offset: const Offset(0, 0),
                  blurRadius: 2.5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.primary,
                  size: AppSizes.s24,
                ),
                gapW8,
                Expanded(
                  child: Text(
                    PayrollService.formatDate(payroll.dateTo) ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.s14,
                      color: Colors.black,
                    ),
                  ),
                ),
                gapW8,
                Container(
                  height: AppSizes.s28,
                  width: AppSizes.s28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary),
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                    size: AppSizes.s18,
                  ),
                ),
              ],
            ),
          ),
        ),
        gapH20
      ],
    );
  }
}
