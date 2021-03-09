import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chats/messages.dart';
import '../widgets/chats/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   final fbm = FirebaseMessaging.instance;
  //   fbm.requestPermission();
  //   // fbm.configure();

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');

  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   });
  //   fbm.subscribeToTopic('chat');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Flutter chat'),
      //   actions: [
      //     DropdownButtonHideUnderline(
      //       child: DropdownButton(
      //           icon: Icon(
      //             Icons.more_vert,
      //             color: Theme.of(context).primaryIconTheme.color,
      //           ),
      //           items: [
      //             DropdownMenuItem(
      //               child: Container(
      //                 child: Row(
      //                   children: [
      //                     Icon(Icons.exit_to_app),
      //                     SizedBox(
      //                       width: 8,
      //                     ),
      //                     Text('Logout')
      //                   ],
      //                 ),
      //               ),
      //               value: 'logout',
      //             ),
      //           ],
      //           onChanged: (itemIdentifier) {
      //             if (itemIdentifier == 'logout') {
      //               FirebaseAuth.instance.signOut();
      //             }
      //           }),
      //     )
      //   ],
      // ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Firestore.instance
      //         .collection('/chats/pD9m5YTPAbTQvqwo0zQF/messages')
      //         .add({'text': 'This was added by clicking the button'});
      //   },
      // ),
    );
  }
}
