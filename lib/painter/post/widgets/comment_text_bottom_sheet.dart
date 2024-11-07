import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';

class CommentTextBottomSheet extends StatelessWidget {
  const CommentTextBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xffE0E0E0),
          ),
        ),
        Container(
            alignment: Alignment.center,
            width: 120,
            child: Text(
              AppStrings.comments.tr().toUpperCase(),
              style: const TextStyle(
                  color: Color(0xffEE3F80),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xffE0E0E0),
          ),
        ),
      ],
    );
  }
}
