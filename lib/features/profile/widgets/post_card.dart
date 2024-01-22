import 'package:flutter/material.dart';
import 'package:thread_app/common/utils/helpers.dart';
import 'package:thread_app/common/models/thread.dart';

class postCard extends StatelessWidget {
  const postCard({
    super.key,
    required this.thread,
  });
  final Thread thread;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        thread.user.firstName,
                        style: applyGoogleFontToText(20),
                      ),
                      Spacer(),
                      Text(thread.createdAt),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    thread.content,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    Icon(Icons.favorite),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.message),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
