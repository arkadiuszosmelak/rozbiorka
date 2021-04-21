import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DialogRatedUser extends StatefulWidget {
  DialogRatedUser(this.idOrder, this.seller);
  final String idOrder;
  final String seller;

  @override
  _DialogRatedUserState createState() => _DialogRatedUserState();
}

class _DialogRatedUserState extends State<DialogRatedUser> {
  int rating = 0;

  Future updateRatingStatus() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.idOrder)
        .update({'rating': true});
  }

  Future updateUserRating(int i) async {
    var document =
        FirebaseFirestore.instance.collection('users').doc(widget.seller);
    var getDoc = await document.get();
    List<dynamic> ratingList = getDoc.data()['ratingList'];
    ratingList.add(i);
    // print(ratingList);
    document.update({'ratingList': ratingList});
  }

  Widget stars(int i) {
    return IconButton(
      icon: rating >= i
          ? Icon(
              Icons.star,
              color: Colors.yellow,
            )
          : Icon(Icons.star_outline),
      onPressed: () => setState(
        () {
          rating = i;
          print(rating);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Oceń sprzedawcę',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      children: [
        Text(
          'Oceń sprzedawcę uwzgledniając komunikatywność oraz czas wysyłki.',
          textAlign: TextAlign.center,
        ),
        // IconButton(
        //   icon: rating != 0 ? Icon(Icons.star) : Icon(Icons.star_outline),
        //   onPressed: () => setState(
        //     () {
        //       rating = 5;
        //       print(rating);
        //     },
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            stars(1),
            stars(2),
            stars(3),
            stars(4),
            stars(5),
          ],
        ),
        // Text('UWAGA! Oceniasz sprzedającego, nie p')
        FlatButton(
          child: Text(
            'Oceń',
            style: TextStyle(
                color:
                    rating == 0 ? Colors.grey : Theme.of(context).primaryColor),
          ),
          onPressed: rating == 0
              ? null
              : () {
                  updateRatingStatus();
                  updateUserRating(rating);
                  Navigator.pop(context);
                },
        ),
      ],
    );
  }
}
