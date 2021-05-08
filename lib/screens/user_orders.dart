import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rozbiorka/screens/decorate_time.dart';
import 'package:rozbiorka/screens/show_advertisement_images.dart';

enum Options { edit, delete }

class UserOrders extends StatelessWidget {
  final thisUser = FirebaseAuth.instance.currentUser.displayName;

  @override
  Widget build(BuildContext context) {
    Query advertisement = FirebaseFirestore.instance
        .collection('advertisement')
        .orderBy('timestamp', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Twoje ogłoszenia'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: advertisement.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Coś poszło nie tak'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                var numberPerfume;
                var perfume;
                if (document.data()['perfume'] == null) {
                } else {
                  numberPerfume =
                      document.data()['perfume'].values.toList().length;
                  perfume = document.data()['perfume'].values.toList();
                }
                var images = document.data()['images'];

                for (var i = 0;
                    i < document.data()['perfume'].values.toList().length;
                    i++) {
                  if (perfume[i]['capacity'] == '0') {
                    numberPerfume -= 1;
                  }
                }

                double heightNamePerfumeContainer() {
                  if (numberPerfume == 1) {
                    return 25.0;
                  } else if (numberPerfume == 2) {
                    return 48.0;
                  } else if (numberPerfume > 1 && numberPerfume <= 5) {
                    return 25.0 * numberPerfume - 10;
                  } else if (numberPerfume > 5) {
                    return 25.0 * 5 - 15;
                  } else {
                    return 0;
                  }
                }

                double heightCard() {
                  if (images == 0 && numberPerfume == 1) {
                    return 125.0;
                  } else if (numberPerfume == 1) {
                    return 425.0;
                  } else if (images == 0 && numberPerfume == 2) {
                    return 145.0;
                  } else if (numberPerfume == 2) {
                    return 450.0;
                  } else if (images == 0 && numberPerfume == 3) {
                    return 165.0;
                  } else if (numberPerfume == 3) {
                    return 470.0;
                  } else if (images == 0 && numberPerfume == 4) {
                    return 185.0;
                  } else if (numberPerfume == 4) {
                    return 470.0;
                  } else if (images == 0 && numberPerfume > 4) {
                    return 212.0;
                  } else {
                    return 510.0;
                  }
                }

                return document.data()['perfume'] == null ||
                        document.data()['perfume'].isEmpty ||
                        numberPerfume == 0 ||
                        document.data()['username'] != thisUser
                    //Gdy nie ma żadnego perfumu w ogłoszeniu
                    ? const SizedBox()
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              height: heightCard(),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Wyświetlanie informacji (awatar, użytkownik, data)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  document
                                                      .data()['userAvatar']),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                document.data()['username'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                DecorateTime(document
                                                        .data()['timestamp'])
                                                    .decorate(),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(),
                                                PopupMenuButton<Options>(
                                                  onSelected:
                                                      (Options result) async {
                                                    if (result ==
                                                        Options.delete) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'advertisement')
                                                          .doc(document
                                                              .data()['id'])
                                                          .delete();
                                                    }
                                                  },
                                                  itemBuilder: (BuildContext
                                                          context) =>
                                                      <PopupMenuEntry<Options>>[
                                                    // const PopupMenuItem<
                                                    //     Options>(
                                                    //   value: Options.edit,
                                                    //   child: Text('Edytuj'),
                                                    // ),
                                                    const PopupMenuItem<
                                                        Options>(
                                                      value: Options.delete,
                                                      child: Text('Usuń'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      //Wyświetlanie nazw perfum
                                      Container(
                                        height: heightNamePerfumeContainer(),
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: document
                                                        .data()['perfume']
                                                        .values
                                                        .toList()
                                                        .length >
                                                    5
                                                ? 5
                                                : document
                                                    .data()['perfume']
                                                    .values
                                                    .toList()
                                                    .length,
                                            itemBuilder: (context, index1) {
                                              return perfume[index1]
                                                          ['capacity'] ==
                                                      '0'
                                                  ? SizedBox()
                                                  : Table(
                                                      columnWidths: {
                                                        0: FlexColumnWidth(1),
                                                        1: FlexColumnWidth(6),
                                                        2: FlexColumnWidth(6),
                                                        3: FlexColumnWidth(5),
                                                      },
                                                      children: [
                                                        TableRow(children: [
                                                          const SizedBox(),
                                                          Container(
                                                            child: Text(
                                                              index1 == 4
                                                                  ? ''
                                                                  : perfume[index1]['namePerfume']
                                                                              .length >
                                                                          15
                                                                      ? perfume[index1]['namePerfume'].substring(
                                                                              0,
                                                                              15) +
                                                                          ' ...'
                                                                      : perfume[
                                                                              index1]
                                                                          [
                                                                          'namePerfume'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Center(
                                                              child: Text(
                                                                index1 == 4
                                                                    ? 'Zobacz więcej ...'
                                                                    : perfume[index1]
                                                                            [
                                                                            'capacity'] +
                                                                        ' ml',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: index1 ==
                                                                            4
                                                                        ? Colors
                                                                                .grey[
                                                                            600]
                                                                        : Colors
                                                                            .black,
                                                                    fontWeight: index1 ==
                                                                            4
                                                                        ? FontWeight
                                                                            .bold
                                                                        : FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Center(
                                                              child: Text(
                                                                index1 == 4
                                                                    ? ''
                                                                    : perfume[index1]
                                                                            [
                                                                            'price'] +
                                                                        ' zł / ml',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ],
                                                    );
                                            }),
                                      ),
                                      // Wyświetlanie zdjęć ogłoszenia
                                      Expanded(
                                        flex: 2,
                                        child: ListView(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: false,
                                          children: List.generate(1, (index) {
                                            if (images == 0) {
                                              return const SizedBox();
                                            } else if (images == 1) {
                                              return ShowAdvertisementImage(
                                                countImage: images,
                                                img1: Image.network(
                                                    document.data()[
                                                        'urlImage${index + 1}'],
                                                    fit: BoxFit.cover),
                                              );
                                            } else if (images == 2) {
                                              return ShowAdvertisementImage(
                                                countImage: images,
                                                img1: Image.network(
                                                    document.data()[
                                                        'urlImage${index + 1}'],
                                                    fit: BoxFit.cover),
                                                img2: Image.network(
                                                    document.data()[
                                                        'urlImage${index + 2}'],
                                                    fit: BoxFit.cover),
                                              );
                                            } else if (images > 2) {
                                              return ShowAdvertisementImage(
                                                countImage: images,
                                                img1: Image.network(
                                                    document.data()[
                                                        'urlImage${index + 1}'],
                                                    fit: BoxFit.cover),
                                                img2: Image.network(
                                                    document.data()[
                                                        'urlImage${index + 2}'],
                                                    fit: BoxFit.cover),
                                                img3: Image.network(
                                                    document.data()[
                                                        'urlImage${index + 3}'],
                                                    fit: BoxFit.cover),
                                              );
                                            }
                                            return SizedBox();
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
