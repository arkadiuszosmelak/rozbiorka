import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:rozbiorka/widgets/add_perfume/add_perfume_widget.dart';
import '../widgets/add_perfume/pick_images.dart';
import 'package:rozbiorka/screens/summary_advetisement.dart';

var uuid = Uuid();
var v1 = uuid.v1();

class AddPerfume extends StatefulWidget {
  @override
  _AddPerfumeState createState() => _AddPerfumeState();
}

class _AddPerfumeState extends State<AddPerfume> {
  GlobalKey<PickImagesState> _globalKey = GlobalKey();
  int _counterStep = 1;

  @override
  void initState() {
    super.initState();
    var uuid = Uuid();
    v1 = uuid.v1();
  }

  Widget _progressStep(int numberStep, String description) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: numberStep < _counterStep + 1
                ? Border.all(width: 2, color: Colors.indigo)
                : Border.all(color: Colors.transparent),
            shape: BoxShape.circle,
            color: numberStep < _counterStep
                ? Colors.indigo[300]
                : Colors.blueGrey[100],
          ),
          width: 40,
          height: 40,
          child: Center(
              child: Text(
            '$numberStep',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(description),
        )
      ],
    );
  }

  Widget _progressBar() {
    if (_counterStep == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 3,
            color: Colors.indigo[300],
          ),
        ],
      );
    }
    if (_counterStep == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 3,
            color: Colors.indigo[300],
          ),
        ],
      );
    }
    return null;
  }

  Widget _pickWidget() {
    if (_counterStep == 1) {
      return PickImages(v1.toString());
    } else if (_counterStep == 2) {
      return AddPerfumeWidget(v1.toString());
    } else {
      return SummaryAdvetisement(v1.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Utwórz ogłoszenie'),
        automaticallyImplyLeading: _counterStep > 1 ? false : true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(45, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 3,
                    color: Colors.blueGrey[100],
                    child: _progressBar(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _progressStep(1, 'Dodaj zdjęcie'),
                    _progressStep(2, 'Dodaj prefumy'),
                    _progressStep(3, 'Dodaj ogłoszenie'),
                  ],
                ),
              ],
            ),
            // Text('${PickImages.uid}')
            _pickWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_counterStep > 1) _counterStep--;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            width: MediaQuery.of(context).size.width * 0.003,
                            color: Colors.grey),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    width: _counterStep == 1
                        ? 0
                        : MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                      child: Text(
                        'Wstecz',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_counterStep < 5) _counterStep++;
                      if (_counterStep == 2)
                        PickImages.staticGlobalKey.currentState
                            .handleUploadImage();
                      if (_counterStep == 4) Navigator.pop(context);
                      // print(PickImages.staticGlobalKey.currentState.asd);
                    });
                  },
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: _counterStep == 1
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                      child: Text(
                        _counterStep == 3 ? 'Zakończ' : 'Dalej',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
