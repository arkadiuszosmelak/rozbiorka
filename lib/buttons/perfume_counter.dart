import 'package:flutter/material.dart';
import 'package:rozbiorka/screens/zamowienie.dart' as zamowienie;

class PerfumeCounter extends StatefulWidget {
  PerfumeCounter(this.capacity, this.price, this.name);
  final int capacity;
  final double price;
  final String name;
  @override
  _PerfumeCounterState createState() => _PerfumeCounterState();
}

class _PerfumeCounterState extends State<PerfumeCounter> {
  int _counter = 1;
  int _min = 1;

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    var _price = widget.price;
    int _max = widget.capacity;
    void _add() {
      if (_counter == 1) {
        setState(() {
          _counter += 4;
          zamowienie.edytujMape(widget.name, _counter, _price * _counter);
          print(zamowienie.zamowienie);
        });
      } else if (_counter != _max) {
        setState(() {
          _counter += 5;
          zamowienie.edytujMape(widget.name, _counter, _price * _counter);
          print(zamowienie.zamowienie);
        });
      }
    }

    void _subtraction() {
      if (_counter == 5) {
        setState(() {
          _counter -= 4;
          zamowienie.edytujMape(widget.name, _counter, _price * _counter);
          print(zamowienie.zamowienie);
        });
      }
      if (_counter != _min) {
        setState(() {
          _counter -= 5;
          zamowienie.edytujMape(widget.name, _counter, _price * _counter);
          print(zamowienie.zamowienie);
        });
      }
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: _counter == _min ? Colors.black12 : Colors.indigo[300],
        ),
        width: 250,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60,
              height: 30,
              child: RaisedButton(
                color: _counter == _min ? Colors.white10 : Colors.white,
                onPressed: _subtraction,
                child: Icon(Icons.remove, color: Colors.grey[800]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Text(
              '$_counter ml = ${_price * _counter} z??',
              style: TextStyle(
                color: _counter == _min ? Colors.grey[800] : Colors.white,
                fontWeight:
                    _counter == _min ? FontWeight.normal : FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              width: 60,
              height: 30,
              child: RaisedButton(
                color: _counter == _max ? Colors.white10 : Colors.white,
                onPressed: _add,
                child: Icon(Icons.add, color: Colors.grey[800]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
