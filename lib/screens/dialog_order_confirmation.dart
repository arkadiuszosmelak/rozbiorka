import 'package:flutter/material.dart';
import 'zamowienie.dart' as zamowienie;

class DialogOrderConfiration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Złożono zamówienie',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Twoje zamówienie zostało złożone. Teraz możesz skontaktować się ze sprzedającym.',
            textAlign: TextAlign.center,
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        Center(
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              zamowienie.zamowienie = {};
            },
            child: Text(
              'Wyjdź',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
