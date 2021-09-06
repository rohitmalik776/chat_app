import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/ChatScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat/vjUcO4pNmAAFbRTOlaEw/messages')
              .snapshots(),
          builder: (ctx,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapshot) {
            return ListView.builder(
              itemCount: chatSnapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
                return Text(chatSnapshot.data!.docs[index]['text']);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chat/vjUcO4pNmAAFbRTOlaEw/messages')
              .add({'text': 'A message!'});
        },
      ),
    );
  }
}
