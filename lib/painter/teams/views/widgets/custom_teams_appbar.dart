import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';

class CustomTeamsAppbar extends StatelessWidget {
  final String title;
  final bool isShare;
  final VoidCallback popFun;
  final VoidCallback? shareFun;

  const CustomTeamsAppbar({super.key, required this.title, this.isShare=true, required this.popFun, this.shareFun});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: popFun,
          child: Icon(Icons.arrow_back, color: const Color(0xffFFFFFF),)
          // SvgPicture.asset(
          //   AppImages.arrow,
          //   width: AppSizes.s20,
          //   height: AppSizes.s20,
          // ),
        ),
        const Spacer(),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
              fontSize: AppSizes.s16,
              fontWeight: FontWeight.w700,
              color: Color(AppColors.textC5)),
        ),
        const Spacer(),
        isShare?  GestureDetector(
                onTap: shareFun,
                child: SvgPicture.asset(
                  AppImages.share,
                  width: AppSizes.s26,
                  height: AppSizes.s26,
                ),
              ):GestureDetector(
            onTap: (){},
            child: const Icon(Icons.arrow_back, color: Colors.transparent,)
        ),
      ],
    );
  }
}
