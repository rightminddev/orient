import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../viewmodels/personal_profile.viewmodel.dart';
import 'personal_profile_header.widget.dart';

class PersonalProfileShrinkedHeaderWidget extends StatelessWidget {
  const PersonalProfileShrinkedHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalProfileViewModel>(
      builder: (context, viewModel, child) => Stack(
        children: [
          const PersonalProfileHeaderBackgroundWidget(
            headerImage: AppImages.companyInfoBackground,
            backgroundHeight: AppSizes.s140,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSizes.s12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
              width: LayoutService.getWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFA3A3A3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.s15),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: AppSizes.s18,
                          ),
                        ),
                      )),
                  const Text(
                    'Account & Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizes.s14,
                      letterSpacing: 1.4,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFA3A3A3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.s15),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async =>
                              await viewModel.logout(context: context),
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                            size: AppSizes.s18,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
