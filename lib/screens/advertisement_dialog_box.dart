import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdvertisementDialogBox extends StatefulWidget {
  AdvertisementDialogBox(this.idAdvertisement, this.keyToDb, this.namePerfume,
      this.capacity, this.price);
  final String idAdvertisement;
  final String keyToDb;
  final String namePerfume;
  final String capacity;
  final String price;
  @override
  _AdvertisementDialogBoxState createState() => _AdvertisementDialogBoxState();
}

class _AdvertisementDialogBoxState extends State<AdvertisementDialogBox> {
  final _formKey = GlobalKey<FormState>();

  void edytowanie(String name, String cap, String pr) async {
    try {
      await FirebaseFirestore.instance
          .collection('advertisement')
          .doc(widget.idAdvertisement)
          .update(
        {
          'perfume.${widget.keyToDb}': {
            'namePerfume': name,
            'capacity': cap,
            'price': pr
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  String validateNamePerfume(String value) {
    if (value.length == 0) {
      return 'To pole nie może być puste';
    }
    return null;
  }

  String validateCapacity(String value) {
    if (value.length == 0) {
      return 'To pole nie może być puste';
    }
    try {
      int.parse(value);
    } catch (e) {
      return 'To pole musi być liczbą np. 50';
    }
    if (int.parse(value) <= 0) {
      return 'To pole musi być większe od 0';
    }
    return null;
  }

  String validatePrice(String value) {
    if (value.length == 0) {
      return 'To pole nie może być puste';
    }
    try {
      double.parse(value);
    } catch (e) {
      return 'To pole musi być liczbą np. 1.20';
    }
    if (double.parse(value) <= 0.0) {
      return 'To pole musi być większe od 0';
    }
    return null;
  }

  Widget textInput(String labelText, TextEditingController controller,
      Function validator, TextInputType keyboard) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        keyboardType: keyboard,
        controller: controller,
        validator: (value) => validator(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController =
        TextEditingController(text: widget.namePerfume);
    TextEditingController _capacityController =
        TextEditingController(text: widget.capacity);
    TextEditingController _priceController =
        TextEditingController(text: widget.price);

    return SimpleDialog(
      title: Text(
        'Edytuj perfumy',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              textInput('Nazwa perfum', _nameController, validateNamePerfume,
                  TextInputType.text),
              SizedBox(height: 20),
              textInput('Pojemność', _capacityController, validateCapacity,
                  TextInputType.number),
              SizedBox(height: 20),
              textInput('Cena za ml', _priceController, validatePrice,
                  TextInputType.number),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Wróć',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        edytowanie(_nameController.text,
                            _capacityController.text, _priceController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Potwierdź',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
