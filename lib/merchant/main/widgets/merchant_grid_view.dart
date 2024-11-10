import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/painter/models/gride_view_item_model.dart';
import 'package:orient/routing/app_router.dart';

import '../../../../painter/painter/views/widgets/painter_gride_view_item.dart';

class MerchantGridView extends StatelessWidget {
  const MerchantGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: AppSizes.s90, right: 24, left: 24),
      sliver: SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 65,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            ...merchantGrideItems.map((item) {
              return GestureDetector(
                onTap: () {
                  if (item.title == AppStrings.myStores.tr()) {
                    // TODO
                    context.goNamed(AppRoutes.merchantStoresScreen.name,
                        extra: const Offset(1.0, 0.0),
                        pathParameters: {'lang': context.locale.languageCode});
                  } else {
                    context.pushNamed(AppRoutes.addStore.name,
                        extra: const Offset(1.0, 0.0),
                        pathParameters: {'lang': context.locale.languageCode});
                  }
                },
                child: PainterGridViewItem(
                  itemModel: item,
                ),
              );
            })
          ]),
    );
  }
}
