import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rozbiorka/screens/advertisement_dialog_box.dart';

class SummaryAdvetisement extends StatelessWidget {
  SummaryAdvetisement(this.uid);
  final String uid;

  void deletePerfume(String key) async {
    try {
      await FirebaseFirestore.instance
          .collection('advertisement')
          .doc(uid)
          .update(
        {'perfume.$key': FieldValue.delete()},
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('advertisement')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new CircularProgressIndicator();
          }
          //Sprawdzenie czy zostały dodane perfumy w poprzednim kroku (AddPerfumeWidget)
          try {
            var mapPerfume = snapshot.data['perfume'];
          } catch (_) {
            return Center(
              child: Text(
                'Wróć, aby dodać perfumy',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
          var mapPerfume = snapshot.data['perfume'];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                'Podsumowanie',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                },
                children: [
                  TableRow(children: [
                    Text(
                      'Nazwa perfum',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Poj.',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Cena',
                      textAlign: TextAlign.center,
                    ),
                    Text(''),
                    Text(''),
                  ])
                ],
              ),
              mapPerfume.length == 0
                  ? Container(
                      height: 300,
                      child: Center(
                        child: Text(
                          'Wróć, aby dodać perfumy',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: mapPerfume.length,
                        itemBuilder: (BuildContext ctx, index) {
                          String key = mapPerfume.keys.elementAt(index);
                          return Table(
                            columnWidths: {
                              0: FlexColumnWidth(4),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(1),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    mapPerfume[key]['namePerfume'],
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    mapPerfume[key]['capacity'],
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    mapPerfume[key]['price'],
                                    textAlign: TextAlign.center,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit_outlined),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AdvertisementDialogBox(
                                              uid,
                                              key,
                                              mapPerfume[key]['namePerfume'],
                                              mapPerfume[key]['capacity'],
                                              mapPerfume[key]['price']);
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete_outline),
                                      onPressed: () => deletePerfume(key)),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
