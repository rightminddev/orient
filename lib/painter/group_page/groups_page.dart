import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/group_page/widgets/groups_list.dart';

import '../core/api/api_services.dart';
import 'data/repositories/get_social_groups_repository_implementation.dart';
import 'logic/groups_cubit.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupsCubit(
          GetSocialGroupsRepositoryImplementation(ApiServicesImplementation()))
        ..getGroups(),
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            'My Groups',
            style: TextStyle(
                color: Color(0xFF0D3B6F),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 110),
              child: GroupsList(),
            ),
          )
        ],
      ),
    );
  }
}
