import 'dart:async';

import 'package:flutter/material.dart';

import 'package:rozbiorka/buttons/perfume_counter.dart';
import 'package:rozbiorka/screens/decorate_time.dart';
import 'package:rozbiorka/widgets/products/swiper_image.dart';
import 'package:rozbiorka/screens/end_order.dart';
import 'zamowienie.dart' as zamowienie;

class FullVisionScreen extends StatefulWidget {
  FullVisionScreen(this.perfumeList, this.userInfo);
  final perfumeList;
  final Map<String, dynamic> userInfo;

  // static

  @override
  _FullVisionScreenState createState() => _FullVisionScreenState();
}

class _FullVisionScreenState extends State<FullVisionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _toolTipKey = GlobalKey();

  List listWIthImage = [];

  void showInSnackBar(String value, BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  bool onSubmit(bool result) {
    print(result);
    print(widget.userInfo);
    return result;
  }

  List listOfImages() {
    int countImage = widget.userInfo['images'];
    for (var i = 1; i <= countImage; i++) {
      listWIthImage.add(widget.userInfo['urlImage$i']);
    }
    return listWIthImage;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        zamowienie.zamowienie = {};
        Navigator.pop(context);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
                zamowienie.zamowienie = {};
              }),
          iconTheme: IconThemeData(
            color: Colors.grey[850],
          ),
          shadowColor: Colors.grey[850],
          backgroundColor: Colors.white,
          title: Text(
            'Ogłoszenie',
            style: TextStyle(color: Colors.grey[850]),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.userInfo['userAvatar']),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userInfo['username'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DecorateTime(widget.userInfo['timestamp']).decorate(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            Center(
              child: RaisedButton(
                onPressed: widget.userInfo['images'] == 0
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SwiperImage(
                                  widget.userInfo['images'], listOfImages())),
                        );
                      },
                child: Text('Zobacz zdjęcia'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                GestureDetector(
                  onTap: () {
                    final dynamic tooltip = _toolTipKey.currentState;
                    tooltip.ensureTooltipVisible();
                    Timer(Duration(milliseconds: 3000), () {
                      tooltip.deactivate();
                    });
                  },
                  child: Tooltip(
                    key: _toolTipKey,
                    message:
                        '\nAby zamówić dany perfum jego wartość\n musi być powyżej 1 ml.\n',
                    child: Icon(
                      Icons.info,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.perfumeList.length,
                  itemBuilder: (context, index) {
                    zamowienie.username = widget.userInfo['username'];
                    return widget.perfumeList[index]['capacity'] == '0'
                        ? SizedBox()
                        : Center(
                            child: Column(
                            children: [
                              Text(widget.perfumeList[index]['namePerfume']),
                              SizedBox(height: 5),
                              PerfumeCounter(
                                  int.parse(
                                      widget.perfumeList[index]['capacity']),
                                  double.parse(
                                      widget.perfumeList[index]['price']),
                                  widget.perfumeList[index]['namePerfume']),
                              SizedBox(height: 10),
                            ],
                          ));
                  }),
            ),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            if (zamowienie.zamowienie.isEmpty) {
              print('cosik');

              showInSnackBar('Dodaj perfumy do zamówienia!', context);
            } else {
              showDialog(
                context: context,
                builder: (_) => EndOrder(widget.userInfo['id']),
                barrierDismissible: false,
              );
            }
          },
          child: Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Center(
              child: Text(
                'Złóż zamówienie',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
