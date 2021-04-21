import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class NewMessage extends StatefulWidget {
  NewMessage(this.idConversation, this.controller);
  final String idConversation;
  final ScrollController controller;
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  @override
  Widget build(BuildContext context) {
    void _sendMessage() async {
      // FocusScope.of(context).unfocus();

      final user = FirebaseAuth.instance.currentUser;

      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.displayName)
          .get();
      FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.idConversation)
          .collection('message')
          .add({
        'message': _enteredMessage,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'username': userData.data()['username'],
      });

      Timer(
        Duration(milliseconds: 100),
        () => widget.controller
            .jumpTo(widget.controller.position.maxScrollExtent),
      );

      FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.idConversation)
          .update({
        'lastModified': DateTime.now().millisecondsSinceEpoch,
        'lastMessage': _enteredMessage,
      });
      _controller.clear();
      _enteredMessage = '';
    }

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) {
          Timer(
            Duration(milliseconds: 20),
            () => widget.controller
                .jumpTo(widget.controller.position.maxScrollExtent),
          );
        }
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300],
                ),
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 1,
                  autocorrect: true,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                    filled: false,
                    border: InputBorder.none,
                    hintText: 'Aa',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  },
                ),
              ),
              IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.send),
                  onPressed:
                      _enteredMessage.trim().isEmpty ? null : _sendMessage),
            ],
          ),
        );
      },
    );
  }
}
