import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';

class AddNewCommentText extends StatelessWidget {
  const AddNewCommentText({super.key});

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
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Text(
              AppStrings.addNewComment.tr().toUpperCase(),
              style: const TextStyle(
                  color: Color(0xffEE3F80),
                  fontSize: 12,
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
