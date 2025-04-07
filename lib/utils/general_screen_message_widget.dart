import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/app_sizes.dart';
import '../general_services/settings.service.dart';

class GeneralScreenMessageWidget extends StatelessWidget {
  /// current Screen route
  final String screenId;
  final int? maxTextLines;
  const GeneralScreenMessageWidget(
      {super.key, this.maxTextLines = 3, required this.screenId});

  @override
  Widget build(BuildContext context) {
    final message = AppSettingsService.getGeneralScreenMessageByScreenId(
        screenId: screenId, context: context);
    return message != null
        ? Padding(
            padding: const EdgeInsets.only(
                left: AppSizes.s12, right: AppSizes.s12, bottom: AppSizes.s16),
            child: AutoSizeText(
              message,
              maxLines: maxTextLines,
              style: const TextStyle(
                  color: Color(0xff404040),
                  fontSize: AppSizes.s14,
                  fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        : const SizedBox.shrink();
  }
}
