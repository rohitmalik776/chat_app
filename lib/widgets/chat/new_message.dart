import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController _editingController = TextEditingController();
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    _editingController.clear();
    FirebaseFirestore.instance.collection('chat').add(
      {'text': _userMessage, 'createdAt': Timestamp.now(), 'userId': 'k'},
    );
  }

  String _userMessage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _editingController,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (newMessage) {
                setState(() {
                  _userMessage = newMessage;
                });
              },
            ),
          ),
          ElevatedButton(
            child: Icon(
              Icons.send,
            ),
            onPressed: _userMessage.isEmpty ? null : () => _sendMessage(),
          )
        ],
      ),
    );
  }
}
