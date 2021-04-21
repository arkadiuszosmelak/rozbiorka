import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPerfumeWidget extends StatefulWidget {
  AddPerfumeWidget(this.uid);
  final String uid;
  @override
  _AddPerfumeWidgetState createState() => _AddPerfumeWidgetState();
}

class _AddPerfumeWidgetState extends State<AddPerfumeWidget> {
  final _formKey = GlobalKey<FormState>();

  double _price = 1.20;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController(text: '1.20');
  TextEditingController _capacityController = TextEditingController();

  bool _update = false;

  void _resetInputs() {
    setState(() {
      _nameController = TextEditingController();
      _priceController = TextEditingController(text: '1.20');
      _capacityController = TextEditingController();
      _price = 1.20;
    });
  }

  String _repairName(String text) {
    return text
        .replaceAll('.', '')
        .replaceAll('~', '')
        .replaceAll('*', '')
        .replaceAll('/', '')
        .replaceAll('[', '')
        .replaceAll(']', '');
  }

  void _wyslij(String namePerfume, String price, String capacity) async {
    try {
      if (!_update) {
        await FirebaseFirestore.instance
            .collection('/advertisement')
            .doc('${widget.uid}')
            .update({
          'perfume': {
            _repairName(namePerfume): {
              'namePerfume': namePerfume,
              'price': price,
              'capacity': capacity,
            }
          }
        });
      } else {
        var ref = FirebaseFirestore.instance
            .collection('/advertisement')
            .doc('${widget.uid}');
        ref.get().then((value) async {
          var perfumeMap = value['perfume'];
          var newPerfumeMap = {
            _repairName(namePerfume): {
              'namePerfume': namePerfume,
              'price': price,
              'capacity': capacity,
            }
          };
          var tmpMap = {};
          tmpMap.addAll(perfumeMap);
          tmpMap.addAll(newPerfumeMap);
          ref.update({'perfume': tmpMap});
          // print({'perfume': tmpMap});
        });
      }

      setState(() {
        _update = true;
      });
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
      return 'Podaj pojemność';
    }
    try {
      int.parse(value);
    } catch (e) {
      return 'Liczba np. 50';
    }
    if (int.parse(value) <= 0) {
      return 'To pole musi być większe od 0';
    }
    return null;
  }

  String validatePrice(String value) {
    if (value.length == 0) {
      return 'Podaj cenę za ml';
    }
    try {
      double.parse(value);
    } catch (e) {
      return 'Liczba np. 1.20';
    }
    if (double.parse(value) <= 0.0) {
      return 'Liczba większa od 0';
    }
    return null;
  }

  Widget _textInput(
      TextEditingController controller,
      TextInputType keyboardType,
      String label,
      double width,
      Function validator) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: width,
      // height: validator == null ? 1 : 65,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(style: BorderStyle.solid),
          ),
          contentPadding: EdgeInsets.all(10.0),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textInput(_nameController, TextInputType.text, 'Nazwa perfum',
                mediaQuery * 0.8, validateNamePerfume),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textInput(_priceController, TextInputType.number, 'Cena za ml',
                    mediaQuery * 0.3, validatePrice),
                SizedBox(width: mediaQuery * 0.02),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _price -= 0.10;
                      _priceController.text = '${_price.toStringAsFixed(2)}';
                    });
                  },
                  child: Icon(Icons.remove_circle),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _price += 0.10;
                      _priceController.text = '${_price.toStringAsFixed(2)}';
                    });
                  },
                  child: Icon(Icons.add_circle),
                ),
                SizedBox(width: mediaQuery * 0.055),
                _textInput(_capacityController, TextInputType.number,
                    'Pojemność', mediaQuery * 0.3, validateCapacity),
              ],
            ),
            RaisedButton(
              child: Text(!_update ? 'Dodaj perfumy' : 'Dodaj kolejne perfumy'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _wyslij(
                    _nameController.text,
                    _priceController.text,
                    _capacityController.text,
                  );
                  _resetInputs();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
