import 'package:flutter/material.dart';

class AddPerfume extends StatefulWidget {
  @override
  _AddPerfumeState createState() => _AddPerfumeState();
}

class _AddPerfumeState extends State<AddPerfume> {
  List<Widget> list = new List();

  @override
  Widget build(BuildContext context) {
    var children2 = Column(
      children: [
        // SizedBox(height: 100),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.05,
          // color: Colors.red,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Nazwa perfum',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(style: BorderStyle.solid),
              ),
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextFormField(
                initialValue: '1.20',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cena za ml',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.remove_circle),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.add_circle),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.09),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              // color: Colors.red,
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                decoration: InputDecoration(
                  labelText: 'Pojemność',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.08,
          // color: Colors.red,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Text('Dostawa'),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: FlatButton(
                  // shape: ShapeBorder.,
                  onPressed: () {},
                  child: Text('Kurier'),
                  color: Colors.grey,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Paczkomat'),
                  color: Colors.grey,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Odbiór'),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.05,
          // color: Colors.red,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Atomizer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(style: BorderStyle.solid),
              ),
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
    if (list.isEmpty) {
      list.add(SizedBox(height: MediaQuery.of(context).size.height * 0.05));
      list.add(children2);
    }
    // list.add(children2);
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            Widget widget = list.elementAt(index);
            return widget;
          },
          itemCount: list.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          list.add(children2);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
