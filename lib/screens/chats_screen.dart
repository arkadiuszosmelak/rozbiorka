import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users =
        FirebaseFirestore.instance.collection('messages');
    var mediaQuery = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Coś poszło nie tak');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Column(
          children: [
            Container(
              height: 500,
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Container(
                    child: user.displayName == document.data()['user1'] ||
                            user.displayName == document.data()['user2']
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  bool user1;
                                  try {
                                    var tmp = await users
                                        .doc(document.data()['user1'] +
                                            '_' +
                                            document.data()['user2'])
                                        .get();
                                    print(tmp.data()['user1']);
                                    user1 = true;
                                  } catch (_) {
                                    user1 = false;
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatScreen(document.data()[
                                              user1 ? 'user1' : 'user2'] +
                                          '_' +
                                          document.data()[
                                              user1 ? 'user2' : 'user1']);
                                    }),
                                  );
                                },
                                child: Container(
                                  color: Colors.white10,
                                  width: mediaQuery.width,
                                  height: mediaQuery.height * 0.1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: mediaQuery.height * 0.02,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(document
                                            .data()[document.data()['user1'] ==
                                                user.displayName
                                            ? 'avatar2'
                                            : 'avatar1']),
                                        maxRadius: 22,
                                        minRadius: 22,
                                      ),
                                      SizedBox(
                                        width: mediaQuery.height * 0.015,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              (user.displayName ==
                                                      document.data()['user1']
                                                  ? document.data()['user2']
                                                  : document.data()['user1']),
                                              style: TextStyle(fontSize: 16)),
                                          Text(document
                                                      .data()['lastMessage']
                                                      .replaceAll(
                                                          '\n', '       ')
                                                      .length >
                                                  35
                                              ? document
                                                      .data()['lastMessage']
                                                      .replaceAll(
                                                          '\n', '       ')
                                                      .substring(
                                                          0,
                                                          document
                                                                      .data()[
                                                                          'lastMessage']
                                                                      .length <
                                                                  35
                                                              ? document
                                                                  .data()[
                                                                      'lastMessage']
                                                                  .length
                                                              : 35) +
                                                  '...'
                                              : document
                                                  .data()['lastMessage']
                                                  .replaceAll('\n', '       ')),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
