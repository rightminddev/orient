import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewCommentText extends StatelessWidget {
  const AddNewCommentText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: 100,
          color: Colors.grey,
        ),
        const SizedBox(width: 10,),
        const Text('Add New Comment',style: TextStyle(color: Color(0xFFE6007E)),),
        const SizedBox(width: 10,),
        Container(
          height: 2,
          width: 100,
          color: Colors.grey,
        ),
      ],
    );
  }
}
