import 'package:flutter/material.dart';

class PerfumeCounter extends StatefulWidget {
  @override
  _PerfumeCounterState createState() => _PerfumeCounterState();
}

class _PerfumeCounterState extends State<PerfumeCounter> {
  var _counter = 1;
  var _price = 1.5;
  int _max = 80;
  int _min = 1;

  void _add() {
    if (_counter == 1) {
      setState(() {
        _counter += 4;
      });
    } else if (_counter != _max) {
      setState(() {
        _counter += 5;
      });
    }
  }

  void _subtraction() {
    if (_counter == 5) {
      setState(() {
        _counter -= 4;
      });
    }
    if (_counter != _min) {
      setState(() {
        _counter -= 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    // print(mediaQuery.size.width);
    // print(mediaQuery.size.height);
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
              '$_counter ml = ${_price * _counter} zł',
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
