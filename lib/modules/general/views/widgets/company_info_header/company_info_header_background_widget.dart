import 'package:flutter/material.dart';

class CompanyInfoHeaderBackgroundWidget extends StatelessWidget {
  final String headerImage;
  final double backgroundHeight;
  const CompanyInfoHeaderBackgroundWidget(
      {super.key, required this.headerImage, required this.backgroundHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: backgroundHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(headerImage), fit: BoxFit.fill)),
        child: Stack(
          children: [
            Positioned.fill(
                child: Column(
              children: [
                Container(
                  height: backgroundHeight / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5],
                    ),
                  ),
                ),
                Container(
                    height: backgroundHeight / 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5],
                      ),
                    )),
              ],
            ))
          ],
        ));
  }
}
