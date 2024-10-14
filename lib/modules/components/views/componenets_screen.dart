import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/common_modules_widgets/main_app_fab_widget/main_app_fab.widget.dart';

class ComponenetsScreen extends StatelessWidget {
  const ComponenetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/buttons');
                },
                child: Text('buttons'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
