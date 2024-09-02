import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/layout.service.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../view_models/fingerprint.viewmodel.dart';
import 'widgets/fingerprint_card.widget.dart';
import 'widgets/fingerprint_loading_screen.dart';

class FingerprintScreen extends StatefulWidget {
  final String? empId;
  final String? empName;
  const FingerprintScreen({super.key, this.empId, this.empName});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  late final FingerprintViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = FingerprintViewModel();
    viewModel.initializeFingerprintScreen(
        context: context, empId: widget.empId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FingerprintViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          floatingActionButton: const MainAppFabWidget(),
          pageContext: context,
          bottomAppbarWidget: widget.empId != null &&
                  widget.empId?.isNotEmpty == true &&
                  widget.empName != null &&
                  widget.empName?.isNotEmpty == true &&
                  viewModel.userSettings?.userId.toString() != widget.empId
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(AppSizes.s40),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s12, vertical: AppSizes.s6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          widget.empName!,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: AppSizes.s20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          title: AppStrings.fingerprintsTitle.tr(),
          onRefresh: () async => await viewModel.initializeFingerprintScreen(
              context: context, empId: widget.empId),
          body: Padding(
            padding: const EdgeInsets.all(AppSizes.s12),
            child: SingleChildScrollView(
              child: Consumer<FingerprintViewModel>(
                  builder: (context, viewModel, child) => viewModel.isLoading
                      ? const FingerprintLoadingScreenWidget()
                      : viewModel.fingerprints?.isEmpty == true ||
                              viewModel.fingerprints == null
                          ? NoExistingPlaceholderScreen(
                              height: LayoutService.getHeight(context) * 0.6,
                              title: AppStrings.noFingerprintsYet.tr())
                          : Column(children: [
                              /// general screen message widget for other requests types
                              const GeneralScreenMessageWidget(
                                  screenId: '/fingerprints'),
                              ...viewModel.fingerprints!.map(
                                (fingerprint) => Column(
                                  children: [
                                    FingerprintCard(
                                      fingerprint: fingerprint,
                                    ),
                                    gapH12
                                  ],
                                ),
                              )
                            ])),
            ),
          )),
    );
  }
}
