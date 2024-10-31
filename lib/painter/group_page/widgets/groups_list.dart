import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/group_page/logic/groups_cubit.dart';
import 'package:orient/painter/group_page/logic/groups_state.dart';
import 'package:orient/painter/group_page/widgets/groups_item.dart';

import '../../post/post_details_screen.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit,GroupsState>(
      builder: (context, state) {
       if (state is GetGroupsSuccessState) {
         return ListView.separated(
           itemCount: GroupsCubit.get(context).groupResponse!.data.length,
           itemBuilder: (context, index) => GroupsItem(data: GroupsCubit.get(context).groupResponse!.data[index],),
           separatorBuilder: (context, index) => const SizedBox(height: 8,),);
       }
       else if (state is GetGroupsFailureState) {
         return const Center(child: Text('Something went wrong, try again'));

       }
       else{
         return const Center(child: CircularProgressIndicator());
       }
      }
    );
  }
}
