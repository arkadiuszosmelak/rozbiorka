import 'package:flutter/material.dart';

import 'package:rozbiorka/screens/hehe.dart';

typedef void CheckboxWidgetCallback(bool result);

class CheckboxWidget extends StatefulWidget {
  final CheckboxWidgetCallback onSubmit;

  CheckboxWidget({this.onSubmit});

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Uwaga',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            'Aby zamówić dany perfum jego wartość musi być powyżej 1 ml.',
            style: TextStyle(fontFamily: 'OpenSans'),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: Row(
        //     children: [
        //       Radio(
        //         groupValue: value,
        //         onChanged: (bool value) =>
        //             setState(() => this.value = !this.value),
        //         value: true,
        //       ),
        //       Text('Nie pokazuj ponownie')
        //     ],
        //   ),
        // ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Theme.of(context).primaryColor,
          title: Text(
            'Nie wyświetlaj ponownie',
            style: TextStyle(fontSize: 14, fontFamily: 'OpenSans'),
          ),
          value: value,
          onChanged: (_) {
            setState(() {
              this.value = !this.value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Wstecz',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onSubmit(value);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hehe()),
                );
              },
              child: Text(
                'Rozumiem',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
