// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isMe, {
    super.key,
    required this.mkey,
  });

  final Key mkey;
  final String message;
  final String username;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Color.fromARGB(255, 236, 69, 35)
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.white
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.white
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImage,
            ),
          ),
        ),
      ],
    );
  }
}
