import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_sizes.dart';
import '../viewmodels/company_structure_tree.viewmodel.dart';
import 'widgets/company_tree_node.widget.dart';

class CompanyStructureTreeScreen extends StatefulWidget {
  const CompanyStructureTreeScreen({super.key});

  @override
  State<CompanyStructureTreeScreen> createState() =>
      _CompanyStructureTreeScreenState();
}

class _CompanyStructureTreeScreenState
    extends State<CompanyStructureTreeScreen> {
  late final CompanyStructureTreeViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = CompanyStructureTreeViewModel();
    viewModel.initializeCompanyinformationScreen(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CompanyStructureTreeViewModel>(
        create: (_) => viewModel,
        child: Scaffold(
            appBar: AppBar(
              leading: Container(
                  margin: const EdgeInsets.all(AppSizes.s8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA3A3A3).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppSizes.s15),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black54,
                        size: AppSizes.s18,
                      ),
                    ),
                  )),
              title: const Text(
                'Company Structure',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppSizes.s14,
                  letterSpacing: 1.4,
                  color: Colors.black54,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Consumer<CompanyStructureTreeViewModel>(
                builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(AppSizes.s18),
                minScale: 0.01,
                maxScale: 5.6,
                child: GraphView(
                  graph: viewModel.graph,
                  algorithm: BuchheimWalkerAlgorithm(
                    viewModel.builder,
                    TreeEdgeRenderer(viewModel.builder),
                  ),
                  builder: (Node node) {
                    int nodeId = node.key!.value;
                    var nodeData = viewModel.companyStructureTree
                        ?.firstWhere((element) => element.id == nodeId);
                    return CompanyStructureNode(
                      data: nodeData!,
                      onTap: viewModel.onNodeTap,
                    );
                  },
                ),
              );
            })));
  }
}
