import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rozbiorka/widgets/chats/message_bubble.dart';
import 'package:rozbiorka/widgets/chats/new_message.dart';
import 'package:rozbiorka/screens/this_user.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
    this.idConversation,
  );
  final String idConversation;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final thisUser = FirebaseAuth.instance.currentUser;
  final ScrollController _controller = ScrollController();

  String urlUserAvatar;

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 100),
      () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    var allMessage = FirebaseFirestore.instance
        .collection('messages')
        .doc(widget.idConversation)
        .collection('message')
        .orderBy('createdAt');
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            FutureBuilder(
              future: ThisUser().getTextFromFile(
                  thisUser.displayName == widget.idConversation.split('_')[1]
                      ? widget.idConversation.split('_')[0]
                      : widget.idConversation.split('_')[1]),
              initialData: "https://i.stack.imgur.com/l60Hf.png",
              builder: (BuildContext context, AsyncSnapshot<String> text) {
                return SingleChildScrollView(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(text.data),
                    ));
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text(thisUser.displayName == widget.idConversation.split('_')[1]
                ? widget.idConversation.split('_')[0]
                : widget.idConversation.split('_')[1]),
          ],
        )),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: allMessage.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Coś poszło nie tak');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    int previousTimestamp = 0;
                    var tmp = DateTime.now().millisecondsSinceEpoch;
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        controller: _controller,
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          previousTimestamp = previousTimestamp == 0
                              ? document.data()['createdAt'] - 100000000000
                              : tmp;
                          tmp = document.data()['createdAt'];
                          return MessageBubble(
                            document.data()['message'],
                            document.data()['username'],
                            document.data()['createdAt'],
                            previousTimestamp,
                            document.data()['username'] == thisUser.displayName,
                            key: ValueKey(document.id),
                          );
                        }).toList(),
                      ),
                    );
                  }),
            ),
            NewMessage(widget.idConversation, _controller),
          ],
        ));
  }
}
