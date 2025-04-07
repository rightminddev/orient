import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../general_services/layout.service.dart';

class MyTasksList extends StatelessWidget {
  const MyTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('MY TASKS', style: Theme.of(context).textTheme.bodyMedium),
              Text(AppStrings.viewAll.tr(),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          gapH16,
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskCard(
                  iconPath: 'assets/group-1321317161-2.svg',
                  date: '5-1-2022 : 10-1-2022 (3 days)',
                  title: 'Right mind website',
                  statusIconPath: 'assets/iconixto-linear-code-pc-3.svg',
                  status: TaskStatus.completed,
                ),
                SizedBox(width: 16),
                TaskCard(
                  iconPath: 'assets/group-1321317161.svg',
                  date: '5-1-2022 : 10-1-2022 (3 days)',
                  title: 'Right mind website',
                  statusIconPath: 'assets/iconixto-linear-branch.svg',
                  status: TaskStatus.pending,
                ),
                SizedBox(width: 16),
                TaskCard(
                  iconPath: 'assets/group-1321317161.svg',
                  date: '5-1-2022 : 10-1-2022 (3 days)',
                  title: 'Right mind website',
                  statusIconPath: 'assets/iconixto-linear-code-pc-2.svg',
                  status: TaskStatus.completed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum TaskStatus { completed, pending, inProgress }

class TaskCard extends StatelessWidget {
  final String iconPath;
  final String date;
  final String title;
  final String statusIconPath;
  final TaskStatus status;

  const TaskCard({
    required this.iconPath,
    required this.date,
    required this.title,
    required this.statusIconPath,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: LayoutService.getWidth(context) * 0.6,
      padding: status == TaskStatus.completed
          ? const EdgeInsets.only(
              left: AppSizes.s8, top: AppSizes.s20, bottom: AppSizes.s20)
          : const EdgeInsets.symmetric(
              vertical: AppSizes.s20, horizontal: AppSizes.s8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: status == TaskStatus.completed
            ? Border.all(
                color: const Color(0xFFEE3F80),
                width: 1,
              )
            : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: AppSizes.s8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.code,
            color: Theme.of(context).colorScheme.secondary,
            size: AppSizes.s32,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.s12,
                  color: Theme.of(context).colorScheme.primary,
                  height: 1.5,
                ),
              ),
              gapH4,
              Opacity(
                opacity: 0.8,
                child: Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: AppSizes.s8,
                    letterSpacing: 0.5,
                    color: Color(0xFF4F4F4F),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
