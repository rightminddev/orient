import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/shared_more_screen/faq/logic/faq_model.dart';
import 'package:orient/modules/shared_more_screen/faq/logic/get_faq_model.dart';
import 'package:orient/modules/shared_more_screen/faq/view/faq_loading_widget.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<FaqItem> faqItems = [
    FaqItem(
      question: "What countries do you ship to?",
      answer: "We ship worldwide. Shipping times may vary depending on the destination.",
    ),
    FaqItem(
      question: "What is your return/exchange policy?",
      answer: "Another pressing question that every retail brand is tired of answering: how do you handle returns and exchanges?\n\n"
          "Make sure that you're clear about:\n"
          "- Which products can be returned\n"
          "- How long the return period lasts\n"
          "- What the process involves\n"
          "- How returns are issued\n"
          "- How returns are shipped back\n"
          "- The exchange process and when exchanges are an option",
    ),
    FaqItem(
      question: "How long will it take to get my order?",
      answer: "Delivery times vary depending on your location and shipping method selected.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => FaqModelProvider()..getFaq(context),
    child: Consumer<FaqModelProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title:  Text(AppStrings.faqs.tr().toUpperCase(), style: const TextStyle(fontSize: 16, color: Color(0xff224982), fontWeight: FontWeight.w700),),
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Color(0xff224982),)),
            backgroundColor: Colors.transparent,
          ),
          body: (value.faqModel != null)?ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: value.faqModel!.page!.questions!.length,
            itemBuilder: (context, index) {
              return FaqTile(
                item: value.faqModel!.page!.questions![index],
              );
            },
          ):ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: 3,
            itemBuilder: (context, index) {
              return const FaqLoadingWidget();
            },
          ),
        );
      },
    ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class FaqTile extends StatefulWidget {
  final Questions item;

  const FaqTile({Key? key, required this.item}) : super(key: key);

  @override
  _FaqTileState createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F8FA), // Light blue background like in the image
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // Top shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -1), // Slightly offset upwards
              blurRadius: 4,
              spreadRadius: 0,
            ),
            // Bottom shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1), // Slightly offset downwards
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          title: Text(
            widget.item.question??"",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1B1B1B),
            ),
          ),
          iconColor: Colors.grey,
          collapsedIconColor: Colors.grey,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          collapsedBackgroundColor: Colors.transparent,
          children: [
            Text(
              widget.item.answer ?? "",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF464646),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
