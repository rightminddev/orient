import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  final id;
  const AddPostScreen({super.key, this.id});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  void showTermsAndConditionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(AppColors.bgC3),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(AppColors.bgC3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x00000000), // Adjust opacity as needed
                spreadRadius: 0,
                blurRadius: 11,
                offset: Offset(0, -4), // Shadow position
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: AppSizes.s16,
                bottom: AppSizes.s36,
                right: AppSizes.s24,
                left: AppSizes.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppImages.bottomSheet)),
                gapH64,
                const Text(
                  "Welcome to Oraint Paints, a recruitment app that aims to connect job seekers with employers. Your use of this application means your acceptance of this policy. We ask you to read this policy carefully before using the application.",
                  style: TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: Color(AppColors.black1Color)),
                ),
                gapH10,
                Text(
                  "1. Acceptance of the conditions".toUpperCase(),
                  style: const TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.oC2Color)),
                ),
                gapH10,
                const Text(
                  "Welcome to Oraint Paints, a recruitment app that aims to connect job seekers with employers. Your use of this application means your acceptance of this policy. We ask you to read this policy carefully before using the application.",
                  style: TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: Color(AppColors.black1Color)),
                ),
                gapH10,
                Text(
                  "1. Acceptance of the conditions".toUpperCase(),
                  style: const TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.oC2Color)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController uploadImageController = TextEditingController();
  final picker = ImagePicker();
  XFile? XImageFileAttachment;
  File? attachmentImage;
  List listAttachmentImage = [];
  List<XFile> listXAttachmentImage = [];
  Future<void> getProfileImageByCam(
      {image1, image2, list, list2, one}) async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.camera);
    if (imageFileProfile == null) return;
    setState(() {
      image1 = File(imageFileProfile.path);
      image2 = imageFileProfile;
      if(one == false)list.add({"image": image2, "view": image1});
      if(one == false)list2.add(image2);
    });
    print(image1);
  }

  Future<void> getProfileImageByGallery(
      {image1, image2, list, list2, one}) async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.gallery);
    if (imageFileProfile == null) return null;
    setState(() {
      image1 = File(imageFileProfile.path);
      image2 = imageFileProfile;
      if(one == false) list.add({"image": image2, "view": image1});
      if(one == false)list2.add(image2);
    });
  }
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
          "create team".toUpperCase(),
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
        create: (_)=>PostsProvider(),
        child: Consumer<PostsProvider>(
          builder: (context, PostsProvider, child) {
            if(PostsProvider.status == PostsStatus.success){
              Navigator.pop(context);
            }
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
                    child: Column(
                      children: [
                        gapH16,
                        defaultTextFormField(
                          controller: titleController,
                          hintText: 'Title',
                        ),
                        gapH18,
                        defaultTextFormField(
                          controller: contentController,
                          maxLines: 5,
                          containerHeight: 150,
                          hintText: 'Content',
                        ),
                        gapH18,
                        Container(
                        height: 140,
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
                              GestureDetector(
                                onTap: ()async{
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
                                child: Row(
                                  children: [
                                    const Text(
                                      "Upload Image",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
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
                        gapH82,
                        if(PostsProvider.status == PostsStatus.loading)const Center(child: CircularProgressIndicator(),),
                        if(PostsProvider.status != PostsStatus.loading)ElevatedButton.icon(
                          onPressed: () {
                            PostsProvider.addPosts(
                              context: context,
                              content: contentController.text,
                              socialGroupId: widget.id,
                              attachments: listXAttachmentImage
                            );
                          },
                          icon: SvgPicture.asset(
                            AppImages.createTeam,
                            width: AppSizes.s24,
                            height: AppSizes.s24,
                          ),
                          label: Text(
                            "Create Post".toUpperCase(),
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
            );
          },
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
  Future<void> getImage({image1, image2, list, bool one = true, list2}) =>
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
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("Select Photo",
                      style: TextStyle(
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
                            const Text("Gallery",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF011A51)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await getProfileImageByCam(
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
                              "Camera",
                              style: TextStyle(fontSize: 18, color: Color(0xFF011A51)),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
}
