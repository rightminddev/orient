import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/custom_list_tile_widget.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';

import '../../../general_services/app_theme.service.dart';

class ImageWithTitleScreen extends StatelessWidget {
  const ImageWithTitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomListTileWidget(
                image:
                    'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ',
                title: "best first paints",
                subtitle: 'Cairo, Egypt',
                titleFontColor:
                    AppThemeService.colorPalette.secondaryTextColor.color,
              ),
              CustomListTileWidget(
                image:
                    'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ',
                title: 'ALI MOHAMMED',
                subtitle: '+20 1299857520',

                titleFontSize: AppSizes.s12,
                titleFontWeight: FontWeight.w600,
                subtitleFontSize: AppSizes.s12,

                ///     subtitleFontWeight: FontWeight.w500,
                isButtonOneVisible: true,
                buttonOneTitle: 'Remove',
                buttonOneColor: const Color(AppColors.red),
                buttonOneOnPressed: () {},
              ),
              CustomListTileWidget(
                image:
                    'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ',
                title: 'ALI MOHAMMED',
                subtitle: '+20 1299857520',
                titleFontSize: AppSizes.s12,
                titleFontWeight: FontWeight.w600,
                subtitleFontSize: AppSizes.s12,

                ///     subtitleFontWeight: FontWeight.w500,
                isButtonOneVisible: true,
                buttonOneTitle: 'Remove',
                buttonOneColor: const Color(AppColors.red),
                buttonOneOnPressed: () {},

                isButtonTwoVisible: true,
                buttonTwoTitle: 'Add',
                buttonTwoColor: const Color(AppColors.oc1),
                buttonTwoOnPressed: () {},
              ),
              CustomListTileWidget(
                image:
                    'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ',
                title: 'Stars Team',
                subtitle: '24 Posts',

                titleFontSize: AppSizes.s14,
                titleFontWeight: FontWeight.w600,
                subtitleFontSize: AppSizes.s12,

                ///     subtitleFontWeight: FontWeight.w500,
                isButtonOneVisible: true,
                buttonOneTitle: 'discover',
                buttonOneColor: const Color(AppColors.oc2),
                buttonOneOnPressed: () {},
              ),
              CustomListTileWidget(
                image:
                    'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ',
                title: 'al-Nasr Group',

                titleFontSize: AppSizes.s14,
                titleFontWeight: FontWeight.w600,

                ///     subtitleFontWeight: FontWeight.w500,
                isButtonOneVisible: true,
                buttonOneTitle: 'More',
                buttonOneColor: const Color(AppColors.oc2),
                buttonOneOnPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
