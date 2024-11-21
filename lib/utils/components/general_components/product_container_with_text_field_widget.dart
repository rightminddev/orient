import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/utils/cached_network_image_widget.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/media_query_values.dart';

class ProductContainerWithTextFieldWidget extends StatefulWidget {
  const ProductContainerWithTextFieldWidget(
      {super.key,
      this.stock,
      this.containerColor,
      this.bookmarkColor,
      this.borderRadius,
      this.boxShadow,
      this.title,
      this.price,
      this.unit,
      this.onQuantitySubmitted,
      this.imageUrl});

  final Color? containerColor;
  final Color? bookmarkColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final String? title;
  final String? price;
  final void Function(String)? onQuantitySubmitted;
  final String? unit;
  final int? stock;

  final String? imageUrl;

  @override
  State<ProductContainerWithTextFieldWidget> createState() =>
      _ProductContainerWithTextFieldWidgetState();
}

class _ProductContainerWithTextFieldWidgetState
    extends State<ProductContainerWithTextFieldWidget> {
  late final TextEditingController controller;
  final ValueNotifier<bool> isStockValueError = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: (widget.stock ?? 0).toString());
  }

  @override
  void dispose() {
    controller.dispose();
    isStockValueError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isStockValueError,
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: ShapeDecoration(
            color: widget.containerColor ?? const Color(0xffFFFFFF),
            shadows: widget.boxShadow,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    value == true ? Color(AppColors.red1) : Colors.transparent,
                width: value == true ? 2 : 0,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetWokImageWidget(
                url: widget.imageUrl!,
                boxFit: BoxFit.contain,
                height: context.width * 0.2,
                width: context.width * 0.2,
                radius: 16,
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color(0xffE6007E),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.price} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xff1B1B1B),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '/ ${widget.unit}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            // decoration: TextDecoration.lineThrough,
                            // decorationColor: Colors.grey,
                            // decorationThickness: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStrings.units.tr(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              // decoration: TextDecoration.lineThrough,
                              // decorationColor: Colors.grey,
                              // decorationThickness: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: defaultTextFormField(
                            controller: controller,
                            hasShadows: false,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final isInt = int.tryParse(value);

                              if (isInt != null &&
                                  isInt >= 0 &&
                                  widget.onQuantitySubmitted != null) {
                                isStockValueError.value = false;
                                widget.onQuantitySubmitted!(value);
                              } else if (isInt == null &&
                                  widget.onQuantitySubmitted != null) {
                                isStockValueError.value = true;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /*
              Expanded(
                child: TextField(
                  controller: controller,
                  // expands: true,
                  textAlignVertical: TextAlignVertical.center,
                  enableInteractiveSelection: true,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  // maxLines: null,
                  // minLines: null,
                  style: TextStyle(
                    color: Color(0xFF1B1B1B),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.11,
                  ),
                  onChanged: (value) {
                    final isInt = int.tryParse(value);

                    if (isInt != null &&
                        isInt >= 0 &&
                        widget.onQuantitySubmitted != null) {
                      isStockValueError.value = false;
                      widget.onQuantitySubmitted!(value);
                    } else if (isInt == null &&
                        widget.onQuantitySubmitted != null) {
                      isStockValueError.value = true;
                    }
                  },
                  //   initialValue: '0',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ),
              */
            ],
          ),
        );
      },
    );
  }
}
