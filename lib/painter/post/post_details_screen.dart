import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/post/data/repositories/post_repository/post_repository_implementation.dart';
import 'package:orient/painter/post/logic/post_cubit/posts_cubit.dart';
import 'package:orient/painter/post/logic/post_cubit/posts_state.dart';
import 'package:orient/painter/post/widgets/custom_sliver_app_bar.dart';
import 'package:orient/painter/post/widgets/custom_sliver_list.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key, required this.socialGroupId});

  final int socialGroupId;
  @override
  Widget build(BuildContext context) {
    print(socialGroupId);
    return BlocProvider(
      create: (context) => PostsCubit(PostRepositoryImplementation(ApiServicesImplementation()))..getPosts(socialGroupId: socialGroupId)..scrollListenerPostsData(socialGroupId: socialGroupId),
      child: Scaffold(
          body: BlocBuilder<PostsCubit,PostsState>(
            builder: (context, state) {
              if (state is GetPostsSuccessState) {
                return CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  // controller: ,
                  controller: PostsCubit.get(context).postsScrollController,
                  slivers: [
                    const CustomSliverAppBar(),
                    CustomSliverList(postResponse: PostsCubit.get(context).postResponse!, socialGroupId: socialGroupId,),
                  ],
                );
              }
              else if (state is GetPostsFailureState) {
                return const Center(child: Text('Something went wrong, try again'));
              }
              else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
      )
    );
  }
}
