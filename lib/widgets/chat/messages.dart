import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './chat_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);
  @override
  Future<User?> _userId() async {
    return await FirebaseAuth.instance.currentUser;
  }

  Widget build(BuildContext context) {
    var currentUser = _userId();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder: (ctx,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapshot) {
          return ListView.builder(
            reverse: true,
            itemCount:
                chatSnapshot.data == null ? 0 : chatSnapshot.data!.docs.length,
            itemBuilder: (ctx, index) {
              return Row(
                children: [
                  ChatBubble(chatSnapshot.data!.docs[index]['text'],
                      currentUser == chatSnapshot.data!.docs[index]['userId']),
                ],
              );
            },
          );
        });
  }
}
