import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookmarkLoadingScreen extends StatelessWidget {
  const BookmarkLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey.shade300,
                height: 104.0,
                width: 100,
              ),
            ),
            SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 13,
                      width: 100,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 13,
                          width: 50,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(width: 17),
                        Container(
                          height: 13,
                          width: 50,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 13,
                          width: 30,
                          color: Colors.grey.shade300,
                        ),
                        Spacer(),
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
