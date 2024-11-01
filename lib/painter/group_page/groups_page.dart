import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/group_page/logic/groups_provider.dart';
import 'package:orient/painter/group_page/widgets/groups_list.dart';

import 'package:provider/provider.dart';

import '../core/api/api_services.dart';
import 'data/repositories/get_social_groups_repository_implementation.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupsProvider(
          GetSocialGroupsRepositoryImplementation(ApiServicesImplementation()))
        ..getGroups(),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
              child: Text(
            'My Groups',
            style: TextStyle(
                color: Color(0xFF0D3B6F),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
          // SizedBox(
          //   height: 20,
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: GroupsList(),
            ),
          )
        ],
      ),
    );
  }
}
