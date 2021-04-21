import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'package:rozbiorka/screens/dialog_order_confirmation.dart';
import 'zamowienie.dart' as zamowienie;

class EndOrder extends StatefulWidget {
  EndOrder(this.idAdvertisement);
  final String idAdvertisement;
  @override
  _EndOrderState createState() => _EndOrderState();
}

class _EndOrderState extends State<EndOrder> {
  var v2;
  var v4;
  double costAtomizer = 3.00 * zamowienie.zamowienie.length;
  double costDelivery = 13;
  final user = FirebaseAuth.instance.currentUser;
  final ScrollController _scrollController = ScrollController();

  Future addPerfumeToDb(index) async {
    //dodanie pierwszego pefumu z zamowienia do bazy danych
    if (index == 0) {
      await FirebaseFirestore.instance.collection('orders').doc('$v2').set({
        'seller': zamowienie.username,
        'buyer': user.displayName,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'priceOrder': pricePerfume() + costDelivery + costAtomizer,
        'atomizerCost': costAtomizer,
        'rating': false,
        'id': v2,
        zamowienie.zamowienie.keys.toList()[index].replaceAll('.', ''): {
          'count': zamowienie.zamowienie.values.toList()[index]['count'],
          'price': zamowienie.zamowienie.values.toList()[index]['price'],
        }
      });
      //dodanie kolejnych pefum z zamowienia do bazy danych
    } else {
      await FirebaseFirestore.instance.collection('orders').doc('$v2').update({
        zamowienie.zamowienie.keys.toList()[index].replaceAll('.', ''): {
          'count': zamowienie.zamowienie.values.toList()[index]['count'],
          'price': zamowienie.zamowienie.values.toList()[index]['price'],
        }
      });
    }
    //pobranie dostepnej pojemnosci perfumu
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('advertisement')
        .doc(widget.idAdvertisement);
    String fullCapacity;

    await documentReference.get().then((value) {
      fullCapacity = value
          .data()['perfume']
              [zamowienie.zamowienie.keys.toList()[index].replaceAll('.', '')]
              ['capacity']
          .toString();
    });

    //aktualizacja pojemnosci perfumu
    documentReference.update({
      'perfume.${zamowienie.zamowienie.keys.toList()[index].replaceAll('.', '')}.capacity':
          (int.parse(fullCapacity) -
                  zamowienie.zamowienie.values.toList()[index]['count'])
              .toString()
    });
  }

  Future createMessage() async {
    String newMessage = '';
    for (int i = 0; i < zamowienie.zamowienie.length; i++) {
      addPerfumeToDb(i);
      String namePerfume = zamowienie.zamowienie.keys.toList()[i];
      String capacity = zamowienie.zamowienie.values
          .toList()[i]
          .values
          .toList()[0]
          .toString();
      newMessage += namePerfume + ' ' + capacity + ' ml\n';
    }
    var avatar1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.displayName)
        .get();
    var avatar2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(zamowienie.username)
        .get();
    String urlAvatar1 = avatar1.data()['image_url'];
    String urlAvatar2 = avatar2.data()['image_url'];
    // sprawdza czy bylo juz takie id (aby nie powtorzyc rozmowy z tym samym uzykownikiem)
    DocumentSnapshot tmp;
    DocumentSnapshot tmp1;
    String idMessage;
    bool exist;

    tmp = await FirebaseFirestore.instance
        .collection('messages')
        .doc(user.displayName + '_' + zamowienie.username)
        .get();
    tmp1 = await FirebaseFirestore.instance
        .collection('messages')
        .doc(zamowienie.username + '_' + user.displayName)
        .get();
    if (tmp.exists) {
      exist = true;
      idMessage = user.displayName + '_' + zamowienie.username;
    } else {
      tmp1.exists ? exist = true : exist = false;
      idMessage = zamowienie.username + '_' + user.displayName;
    }
    !exist
        ? FirebaseFirestore.instance.collection('messages').doc(idMessage).set({
            'avatar1': urlAvatar1,
            'avatar2': urlAvatar2,
            'lastMessage': newMessage,
            'lastModified': DateTime.now().millisecondsSinceEpoch,
            'user1': user.displayName,
            'user2': zamowienie.username
          })
        : FirebaseFirestore.instance
            .collection('messages')
            .doc(idMessage)
            .update({
            'lastMessage': newMessage,
            'lastModified': DateTime.now().millisecondsSinceEpoch,
          });

    FirebaseFirestore.instance
        .collection('messages')
        .doc(idMessage)
        .collection('message')
        .doc(v4)
        .set({
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'message': newMessage,
      'username': user.displayName
    });
  }

  double pricePerfume() {
    double price = 0;
    for (int i = 0; i < zamowienie.zamowienie.length; i++) {
      price += zamowienie.zamowienie.values.toList()[i]['price'];
    }
    return price;
  }

  Widget tableWidget(String first, String second, String third, Color color) {
    return Table(
      border: TableBorder.all(color: Colors.white60),
      columnWidths: {
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
      },
      children: [
        TableRow(children: [
          Container(
            color: color,
            height: 50,
            child: Center(
              child: Text(
                first,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Container(
            color: color,
            height: 50,
            child: Center(
              child: Text(
                second,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Container(
            color: color,
            height: 50,
            child: Center(
              child: Text(
                third,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    var uuid = Uuid();
    // nowe id dla każdego ogłoszenia
    v2 = uuid.v1();
    // nowe id dla każdej wiadomosci
    v4 = uuid.v4();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podsumowanie'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tableWidget('Nazwa perfum', 'Ilość', 'Cena', Color(0xff5c6bc0)),
              Container(
                height: zamowienie.zamowienie.length > 5
                    ? 250.0
                    : 50.0 * zamowienie.zamowienie.length,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: zamowienie.zamowienie.length,
                    itemBuilder: (context, index) {
                      return tableWidget(
                        zamowienie.zamowienie.keys.toList()[index],
                        '${zamowienie.zamowienie.values.toList()[index]['count']} ml',
                        '${zamowienie.zamowienie.values.toList()[index]['price'].toStringAsFixed(2)} zł',
                        Color(0xff9fa8da),
                      );
                    },
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    tableWidget(
                      'Dostawa',
                      '1',
                      '${costDelivery.toStringAsFixed(2)} zł',
                      Color(0xff7986cb),
                    ),
                    tableWidget(
                      'Atomizer',
                      '${zamowienie.zamowienie.length}',
                      '${costAtomizer.toStringAsFixed(2)} zł',
                      Color(0xff7986cb),
                    ),
                    SizedBox(height: 10),
                    tableWidget(
                      'Podsumowanie',
                      '',
                      '${(pricePerfume() + costDelivery + costAtomizer).toStringAsFixed(2)} zł',
                      Color(0xff5c6bc0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: MediaQuery.of(context).size.width * 0.003,
                          color: Colors.grey),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                    child: Text(
                      'Wróć',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  createMessage();
                  showDialog(
                    context: context,
                    builder: (_) => DialogOrderConfiration(),
                    barrierDismissible: false,
                  );
                },
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                    child: Text(
                      'Potwierdź',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
