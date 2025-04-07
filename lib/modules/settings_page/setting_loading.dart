import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Shimmer effect for profile picture
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(height: 20),
              // Shimmer effect for text (Name)
              Container(
                width: 200,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              // Shimmer effect for text (Subtitle)
              Container(
                width: 150,
                height: 15,
                color: Colors.white,
              ),
              const SizedBox(height: 20,),
              ListView(
                children: List.generate(7, (index) => _buildShimmerListTile()),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildShimmerListTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color(0xffC9CFD2).withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xff9B9B9B).withOpacity(0.1),
              ),
            ),
            title: Container(
              height: 10,
              width: 100,
              color: Colors.white,
            ),
            trailing: Container(
              height: 10,
              width: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}