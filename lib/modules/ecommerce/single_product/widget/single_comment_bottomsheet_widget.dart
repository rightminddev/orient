import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_sizes_widget.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/comment_widget.dart';

class SingleCommentBottomsheetWidget extends StatefulWidget {
  const SingleCommentBottomsheetWidget({super.key});

  @override
  State<SingleCommentBottomsheetWidget> createState() => _SingleCommentBottomsheetWidgetState();
}

class _SingleCommentBottomsheetWidgetState extends State<SingleCommentBottomsheetWidget> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: [
             Color(0xffFDFDFD),
             Color(0xffF4F7FF),
          ],
          stops: [0.0, 0.5],
        ),
      ),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.72,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Center(
            child: Container(
              height: 5,
              width: 63,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xffB9C0C9)
              ),
            ),
          ),
          const SizedBox(height: 30,),
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
                  child: Text("Comments".toUpperCase(), style:const TextStyle(color: Color(0xffEE3F80), fontSize: 14, fontWeight: FontWeight.w600),)),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xffE0E0E0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.47,
            child: ListView.separated(
              shrinkWrap: true,
                reverse: false,
                itemBuilder: (context, index)=> CommentWidget(
                  isImageUrl: true,
                  image: "https://t4.ftcdn.net/jpg/07/08/47/75/360_F_708477508_DNkzRIsNFgibgCJ6KoTgJjjRZNJD4mb4.jpg",
                  name: 'Mohamed Ali'.toUpperCase(),
                  nameFontSize: 12,
                  dateFontSize: 11,
                  commentFontSize: 11,
                  commentFontWeight: FontWeight.w400,
                  dateFontWeight: FontWeight.w400,
                  date: '10/04/2022 08:15:36 PM',
                  comment: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                  isVerified: true,
                  rate: "5",
                ),
                separatorBuilder: (context, index)=>const SizedBox.shrink(),
                itemCount: 15
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xffE0E0E0),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  child: Text("Add New Comment".toUpperCase(), style:const TextStyle(color: Color(0xffEE3F80), fontSize: 12, fontWeight: FontWeight.w600),)),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xffE0E0E0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          defaultCommentTextFormField(
            hintText: "Type your message".toUpperCase(),
            maxLines: 1,
            controller: commentController,
            viewDropDownRates: true,
            dropDownItems: ['1', '2', '3'].map((e){
              return DropdownMenuItem(
                value: e.toString(),
                child: Row(
                  children: [
                    Text(
                      e.toString(),
                      style:const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1B1B1B)
                      ),
                    ),
                    const Icon(Icons.star, color: Color(0xffE6007E), size: 16,)
                  ],
                ),
              );
            }).toList(),
            dropDownHint: const Row(
              children: [
                Text(
                  "4 ",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1B1B1B)
                  ),
                ),
                Icon(Icons.star, color: Color(0xffE6007E), size: 16,)
              ],
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }

}
