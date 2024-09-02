import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../general_services/layout.service.dart';

class ActionsList extends StatelessWidget {
  const ActionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.s12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ActionCard(
              title: 'ADD REQUESTS',
              iconPath: 'assets/group-1321317171.svg',
            ),
            SizedBox(width: AppSizes.s10),
            ActionCard(
              title: 'VIEW TASKS',
              iconPath: 'assets/group-1321317171-2.svg',
            ),
            SizedBox(width: AppSizes.s10),
            ActionCard(
              title: 'MY TEAM REQUESTS',
              iconPath: 'assets/group-1321317171-3.svg',
            ),
          ],
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final String iconPath;

  const ActionCard({
    required this.title,
    required this.iconPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (LayoutService.getWidth(context) - AppSizes.s45) / 3,
      height: AppSizes.s110,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
