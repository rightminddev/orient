import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/company_social_contacts.widget.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../viewmodels/company_structure_info.viewmodel.dart';
import 'widgets/company_info_header/company_info_header_widget.dart';

class CompanyStructureInfoScreen extends StatefulWidget {
  const CompanyStructureInfoScreen({super.key});

  @override
  State<CompanyStructureInfoScreen> createState() =>
      _CompanyStructureInfoScreenState();
}

class _CompanyStructureInfoScreenState
    extends State<CompanyStructureInfoScreen> {
  late final CompanyStructureInfoViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = CompanyStructureInfoViewModel();
    viewModel.initializeCompanyinformationScreen(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CompanyStructureInfoViewModel>(
        create: (_) => viewModel,
        child: Consumer<CompanyStructureInfoViewModel>(
            builder: (context, viewModel, child) => Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      CompanyInfoHeader(
                          key: UniqueKey(),
                          headerImage: AppImages.companyInfoBackground,
                          backgroundHeight: viewModel.backgroundHeight,
                          notchedContainerHeight:
                              viewModel.notchedContainerHeight,
                          notchRadius: viewModel.notchRadius,
                          notchPadding: viewModel.notchPadding,
                          notchImage: AppImages.logo,
                          title:
                              '${viewModel.applicationName ?? ''} ( ${viewModel.applicationVersion ?? ''} )',
                          subtitle: viewModel.applicationDescription ?? ''),
                      gapH16,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.s12),
                          child: AutoSizeText(
                            '${viewModel.applicationName} application is an innovative recruitment platform that aims to connect job seekers with employers easily and effectively. The application provides a range of tools and features that facilitate the hiring process for both sides, making it faster and more efficient.\n\n${viewModel.applicationName} application is an innovative recruitment platform that aims to connect job seekers with employers easily and effectively. The application provides a range of tools and features that facilitate the hiring process for both sides, making it faster and more efficient.',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: AppSizes.s12,
                            ),
                          ),
                        ),
                      ),
                      gapH26,
                      Text(
                        'FOLLOW US',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.9,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      gapH12,
                      if (viewModel.settings?.companyContacts != null)
                        CompanySocialContacts(
                          socialData: viewModel.settings!.companyContacts!,
                        ),
                      gapH24,
                      Center(
                        child: CustomElevatedButton(
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            title: 'SEND BY EMAIL',
                            onPressed: () async =>
                                await viewModel.sendMailToCompany(
                                    context: context,
                                    email: 'test@gmail.co',
                                    subject: null,
                                    body: null)),
                      ),
                      gapH18
                    ],
                  ),
                )));
  }
}
