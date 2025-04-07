import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';

class CompanyInfoShrinkedHeader extends StatelessWidget {
  final double notchRadius;
  final double notchedContainerHeight;
  final double notchPadding;
  final String title;
  final String subtitle;
  const CompanyInfoShrinkedHeader(
      {super.key,
      required this.notchPadding,
      required this.notchedContainerHeight,
      required this.notchRadius,
      required this.subtitle,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      child: Container(
        padding: EdgeInsets.only(top: notchRadius / 2),
        height: notchedContainerHeight - (notchRadius + notchPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  title,
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                gapH8,
                AutoSizeText(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
