import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/painters/painter/views/widgets/painter_notification_list_view_item.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            "Notifications center".toUpperCase(),
            style: const TextStyle(
                fontSize: AppSizes.s16,
                fontWeight: FontWeight.w700,
                color: Color(0XFF224982)),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    radius: 0.8,
                    stops: [0.1, 1.0],
                    center: Alignment.centerLeft,
                    colors: [
                      Color.fromRGBO(255, 0, 123, 0.10),
                      Color.fromRGBO(0, 161, 255, 0.10)
                    ])),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    radius: 0.8,
                    stops: [0.1, 1.0],
                    center: Alignment.centerLeft,
                    colors: [
                      Color.fromRGBO(255, 0, 123, 0.10),
                      Color.fromRGBO(0, 161, 255, 0.10)
                    ])),
            child: Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsetsDirectional.only(bottom: AppSizes.s12,start: AppSizes.s24,end: AppSizes.s24),
              itemCount: 8,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return const PainterNotificationListViewItem();
              },
            ))),
      ),
    );
  }
}
