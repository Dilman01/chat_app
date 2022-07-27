// ignore_for_file: prefer_const_constructors

import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final User? userData = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapShot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index].data()['text'],
            chatDocs[index].data()['username'],
            chatDocs[index].data()['userImage'],
            chatDocs[index].data()['userId'] == userData!.uid,
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
    // StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection('chat')
    //       .orderBy(
    //         'createdAt',
    //         descending: true,
    //       )
    //       .snapshots(),
    //   builder: (context, chatSnapshot) {
    //     if (chatSnapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     final chatDocs = chatSnapshot.data!.docs;
    //     return FutureBuilder(
    //       future: FirebaseAuth.instance.currentUser,
    //       builder: (context, futureSnapshot) => ListView.builder(
    //         reverse: true,
    //         itemCount: chatDocs.length,
    //         itemBuilder: (context, index) => MessageBubble(
    //           chatDocs[index]['text'],
    //           chatDocs[index]['userId'],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
