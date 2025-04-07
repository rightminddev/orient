import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/painter/teams/view_models/teams.actions.viewmodel.dart';
import 'package:orient/painter/teams/views/widgets/create_team_terms_sheet.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  void showTermsAndConditionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(AppColors.bgC3),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
      builder: (context) {
        return const CreateTeamTermsSheet();
      },
    );
  }
  final picker = ImagePicker();
  XFile? XImageFileAttachment;
  File? attachmentImage;
  List listAttachmentImage = [];
  List<XFile> listXAttachmentImage = [];
  Future<void> getProfileImageByCam(
      {image1, image2, list, list2, one, required bool isVideo}) async {
    XFile? mediaFile;

    mediaFile = await picker.pickImage(source: ImageSource.camera);

    if (mediaFile == null) return;

    setState(() {
      image1 = File(mediaFile!.path);
      image2 = mediaFile;
      if (!one) list.add({"media": image2, "view": image1});
      if (!one) list2.add(image2);
    });

    print("Media picked: ${image1.path}");
  }
  Future<void> getProfileImageByGallery(
      {image1, image2, list, list2, one, required bool isVideo}) async {
    XFile? mediaFile;
    mediaFile = await picker.pickImage(source: ImageSource.gallery);

    if (mediaFile == null) return;

    setState(() {
      image1 = File(mediaFile!.path);
      image2 = mediaFile;
      if (!one) list.add({"media": image2, "view": image1});
      if (!one) list2.add(image2);
    });

    print("Media picked: ${image1.path}");
  }
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController aboutTeamController = TextEditingController();
  final TextEditingController uploadImageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Color(0XFF224982),)),
        title: Text(
          AppStrings.createTeam.tr().toUpperCase(),
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
      body: ChangeNotifierProvider(
        create: (_)=>TeamsActionsViewModel(),
        child: Consumer<TeamsActionsViewModel>(
          builder: (context, teamsActionsViewModel, child) {

            return GradientBgImage(
              padding: EdgeInsets.zero,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: AppSizes.s24,
                      left: AppSizes.s24,
                      top: AppSizes.s10,
                      bottom: AppSizes.s32),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          gapH16,
                          defaultTextFormField(
                            context: context,
                            controller: teamNameController,
                            hintText: AppStrings.teamName.tr().toUpperCase(),
                            validator: (String? value) {
                              return AppStrings.teamNameIsRequired.tr();
                            },
                          ),
                          gapH18,
                          defaultTextFormField(
                            context: context,
                            controller: aboutTeamController,
                            hintText: AppStrings.teamAbout.tr().toUpperCase(),
                            validator: (String? value) {
                              return AppStrings.teamAboutIsRequired.tr();
                            },
                          ),
                          gapH18,
                          GestureDetector(
                            onTap: ()async{
                              setState(() {
                                listXAttachmentImage = [];
                                listAttachmentImage = [];
                              });
                              await getImage(
                                  image1: attachmentImage,
                                  image2: XImageFileAttachment,
                                  list2: listXAttachmentImage,
                                  one: false,
                                  list: listAttachmentImage);
                              Fluttertoast.showToast(
                                  msg: "ADD IMAGE SUCCESSFUL",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(vertical: AppSizes.s10),
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, top: 16, bottom: 10
                              ),
                              decoration: ShapeDecoration(
                                color: AppThemeService.colorPalette.tertiaryColorBackground.color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSizes.s8),
                                  side:  const BorderSide(
                                    color: Color(0xffE3E5E5),
                                    width: 1.0,
                                  ),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.uploadImage.tr(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff191C1F)
                                        ),
                                      ),
                                      const Spacer(),
                                      SvgPicture.asset(
                                        AppImages.uploadImage,
                                        width: AppSizes.s15,
                                        height: AppSizes.s15,
                                      ),
                                    ],
                                  ),
                                  if(listAttachmentImage.isNotEmpty) SizedBox(
                                    height: 90,
                                    child: GridView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listAttachmentImage.length,
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                      itemBuilder: (c, i) {
                                        return buildCustomContainer(
                                            file: listAttachmentImage[i]['view']);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          gapH82,
                          if(teamsActionsViewModel.isLoading == true)const Center(child: CircularProgressIndicator(),),
                          if(teamsActionsViewModel.isLoading == false)ElevatedButton.icon(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                teamsActionsViewModel.createTeam(context, teamNameController.text,
                                  aboutTeamController.text, listXAttachmentImage,);
                              }
                            },
                            icon: SvgPicture.asset(
                              AppImages.createTeam,
                              width: AppSizes.s24,
                              height: AppSizes.s24,
                            ),
                            label: Text(
                              AppStrings.createTeam.tr().toUpperCase(),
                              style: const TextStyle(
                                  fontSize: AppSizes.s12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppColors.textC5)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(AppColors.oC1Color),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSizes.s50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.s10, horizontal: AppSizes.s60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.info),
            gapW8,
            Text(
              AppStrings.byCreatingATeamYouAgreeToThe.tr().toUpperCase(),
              style: const TextStyle(
                  fontSize: AppSizes.s8,
                  fontWeight: FontWeight.w500,
                  color: Color(AppColors.black1Color)),
            ),
            GestureDetector(
              onTap: () {
                showTermsAndConditionsBottomSheet(context);
              },
              child: Text(
                  AppStrings.termsAndConditions.tr().toUpperCase(),
                style: const TextStyle(
                    fontSize: AppSizes.s8,
                    fontWeight: FontWeight.w500,
                    color: Color(AppColors.oC2Color)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildCustomContainer({file}
      ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color(0xFF011A51),
              width: 2
          ),
        ),
        child:  Image(
          image: FileImage(file!),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
  Future<void> getImage({image1, image2, list, bool one = true, list2,image1V, image2V, listV, list2V,}) =>
      showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 440,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(AppStrings.selectPhoto.tr(),
                      style: const TextStyle(
                          fontSize: 18, color: Color(0xFF011A51)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                await getProfileImageByGallery(
                                    isVideo: false,
                                    image1: image1,
                                    image2: image2,
                                    list: list,
                                    list2: list2,
                                    one: one
                                );
                                await image2 == null
                                    ? null
                                    : Image.asset(
                                    "assets/images/profileImage.png");
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.image,
                                  color: Color(0xFF011A51),
                                ),
                              ),
                            ),
                            Text(AppStrings.gallery.tr(),
                              style: const TextStyle(
                                  fontSize: 18, color: Color(0xFF011A51)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await getProfileImageByCam(
                                    isVideo: false,
                                    image1: image1,
                                    image2: image2,
                                    list: list,
                                    list2: list2,
                                    one: one
                                );
                                print(image1);
                                print(image2);
                                await image2 == null
                                    ? null
                                    : Image.asset(
                                    "assets/images/profileImage.png");
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera,
                                  color: Color(0xFF011A51),
                                ),
                              ),
                            ),
                            Text(
                              AppStrings.camera.tr(),
                              style: TextStyle(fontSize: 18, color: Color(0xFF011A51)),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            );
          });

}
