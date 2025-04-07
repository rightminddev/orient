import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../models/payroll.model.dart';
import '../../services/payroll.service.dart';

class PayrollDetailsHeaderWidget extends StatelessWidget {
  final PayrollModel? payroll;
  const PayrollDetailsHeaderWidget({super.key, required this.payroll});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              PayrollService.formatDate(payroll?.dateTo) ?? '',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payroll?.user?.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.s20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
                gapH12,
                if (payroll?.netPayable != null)
                  PayrollHeaderTileWidget(
                      title: 'Net Salary',
                      subTitle:
                          '${payroll!.netPayable!.toString()} ${payroll?.currency ?? ''}',
                      icon: Icons.attach_money_outlined),
                gapH12,
                if (payroll?.dateTo != null)
                  PayrollHeaderTileWidget(
                      title: 'Date',
                      subTitle:
                          PayrollService.formatDate(payroll?.dateTo) ?? '',
                      icon: Icons.calendar_month_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PayrollHeaderTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const PayrollHeaderTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: LayoutService.getWidth(context) * 0.8,
      decoration: BoxDecoration(
          color: const Color(0xff2C376C),
          borderRadius: BorderRadius.circular(AppSizes.s6)),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s6, vertical: AppSizes.s12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          gapW12,
          Expanded(
            child: AutoSizeText(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.s10,
                  fontWeight: FontWeight.w400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              subTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.s10,
                  fontWeight: FontWeight.w400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
