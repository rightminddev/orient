import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/group_page/group_page_loading.dart';
import 'package:orient/painter/group_page/logic/groups_provider.dart';
import 'package:orient/painter/group_page/widgets/groups_list.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';
import 'data/repositories/get_social_groups_repository_implementation.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GroupsProvider()..getGroups(context),
      child: Consumer<GroupsProvider>(
        builder: (context, value, child) {
          return (value.status == GroupsStatus.loading)?
          const GroupsPageLoading()
          :Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body: GradientBgImage(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        AppStrings.myGroups.tr().toUpperCase(),
                        style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                          onPressed: (){}
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Expanded(
                    child: GroupsList(),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
