import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Column(
          children: [
            Container(
              height: 300,
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Container(
                    child: user.email == document.data()['email']
                        ? Column(
                            children: [
                              Text(document.data()['username']),
                              Text(document.data()['email']),
                              // Text(document.data()['image_url']),
                              Image.network(document.data()['image_url']),
                            ],
                          )
                        : Text(''),
                  );
                }).toList(),
              ),
            ),
            RaisedButton(
              child: Text('Wyloguj'),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        );
      },
    );
  }
}

// final user = FirebaseAuth.instance.currentUser;
//           RaisedButton(
//             child: Text('Wyloguj'),
//             onPressed: () => FirebaseAuth.instance.signOut(),
//           ),
