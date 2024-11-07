import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/painter/views/widgets/painter_notification_list_view_item.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: GradientBgImage(
          padding: EdgeInsets.zero,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 90,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          AppStrings.notificationsCenter.tr().toUpperCase(),
                          style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                            onPressed: (){}
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.s20,),
                  Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index)=> const SizedBox(height: 18,),
                        shrinkWrap: true,
                        itemCount: 8,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return const PainterNotificationListViewItem();
                        },
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
