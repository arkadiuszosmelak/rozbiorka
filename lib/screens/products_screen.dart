import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rozbiorka/screens/full_vision_screen.dart';
import 'package:rozbiorka/screens/show_advertisement_images.dart';
import 'package:rozbiorka/screens/decorate_time.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query advertisement = FirebaseFirestore.instance
        .collection('advertisement')
        .orderBy('timestamp', descending: true);
    return StreamBuilder<QuerySnapshot>(
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

              print(perfume);

              for (var i = 0;
                  i < document.data()['perfume'].values.toList().length;
                  i++) {
                if (perfume[i]['capacity'] == '0') {
                  numberPerfume -= 1;
                }
                print(numberPerfume);
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
                  // return 130.0;
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

              Widget chooseStarIcon(double average, int counter) {
                if (counter == 1 && average == 0) {
                  return Icon(Icons.star_outline, color: Colors.yellow);
                } else if (counter == 1 && average > 0) {
                  return Icon(Icons.star, color: Colors.yellow);
                } else if (counter == 2 && average >= 1 && average < 1.4) {
                  return Icon(Icons.star_outline, color: Colors.yellow);
                } else if (counter == 2 && average >= 1.4 && average < 1.8) {
                  return Icon(Icons.star_half, color: Colors.yellow);
                } else if (counter == 2 && average >= 1.8) {
                  return Icon(Icons.star, color: Colors.yellow);
                } else if (counter == 3 && average >= 2 && average < 2.4) {
                  return Icon(Icons.star_outline, color: Colors.yellow);
                } else if (counter == 3 && average >= 2.4 && average < 2.8) {
                  return Icon(Icons.star_half, color: Colors.yellow);
                } else if (counter == 3 && average >= 2.8) {
                  return Icon(Icons.star, color: Colors.yellow);
                } else if (counter == 4 && average >= 3 && average < 3.4) {
                  return Icon(Icons.star_outline, color: Colors.yellow);
                } else if (counter == 4 && average >= 3.4 && average < 3.8) {
                  return Icon(Icons.star_half, color: Colors.yellow);
                } else if (counter == 4 && average >= 3.8) {
                  return Icon(Icons.star, color: Colors.yellow);
                } else if (counter == 5 && average >= 4 && average < 4.4) {
                  return Icon(Icons.star_outline, color: Colors.yellow);
                } else if (counter == 5 && average >= 4.4 && average < 4.8) {
                  return Icon(Icons.star_half, color: Colors.yellow);
                } else if (counter == 5 && average >= 4.8) {
                  return Icon(Icons.star, color: Colors.yellow);
                }
                return Icon(Icons.star_outline, color: Colors.yellow);
              }

              void showRating() async {
                int sum = 0;
                int counter = 0;
                double average;

                //pobranie wszystkich ocen uzytkownika i obliczenie sredniej tych ocen

                var getDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(document.data()['username'])
                    .get();
                try {
                  List<dynamic> ratingList = getDoc.data()['ratingList'];
                  for (var element in ratingList) {
                    counter++;
                    sum += element;
                  }
                } catch (_) {}

                counter == 0 ? average = 0 : average = sum / counter;
                return showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => Stack(
                    children: [
                      Positioned(
                        right: 20,
                        top: 30,
                        child: Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ocena użytkownika:',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSans'),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                average.toStringAsFixed(2) +
                                    ' | zamówień $counter',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'OpenSans'),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    chooseStarIcon(average, 1),
                                    chooseStarIcon(average, 2),
                                    chooseStarIcon(average, 3),
                                    chooseStarIcon(average, 4),
                                    chooseStarIcon(average, 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              return document.data()['perfume'] == null ||
                      document.data()['perfume'].isEmpty ||
                      numberPerfume == 0
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Wyświetlanie informacji (awatar, użytkownik, data)
                                    Container(
                                      padding: EdgeInsets.fromLTRB(6, 12, 6, 0),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: CircleAvatar(
                                              minRadius: 20,
                                              maxRadius: 20,
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
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                                maxWidth: double.infinity),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(),
                                                IconButton(
                                                  icon: Icon(Icons.star),
                                                  splashRadius: 15,
                                                  highlightColor:
                                                      Colors.grey[200],
                                                  tooltip: 'Ocena użytkownika',
                                                  onPressed: showRating,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //Wyświetlanie nazw perfum
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullVisionScreen(
                                                    perfume, document.data()),
                                          ),
                                        );
                                      },
                                      child: Container(
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
                                    ),
                                    // Wyświetlanie zdjęć ogłoszenia
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullVisionScreen(
                                                      perfume, document.data()),
                                            ),
                                          );
                                        },
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
    );
  }
}
