import 'package:flutter/material.dart';
import 'package:thread_app/common/utils/helpers.dart';
import 'package:thread_app/common/models/thread.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.thread,
  });

  final Thread thread;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(thread.user.image),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      thread.user.username,
                      style: applyGoogleFontToText(20),
                    ),
                    // Text(thread.createdAt),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.more_horiz),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                thread.content,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 5,
              ),
              if (thread.image != null)
                Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            thread.image.toString(),
                          ),
                        ))),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  thread.isLiked
                      ? Icon(Icons.favorite)
                      : Icon(
                          Icons.favorite_outline,
                          color: thread.isLiked ? Colors.red : null,
                        ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.message),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text('${thread.likesCount} likes',
                  style: Theme.of(context).textTheme.titleSmall),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
