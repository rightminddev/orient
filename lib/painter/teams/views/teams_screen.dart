import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/painter/teams/view_models/teams.viewmodel.dart';
import 'package:orient/painter/teams/views/loading/team_screen_loading.dart';
import 'package:orient/painter/teams/views/widgets/custom_teams_search_bar.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import 'widgets/teams_list_view_item_.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late final TeamsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = TeamsViewModel();
    viewModel.initializeTeamList(context, "teams", name: "");
    viewModel.controller.addListener(() {
      if (viewModel.controller.position.pixels ==
          viewModel.controller.position.maxScrollExtent) {
        // Load more data when the user reaches the bottom
        if (viewModel.hasMoreData(viewModel.teamsList.length)) {
          viewModel.initializeTeamList(context, "teams", name: "");
        }
      }
    });
  }
  @override
  void dispose() {
    viewModel.controller.dispose(); // Dispose of the controller
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeamsViewModel>(
      create: (_) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            appBar: AppBar(
              backgroundColor: const Color(0xffFFFFFF),
              elevation: 0.0,
              title: Text(
                  AppStrings.teams.tr().toUpperCase(),
                style: const TextStyle(
                    fontSize: AppSizes.s16,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF224982)),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFFFF007A).withOpacity(0.03),
                      const Color(0xFF00A1FF).withOpacity(0.03)
                    ],
                  ),),
              ),
            ),
            body: GradientBgImage(
              padding: EdgeInsets.zero,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  controller: viewModel.scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.s24, vertical: AppSizes.s10),
                  child: Consumer<TeamsViewModel>(
                    builder: (context, teamsViewModel, child) =>
                        Column(
                          children: [
                            CustomTeamsSearchBar(),
                            gapH16,
                            if(viewModel.isLoading && viewModel.pageNumber == 1)const TeamScreenLoading(),
                            if (!viewModel.isLoading && homeViewModel.userSettings != null && viewModel.pageNumber == 1 || viewModel.pageNumber != 1 ) ListView.builder(
                              itemCount: teamsViewModel.teamsList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return TeamsListViewItem(
                                    model: teamsViewModel.teamsList,
                                    index: index,
                                  userTeamId: (homeViewModel.userSettings!.userTeam != null)?homeViewModel.userSettings!.userTeam!.id : 0,
                                );
                              },
                            ),
                            if (viewModel.isLoading && viewModel.pageNumber != 1)const SizedBox(height: 10,),
                            if(viewModel.isLoading && viewModel.pageNumber != 1) const CircularProgressIndicator()
                          ],
                        ),
                  ),
                ),
              ),
            ),
           floatingActionButton:
           (homeViewModel.userSettings != null)?(homeViewModel.userSettings?.userTeam == null)?
           SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton.large(
                onPressed: () {
                  context.pushNamed(AppRoutes.painterCreateTeamsScreen.name,
                      pathParameters: {'lang': context.locale.languageCode});
                },
                backgroundColor: const Color(AppColors.oC2Color),
                child: const Icon(
                  Icons.add,
                  size: AppSizes.s28,
                  color: Color(AppColors.textC5),
                ),
              ),
            ):const SizedBox.shrink():const SizedBox.shrink(),
          );
        },
      )
    );
  }
}
