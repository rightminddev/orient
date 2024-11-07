import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orient/modules/authentication/views/widgets/phone_number_field.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/layout.service.dart';
import '../../../general_services/validation_service.dart';
import '../../../utils/base_page/mobile.header.dart';
import '../../../utils/base_page/mobile.scaffold.dart';
import '../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import '../viewmodels/personal_profile.viewmodel.dart';
import 'widgets/personal_profile_header.widget.dart';
import 'widgets/personal_profile_shrinked_header.widget.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({super.key});

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  late final PersonalProfileViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = PersonalProfileViewModel();
    viewModel.initializePersonalProfileScreen(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.secondary,
      fontSize: AppSizes.s14,
    );
    return ChangeNotifierProvider<PersonalProfileViewModel>(
      create: (_) => viewModel,
      child: CoreMobileScaffold(
          backgroundColor: Colors.white,
          controller: viewModel.scrollController,
          headers: [
            CoreHeader.transform(
              pinned: true,
              color: Colors.white,
              shrinkHeight: AppSizes.s140,
              expandedHeight: AppSizes.s340,
              shrinkChild: const PersonalProfileShrinkedHeaderWidget(),
              child: SingleChildScrollView(
                  controller: viewModel.scrollController,
                  child: Consumer<PersonalProfileViewModel>(
                    builder: (context, viewModel, child) =>
                        PersonalProfileHeaderWidget(
                            viewModel: viewModel,
                            circleBorderWidth: AppSizes.s12,
                            key: UniqueKey(),
                            headerImage: AppImages.companyInfoBackground,
                            backgroundHeight: viewModel.backgroundHeight,
                            notchedContainerHeight:
                                viewModel.notchedContainerHeight,
                            notchRadius: viewModel.notchRadius,
                            notchPadding: viewModel.notchPadding,
                            notchImage: AppImages.logo,
                            title: viewModel.nameController.text,
                            subtitle: 'Nice to Meet You'),
                  )),
            )
          ],
          children: [
            Consumer<PersonalProfileViewModel>(
                builder: (context, viewModel, child) => Padding(
                      padding: const EdgeInsets.only(top: AppSizes.s12),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.s12, right: AppSizes.s12),
                        child: Column(
                          children: [
                            // CHANGE PHONE NUMBER
                            ...[
                              Text(
                                'Change phone number',
                                style: textStyle,
                              ),
                              gapH18,
                              //phone number
                              PhoneNumberField(
                                controller: viewModel.phoneNumberController,
                                countryCodeController:
                                    viewModel.countryCodeController,
                                initialCountry: viewModel.initialCountry,
                              ),
                              gapH18,
                              Center(
                                child: CustomElevatedButton(
                                    titleSize: AppSizes.s14,
                                    radius: AppSizes.s10,
                                    title: 'Update Phone',
                                    onPressed: () async =>
                                        viewModel.updateProfilePhoneNumber(
                                            context: context)),
                              ),
                              gapH20,
                              const CustomDivider(),
                            ],
                            // CHANGE EMAIL
                            ...[
                              Text(
                                'Change Email',
                                style: textStyle,
                              ),
                              gapH18,
                              //Email
                              Form(
                                key: viewModel.form2Key,
                                child: TextFormField(
                                  controller: viewModel.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      const InputDecoration(hintText: 'Email'),
                                  validator: (value) =>
                                      ValidationService.validateEmail(value),
                                ),
                              ),
                              gapH18,
                              Center(
                                child: CustomElevatedButton(
                                    radius: AppSizes.s10,
                                    titleSize: AppSizes.s14,
                                    title: 'Update Email',
                                    onPressed: () async => viewModel
                                        .updateProfileEmail(context: context)),
                              ),
                              const CustomDivider(),
                            ],
                            // MAIN DATA FORM
                            ...[
                              Text(
                                'Update Main Data',
                                style: textStyle,
                              ),
                              Form(
                                key: viewModel.form1Key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Avatar
                                    Center(
                                        child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: AppSizes.s150,
                                          height: AppSizes.s150,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                width: AppSizes.s2),
                                          ),
                                          child: ClipOval(
                                            child: viewModel.selectedAvatar !=
                                                    null
                                                ? Image.file(
                                                    File(viewModel
                                                        .selectedAvatar!
                                                        .files
                                                        .single
                                                        .path!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : viewModel.userData?.photo ==
                                                        null
                                                    ? Image.asset(
                                                        AppImages
                                                            .profilePlaceHolder,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl: viewModel
                                                                .userData
                                                                ?.photo ??
                                                            '',
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            const ShimmerAnimatedLoading(
                                                              circularRaduis:
                                                                  AppSizes.s50,
                                                            ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                              Icons
                                                                  .image_not_supported_outlined,
                                                              size:
                                                                  AppSizes.s60,
                                                            )),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.camera_alt,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              size: AppSizes.s40,
                                            ),
                                            onPressed: viewModel.pickAvatar,
                                          ),
                                        ),
                                      ],
                                    )),
                                    gapH12,
                                    //Name
                                    TextFormField(
                                      controller: viewModel.nameController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          hintText: 'Name'),
                                      validator: (value) =>
                                          ValidationService.validateRequired(
                                              value),
                                    ),

                                    gapH12,
                                    //BirthDate
                                    TextFormField(
                                      readOnly: true,
                                      onTap: () async => await viewModel
                                          .selectBirthDate(context),
                                      controller: viewModel.birthDateController,
                                      decoration: const InputDecoration(
                                          hintText: 'BirthDate'),
                                      validator: (value) =>
                                          ValidationService.validateRequired(
                                              value),
                                    ),
                                    //update profile button
                                    gapH18,
                                    Center(
                                      child: CustomElevatedButton(
                                          radius: AppSizes.s10,
                                          titleSize: AppSizes.s14,
                                          title: 'Update Profile',
                                          onPressed: () async =>
                                              viewModel.updateProfileMainInfo(
                                                  context: context)),
                                    ),
                                  ],
                                ),
                              ),
                              const CustomDivider(),
                            ],

                            Form(
                              key: viewModel.form3Key,
                              child: TextFormField(
                                controller: viewModel
                                    .passwordForRemoveAccountController,
                                keyboardType: TextInputType.visiblePassword,
                                decoration:
                                    const InputDecoration(hintText: 'Password'),
                                validator: (value) =>
                                    ValidationService.validatePassword(value),
                              ),
                            ),
                            gapH12,
                            Center(
                              child: CustomElevatedButton(
                                titleSize: AppSizes.s14,
                                width: LayoutService.getWidth(context),
                                radius: AppSizes.s10,
                                backgroundColor: Colors.red,
                                title: 'Delete Your Account',
                                onPressed: () async => await viewModel
                                    .removeAccount(context: context),
                              ),
                            ),
                            gapH20,
                            const CustomDivider(),
                            //Enable 2FA
                            Center(
                              child: CustomElevatedButton(
                                titleSize: AppSizes.s14,
                                width: LayoutService.getWidth(context),
                                radius: AppSizes.s10,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                title: 'Enable 2FA',
                                onPressed: () async => () async =>
                                    await viewModel.activate2FA(
                                        context: context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          ]),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH20,
        Divider(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          height: AppSizes.s6,
          thickness: AppSizes.s2,
        ),
        gapH20,
      ],
    );
  }
}
