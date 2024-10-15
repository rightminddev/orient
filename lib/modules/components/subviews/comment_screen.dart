import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/comment_widget.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CommentWidget(
                image:
                    'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ',
                name: 'Ali Ahmed',
                date: '10/04/2022 08:15:36 PM',
                comment:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              ),
              CommentWidget(
                image:
                    'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ',
                name: 'Ali Ahmed',
                date: '10/04/2022 08:15:36 PM',
                isVerified: true,
                comment:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                rate: '5',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
