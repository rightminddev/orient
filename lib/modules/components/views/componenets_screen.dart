import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';
import 'package:orient/constants/app_sizes.dart';

class ComponenetsScreen extends StatelessWidget {
  const ComponenetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/buttons');
                  },
                  child: Text('buttons'),
                ),
                SizedBox(height: AppSizes.s12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/image_with_title');
                  },
                  child: Text('image with title'),
                ),
                SizedBox(height: AppSizes.s12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/comment_widget');
                  },
                  child: Text('comment widget'),
                ),
                SizedBox(height: AppSizes.s12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/order_widget');
                  },
                  child: Text('orders widget'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
