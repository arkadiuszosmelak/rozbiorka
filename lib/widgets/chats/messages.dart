// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // import './message_bubble.dart';

// class Messages extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final user = FirebaseAuth.instance.currentUser;
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('chat')
//             .orderBy('createdAt', descending: true)
//             // .orderBy('timestamp')
//             .snapshots(),
//         builder: (ctx, chatSnapshot) {
//           if (chatSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final chatDocs = chatSnapshot.data.docs;

//           return Text(''
//               // reverse: true,
//               // itemCount: chatSnapshot.data.docs.length,
//               // itemBuilder: (ctx, index) => MessageBubble(
//               //   chatDocs[index].data()['text'],
//               //   chatDocs[index].data()['username'],
//               //   chatDocs[index].data()['userId'] == user.uid,
//               //   key: ValueKey(chatDocs[index].id),
//               // ),
//               );
//         });
//   }
// }
