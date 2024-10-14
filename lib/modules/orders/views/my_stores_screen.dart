import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/utils/cached_network_image_widget.dart';
import 'package:orient/utils/media_query_values.dart';

import '../models/store_model.dart';

class MyStoresScreen extends StatefulWidget {
  const MyStoresScreen({super.key});

  @override
  State<MyStoresScreen> createState() => _MyStoresScreenState();
}

class _MyStoresScreenState extends State<MyStoresScreen> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   controller: controller,
      appBar: AppBar(
        title: Text(
          AppStrings.myStores.tr(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Color(0xFF224982),
              ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          // fontSize: 16,
          // fontFamily: 'Poppins',
          // fontWeight: FontWeight.w700,
          // height: 0.09,
          // letterSpacing: 1,
        ),
      ),
      // bodyWithoutScroll: false,

      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.s24, vertical: AppSizes.s24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, 0),
            // radius: 0.54,
            colors: [
              Color(0xFFFF007A).withOpacity(0.02),
              Color(0xFF00A1FF).withOpacity(0.02)
            ],
          ),
        ),
        child: Column(
          children: storeModelList.map((element) {
            return StoreItemWidget(storeModel: element);
          }).toList(),
        ),
      ),
    );
  }
}

class StoreItemWidget extends StatelessWidget {
  final StoreModel storeModel;
  const StoreItemWidget({super.key, required this.storeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s18, horizontal: AppSizes.s16),
      decoration: ShapeDecoration(
        color: AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CachedNetWokImageWidget(
            url: storeModel.imageUrl,
            width: context.width * 0.2,
            height: context.width * 0.2,
            radius: context.width * 0.1,
          ),
          const SizedBox(width: AppSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeModel.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppThemeService
                            .colorPalette.secondaryTextColor.color,
                      ),
                  //  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Color(0xFFE6007E),
                  //   fontSize: 16,
                  //   fontFamily: 'Poppins',
                  //   fontWeight: FontWeight.w600,
                  //   height: 0,
                  // ),
                ),
                Text(
                  '${storeModel.city}, ${storeModel.country}',
                  style: Theme.of(context).textTheme.displaySmall,
                  //  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Color(0xFFE6007E),
                  //   fontSize: 16,
                  //   fontFamily: 'Poppins',
                  //   fontWeight: FontWeight.w600,
                  //   height: 0,
                  // ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
