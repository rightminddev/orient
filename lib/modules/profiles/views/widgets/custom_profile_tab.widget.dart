import 'package:flutter/material.dart';

import '../../../../constants/app_sizes.dart';

class CustomProfileTabWidget extends StatelessWidget {
  final String tabTitle;
  const CustomProfileTabWidget({
    super.key,
    required this.tabTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.s6),
        child: Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tabTitle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ));
  }
}
