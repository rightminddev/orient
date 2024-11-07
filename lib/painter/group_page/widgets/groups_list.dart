import 'package:flutter/material.dart';
import 'package:orient/painter/group_page/logic/groups_provider.dart';
import 'package:orient/painter/group_page/widgets/groups_item.dart';
import 'package:provider/provider.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupsProvider>(
      builder: (context, provider, child) {
        if (provider.status == GroupsStatus.success) {
          print("SUCCESS");
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: provider.groupResponse!.data.length,
            itemBuilder: (context, index) => GroupsItem(data: provider.groupResponse!.data[index],),
            separatorBuilder: (context, index) => const SizedBox(height: 16,),);
        }
        else if (provider.status == GroupsStatus.loading) {
          return Container();
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
