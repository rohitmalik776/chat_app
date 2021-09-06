import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/ChatScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(width: 8),
                      Text('logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (identifier) {
              if (identifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat/vjUcO4pNmAAFbRTOlaEw/messages')
              .snapshots(),
          builder: (ctx,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapshot) {
            return ListView.builder(
              itemCount:
                  chatSnapshot.hasData ? chatSnapshot.data!.docs.length : 0,
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
