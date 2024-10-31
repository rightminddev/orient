import 'package:flutter/material.dart';

class ShowImageWidget extends StatelessWidget {
  final int index;
  final String mediaItem;

  const ShowImageWidget({
    required this.index,
    required this.mediaItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: index == -1
            ? BorderRadius.circular(4)
            : BorderRadius.only(
                topLeft: index == 0 ? const Radius.circular(4) : Radius.zero,
                topRight: index == 1 ? const Radius.circular(4) : Radius.zero,
                bottomLeft: index == 2 ? const Radius.circular(4) : Radius.zero,
                bottomRight:
                    index == 3 ? const Radius.circular(4) : Radius.zero,
              ),
        child: Image.network(mediaItem,  fit:index == -1 ?  BoxFit.fill : BoxFit.cover));
  }
}
