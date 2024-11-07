import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/comment_widget.dart';
import 'package:provider/provider.dart';

class SingleCommentBottomsheetWidget extends StatefulWidget {
  int? id;
  SingleCommentBottomsheetWidget(@required this.id);

  @override
  State<SingleCommentBottomsheetWidget> createState() =>
      _SingleCommentBottomsheetWidgetState();
}

class _SingleCommentBottomsheetWidgetState extends State<SingleCommentBottomsheetWidget> {
  TextEditingController commentController = TextEditingController();
  String selectRate = "4";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> SingleProductProvider()..getComments(context: context, id: widget.id),
    child: Consumer<SingleProductProvider>(
        builder: (context, singleProductProvider, child){
          if(singleProductProvider.isAddCommentSuccess == true){
            singleProductProvider.getComments(context: context, id: widget.id);
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffF4F7FF),
                  Color(0xffFDFDFD),
                ],
                stops:  [0.0, 0.5],
              ),
            ),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.72,
            alignment: Alignment.topCenter,
            child: (singleProductProvider.isShowCommentLoading || singleProductProvider.isAddCommentLoading)?
             HomeLoadingPage(viewAppbar: false,)
                :Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 5,
                    width: 63,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xffB9C0C9)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xffE0E0E0),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: 120,
                        child: Text(
                          AppStrings.comments.tr().toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xffEE3F80),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xffE0E0E0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.47,
                  child: ListView.separated(
                      shrinkWrap: true,
                      reverse: false,
                      itemBuilder: (context, index) => CommentWidget(
                        isImageUrl: true,
                        image: singleProductProvider.comments[index]['user']['avatar'],
                        name: singleProductProvider.comments[index]['user']['name'].toUpperCase(),
                        nameFontSize: 12,
                        dateFontSize: 11,
                        commentFontSize: 11,
                        commentFontWeight: FontWeight.w400,
                        dateFontWeight: FontWeight.w400,
                        date:  DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.parse("${singleProductProvider.comments[index]['created_at']}")),
                        comment: singleProductProvider.comments[index]['content'],
                        isVerified: (singleProductProvider.comments[index]['user_did_buy'] == false)? false: true,
                        rate: "${singleProductProvider.comments[index]['rating']}",
                      ),
                      separatorBuilder: (context, index) => const SizedBox.shrink(),
                      itemCount: singleProductProvider.comments.length),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xffE0E0E0),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.addNewComment.tr().toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xffEE3F80),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xffE0E0E0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                defaultCommentTextFormField(
                  hintText: AppStrings.typeYourMessage.tr().toUpperCase(),
                  onTapSend: (){
                    singleProductProvider.addComments(context: context, id: widget.id,
                    content: commentController.text,
                      rating: selectRate.toString()
                    );
                  },
                  maxLines: 1,
                  borderColor: const Color(0xffE3E5E5),
                  controller: commentController,
                  viewDropDownRates: true,
                  dropDownValue: selectRate,
                  dropDownOnChanged: (String? value){
                    setState(() {
                      selectRate = value!;
                    });
                  },
                  dropDownItems: ['1', '2', '3', '4', '5'].map((e) {
                    return DropdownMenuItem(
                      value: e.toString(),
                      child: Row(
                        children: [
                          Text(
                            e.toString(),
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1B1B1B)),
                          ),
                          const Icon(
                            Icons.star,
                            color: Color(0xffE6007E),
                            size: 16,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                  dropDownHint: Row(
                    children: [
                      Text(
                        "${selectRate.toString()} ",
                        style:const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1B1B1B)),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffE6007E),
                        size: 16,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          );
        }),
    );
  }
}
