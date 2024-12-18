import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/post/data/repositories/post_repository/post_repository_implementation.dart';
import 'package:orient/painter/post/loading/post_loading.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/painter/post/widgets/custom_sliver_app_bar.dart';
import 'package:orient/painter/post/widgets/custom_sliver_list.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, required this.socialGroupId, required this.groupName});

  final int socialGroupId;
  final String groupName;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late ScrollController _scrollController;
  late final PostsProvider postProvider;

  @override
  void initState() {
    super.initState();
    postProvider = PostsProvider();
    _scrollController = ScrollController();
    postProvider.getPosts(socialGroupId: widget.socialGroupId, context: context);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        postProvider.getPosts(socialGroupId: widget.socialGroupId, isNewPage: true, context: context);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostsProvider>(
      create: (_) => postProvider,
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            await postProvider.refreshPosts(widget.socialGroupId, context);
          },
          child: GradientBgImage(
            padding: EdgeInsets.zero,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Consumer<PostsProvider>(
                builder: (context, provider, child) {

                  if (provider.status == PostsStatus.failure) {
                    return Center(child: Text(provider.errorMessage!));
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height:(provider.status == PostsStatus.loading)?
                        MediaQuery.sizeOf(context).height * 0.9: MediaQuery.sizeOf(context).height * 1,
                        child: (provider.status == PostsStatus.loading && provider.pageNumber ==1) ?
                        const PostLoading()
                        :CustomScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          slivers: [
                            CustomSliverAppBar(widget.socialGroupId, widget.groupName),
                            CustomSliverList(socialGroupId: widget.socialGroupId),
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                            ),
                          ],
                        ),
                      ),
                      if (provider.status == PostsStatus.loading && provider.pageNumber != 1) const Center(child: CircularProgressIndicator())

                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

