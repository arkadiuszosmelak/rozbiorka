import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rozbiorka/screens/this_user.dart';
import 'package:rozbiorka/screens/user_orders.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'Witaj!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              user.displayName,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        FutureBuilder(
          future: ThisUser().getTextFromFile(user.displayName),
          initialData: "https://i.stack.imgur.com/l60Hf.png",
          builder: (BuildContext context, AsyncSnapshot<String> text) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(text.data),
                minRadius: 100,
                maxRadius: 100,
              ),
            );
          },
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserOrders(),
                  ),
                );
              },
              child: Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Card(
                    child: Center(
                      child: Text('Moje ogłoszenia'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Card(
                    color: Colors.indigo[200],
                    child: Center(
                      child: Text('Wyloguj'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
