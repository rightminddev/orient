import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/post/data/repositories/post_repository/post_repository_implementation.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/painter/post/widgets/custom_sliver_app_bar.dart';
import 'package:orient/painter/post/widgets/custom_sliver_list.dart';
import 'package:provider/provider.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key, required this.socialGroupId});

  final int socialGroupId;

  @override
  Widget build(BuildContext context) {
    print(socialGroupId);
    return ChangeNotifierProvider(
        create: (context) => PostsProvider(
            PostRepositoryImplementation(ApiServicesImplementation()))
          ..getPosts(socialGroupId: socialGroupId)
          ..scrollListenerPostsData(socialGroupId: socialGroupId),
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    radius: 0.8,
                    stops: [0.1, 1.0],
                    center: Alignment.centerLeft,
                    colors: [
                      Color.fromRGBO(255, 0, 123, 0.06),
                      Color.fromRGBO(0, 161, 255, 0.06)
                    ])),
            child: Consumer<PostsProvider>(
              builder: (context, provider, child) {
                if (provider.status == PostsStatus.success ||
                    provider.status == PostsStatus.pagination) {
                  return CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    controller: provider.postsScrollController,
                    slivers: [
                      CustomSliverAppBar(),
                      CustomSliverList(
                        postResponse: provider.postResponse!,
                        socialGroupId: socialGroupId,
                      ),
                    ],
                  );
                } else if (provider.status == PostsStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.status == PostsStatus.failure) {
                  return Center(child: Text(provider.errorMessage!));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ));
  }
}
