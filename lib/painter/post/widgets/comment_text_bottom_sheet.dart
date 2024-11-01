import 'package:flutter/material.dart';

class CommentTextBottomSheet extends StatelessWidget {
  const CommentTextBottomSheet({super.key});

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
        SizedBox(width: 10,),
        Text('Comment',style: TextStyle(color: Color(0xFFE6007E),fontWeight: FontWeight.w500,fontSize: 12),),
        SizedBox(width: 10,),
        Container(
          height: 2,
          width: 100,
          color: Colors.grey,
        ),
      ],
    );
  }
}
