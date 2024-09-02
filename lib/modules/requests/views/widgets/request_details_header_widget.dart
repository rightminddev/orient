import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/date.service.dart';
import '../../../../general_services/layout.service.dart';
import '../../../../general_services/settings.service.dart';
import '../../../../models/request.model.dart';
import '../../../../services/requests.services.dart';

class RequestDetailsHeaderWidget extends StatelessWidget {
  final double? height;
  final RequestModel request;
  const RequestDetailsHeaderWidget(
      {super.key, required this.request, required this.height});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xff9C4995);
    return Container(
      height: height,
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
              AppSettingsService.getRequestTitleFromGenenralSettings(
                      context: context, requestId: request.typeid.toString()) ??
                  '',
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
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.only(left: AppSizes.s12, right: AppSizes.s12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // status widget
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(AppSizes.s10)),
                      height: AppSizes.s80,
                      width: AppSizes.s50,
                      child: Center(
                        child: RequestsServices.getRequestsStatusIcon(
                            context: context,
                            status: request.status?.value,
                            iconColor: Colors.white,
                            iconSize: AppSizes.s30),
                      ),
                    )
                  ],
                ),
                gapW8,
                // info widget
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      spacing: AppSizes.s5,
                      runSpacing: AppSizes.s5,
                      clipBehavior: Clip.antiAlias,
                      alignment: WrapAlignment.center,
                      children: [
                        //'20 DEC 2024',
                        InfoTileWidget(
                          imgPath: Icons.calendar_month,
                          title: DateService.formatDate(request.createdAt,
                                  format: 'dd MMM yyyy') ??
                              '-',
                          isFullRow: true,
                          trailing: InfoTileWidget(
                              background: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                              imgPath: Icons.access_time,
                              title: '${request.duration} DAYS'),
                        ),

                        InfoTileWidget(
                            imgPath: Icons.person_2_outlined,
                            title: request.user?.name ??
                                request.username ??
                                request.user?.username ??
                                '-',
                            isHighLight: true),
                        InfoTileWidget(
                            imgPath: Icons.category_outlined,
                            title: request.departmentId.toString()),
                        // InfoTileWidget(
                        //     imgPath: Icons.category_outlined,
                        //     title: AppSettingsService
                        //             .getRequestTitleFromGenenralSettings(
                        //                 context: context,
                        //                 requestId:
                        //                     request.typeid?.id.toString()) ??
                        //         '-'),
                        if (request.moneyValue != null &&
                            (request.moneyValue! > 0))
                          InfoTileWidget(
                              imgPath: Icons.attach_money_outlined,
                              title: 'AMOUNT: ${request.moneyValue} EGP'),
                        if (request.files != null &&
                            (request.files?.isNotEmpty ?? false))
                          const InfoTileWidget(
                              imgPath: Icons.file_download_outlined,
                              title: 'DOWNLOAD FILE'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class InfoTileWidget extends StatelessWidget {
  final IconData imgPath;
  final Color? background;
  final Color? imgColor;
  final String title;
  final bool? isFullRow;
  final bool? isHighLight;
  final Widget? trailing;
  const InfoTileWidget(
      {super.key,
      this.isHighLight = false,
      this.isFullRow = false,
      required this.imgPath,
      required this.title,
      this.background = const Color(0xff2C376C),
      this.trailing,
      this.imgColor = const Color(0xff9C4995)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullRow == false
          ? (LayoutService.getWidth(context) - AppSizes.s88) / 2
          : null,
      decoration: BoxDecoration(
          color: isHighLight == true ? imgColor : background,
          borderRadius: BorderRadius.circular(AppSizes.s6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.s6, vertical: AppSizes.s6),
              child: Row(
                children: [
                  Icon(
                    imgPath,
                    color: isHighLight == true ? Colors.white : imgColor,
                  ),
                  gapW12,
                  Expanded(
                    child: AutoSizeText(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.s10,
                          fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isFullRow == true && trailing != null) trailing!
        ],
      ),
    );
  }
}
