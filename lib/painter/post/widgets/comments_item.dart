import 'package:flutter/material.dart';

import '../data/models/comments_model/get_comment_model.dart';
import '../data/models/post_response.dart';

// orient/ painter/ post/ widgets/ comments_list. dart
class CommentsItem extends StatelessWidget {
  const CommentsItem({super.key, required this.comments, required this.user});

  final Comments comments;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0,
                offset: const Offset(0, 1),
                blurRadius: 10)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://picsum.photos/200'),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ${user.name}',
                        style: const TextStyle(
                            color: Color(0xFFE6007E),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Text(
                        comments.createdAt ?? '',
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 230,
                      child: Text(
                        comments.content ?? '',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
