import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FaqLoadingWidget extends StatelessWidget {
  const FaqLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              ),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
