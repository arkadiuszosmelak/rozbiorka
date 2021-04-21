import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rozbiorka/screens/dialog_rated_user.dart';

class DetailsOrder extends StatefulWidget {
  DetailsOrder(this.orderMap, this.perfumeList);
  final Map<String, dynamic> orderMap;
  final List perfumeList;

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  final thisUser = FirebaseAuth.instance.currentUser.displayName;
  bool rating;

  @override
  void initState() {
    super.initState();
    rating = widget.orderMap['rating'];
  }

  void showInSnackBar(String value, BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Theme.of(context).errorColor,
    ));
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

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Zamówienie'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              tableWidget('Nazwa perfum', 'Ilość', 'Cena', Color(0xff5c6bc0)),
              Container(
                height: widget.perfumeList.length > 5
                    ? 250.0
                    : 50.0 * widget.perfumeList.length,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: widget.perfumeList.length,
                    itemBuilder: (context, index) {
                      return tableWidget(
                        widget.perfumeList[index],
                        '${widget.orderMap[widget.perfumeList[index]]['count']} ml',
                        '${widget.orderMap[widget.perfumeList[index]]['price'].toStringAsFixed(2)} zł',
                        Color(0xff9fa8da),
                      );
                    },
                  ),
                ),
              ),
              tableWidget(
                'Dostawa',
                '1',
                '13.00 zł',
                Color(0xff7986cb),
              ),
              tableWidget(
                'Atomizer',
                '${widget.perfumeList.length}',
                '${(widget.orderMap['atomizerCost']).toStringAsFixed(2)} zł',
                Color(0xff7986cb),
              ),
              SizedBox(height: 10),
              tableWidget(
                'Podsumowanie',
                '',
                '${(widget.orderMap['priceOrder']).toStringAsFixed(2)} zł',
                Color(0xff5c6bc0),
              ),
            ],
          ),
          widget.orderMap['buyer'] == thisUser
              ? GestureDetector(
                  onTap: () {
                    if (rating) {
                      showInSnackBar(
                          'To ogłoszenie zostało ocenione!', context);
                    } else {
                      setState(() {
                        rating = true;
                      });
                      showDialog(
                        context: context,
                        builder: (_) => DialogRatedUser(
                            widget.orderMap['id'], widget.orderMap['seller']),
                        barrierDismissible: false,
                      );
                    }
                  },
                  child: Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Card(
                        color: Colors.indigo[200],
                        child: Center(
                          child: Text('Oceń sprzedawcę'),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
