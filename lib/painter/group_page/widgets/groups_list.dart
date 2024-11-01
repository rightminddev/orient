import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/group_page/logic/groups_provider.dart';
import 'package:orient/painter/group_page/widgets/groups_item.dart';
import 'package:provider/provider.dart';

import '../../post/post_details_screen.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupsProvider>(
      builder: (context, provider, child) {
        if (provider.status == GroupsStatus.success) {
          return ListView.separated(
            itemCount: provider.groupResponse!.data!.length,
            itemBuilder: (context, index) => GroupsItem(data: provider.groupResponse!.data![index],),
            separatorBuilder: (context, index) => SizedBox(height: 8,),);
        }
        else if (provider.status == GroupsStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (provider.status == GroupsStatus.failure) {
          return Center(child: Text(provider.errorMessage!));

        }
        else{
          return Container();
        }
      },
    );
  }
}
