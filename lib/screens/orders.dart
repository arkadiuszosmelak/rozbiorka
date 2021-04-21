import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rozbiorka/screens/details_order.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin {
  TabController _typeOfOrderTabController;

  final _user = FirebaseAuth.instance.currentUser;
  Query _orders = FirebaseFirestore.instance
      .collection('orders')
      .orderBy('timestamp', descending: true);

  @override
  void initState() {
    super.initState();

    _typeOfOrderTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _typeOfOrderTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TabBar(
            controller: _typeOfOrderTabController,
            indicatorColor: Colors.indigo,
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Container(
                    width: screenWidth * 0.4,
                    child: Center(child: Text('Kupione'))),
              ),
              Tab(
                child: Container(
                    width: screenWidth * 0.4,
                    child: Center(child: Text('Sprzedane'))),
              ),
            ],
          ),
        ),
        Expanded(
          // height: screenHeight,
          // margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _typeOfOrderTabController,
            children: <Widget>[
              orders('buyer'),
              orders('seller'),
            ],
          ),
        )
      ],
    );
  }

  Widget orders(String buyerOrSeller) {
    return StreamBuilder<QuerySnapshot>(
      stream: _orders.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Coś poszło nie tak');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  var listPerfume = document.data().keys.toList();
                  listPerfume.remove('seller');
                  listPerfume.remove('buyer');
                  listPerfume.remove('timestamp');
                  listPerfume.remove('priceOrder');
                  listPerfume.remove('atomizerCost');
                  listPerfume.remove('rating');
                  listPerfume.remove('id');
                  return Container(
                    child: _user.displayName == document.data()[buyerOrSeller]
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsOrder(
                                        document.data(), listPerfume),
                                  ),
                                ),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${buyerOrSeller == document.data()['seller'] ? document.data()['buyer'] : document.data()['seller']}'),
                                            Text(
                                                '${document.data()['priceOrder'].toStringAsFixed(2)} zł'),
                                          ],
                                        ),
                                        subtitle: Text(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    document
                                                        .data()['timestamp'])
                                            .toString()
                                            .substring(
                                                0,
                                                DateTime.fromMillisecondsSinceEpoch(
                                                            document.data()[
                                                                'timestamp'])
                                                        .toString()
                                                        .length -
                                                    7)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
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

// @override
// Widget build(BuildContext context) {
//   final _user = FirebaseAuth.instance.currentUser;
//   Query _orders = FirebaseFirestore.instance
//       .collection('orders')
//       .orderBy('timestamp', descending: true);

//   var _expanded = false;

//

//   }
// }
