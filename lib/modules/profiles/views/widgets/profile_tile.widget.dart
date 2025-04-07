import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String? trailingTitle;
  final bool? isTitleOnly;
  final Widget? icon;
  final double? marginBottom;
  const ProfileTile({
    super.key,
    this.icon,
    this.marginBottom,
    this.trailingTitle,
    this.isTitleOnly = true,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? AppSizes.s12),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s12, horizontal: AppSizes.s10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.s8),
          border: Border.all(color: Colors.grey.withOpacity(0.1))),
      child: isTitleOnly == true
          ? Center(
              child: Text(title),
            )
          : icon != null && trailingTitle != null
              ? Row(
                  children: [
                    icon ?? const SizedBox.shrink(),
                    gapW4,
                    Text(title),
                    gapW12,
                    Expanded(
                      child: AutoSizeText(
                        trailingTitle ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
    );
  }
}
