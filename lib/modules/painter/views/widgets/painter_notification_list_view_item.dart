import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/list/views/single_list_details_screen.dart';

class PainterNotificationListViewItem extends StatelessWidget {
  const PainterNotificationListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return SingleListDetailsScreen();
          },
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSizes.s12),
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSizes.s15, vertical: AppSizes.s12),
        decoration: BoxDecoration(
          color: const Color(AppColors.textC5),
          borderRadius: BorderRadius.circular(AppSizes.s15),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                spreadRadius: 0,
                offset: Offset(0, 1),
                blurRadius: 10)
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSizes.s32,
              child: Image.asset(
                AppImages.circleNotification,
              ),
            ),
            gapW8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "10/04/2022 08:15:36 PM".toUpperCase(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff606060)),
                  ),
                  gapH4,
                  Text(
                    "Ramadan Kareem to you all and every year and you"
                        .toUpperCase(),
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0D3B6F)),
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
