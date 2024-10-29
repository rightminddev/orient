import 'package:flutter/material.dart';
import 'package:orient/common_modules_widgets/loading_page.widget.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/painters/teams/view_models/teams.viewmodel.dart';
import 'package:orient/modules/painters/teams/views/widgets/custom_teams_search_bar.dart';
import 'package:orient/modules/painters/teams/views/widgets/teams_list_view_item_.dart';
import 'package:provider/provider.dart';

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
    viewModel.initializeTeamList(context, "teams");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeamsViewModel>(
      create: (_) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "teams".toUpperCase(),
            style: const TextStyle(
                fontSize: AppSizes.s16,
                fontWeight: FontWeight.w700,
                color: Color(0XFF224982)),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    radius: 0.8,
                    stops: [0.1, 1.0],
                    center: Alignment.centerLeft,
                    colors: [
                      Color.fromRGBO(255, 0, 123, 0.10),
                      Color.fromRGBO(0, 161, 255, 0.10)
                    ])),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  radius: 0.8,
                  stops: [0.1, 1.0],
                  center: Alignment.centerLeft,
                  colors: [
                    Color.fromRGBO(255, 0, 123, 0.10),
                    Color.fromRGBO(0, 161, 255, 0.10)
                  ])),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s24, vertical: AppSizes.s10),
            child: Consumer<TeamsViewModel>(
              builder: (context, teamsViewModel, child) => viewModel.isLoading
                  ? const LoadingPageWidget(
                      reverse: true,
                      height: AppSizes.s75,
                    )
                  : Column(
                      children: [
                        const CustomTeamsSearchBar(),
                        gapH16,
                        ListView.builder(
                          itemCount: teamsViewModel.teamsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TeamsListViewItem(
                              model: teamsViewModel.teamsList[index],
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: AppSizes.s70,
          height: AppSizes.s70,
          child: FloatingActionButton.large(
            onPressed: () {},
            backgroundColor: const Color(AppColors.oC2Color),
            child: const Icon(
              Icons.add,
              size: AppSizes.s28,
              color: Color(AppColors.textC5),
            ),
          ),
        ),
      ),
    );
  }
}
