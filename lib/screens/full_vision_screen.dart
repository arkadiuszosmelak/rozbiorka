import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:rozbiorka/buttons/perfume_counter.dart';
import 'package:rozbiorka/buttons/checkbox.dart';

class FullVisionScreen extends StatelessWidget {
  void onSubmit(bool result) {
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey[850], //change your color here
          ),
          shadowColor: Colors.grey[850],
          backgroundColor: Colors.white,
          title: Text(
            'Ogłoszenie',
            style: TextStyle(color: Colors.grey[850]),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Image(
                      image: AssetImage('assets/icons/fb_icon.png'),
                      height: 35,
                      width: 35,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Piotr Krawczyk',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '3 dni temu',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text('Lalique Encre Noire'),
                  SizedBox(height: 5),
                  PerfumeCounter(),
                  SizedBox(height: 5),
                  Text('Zara Warm Black'),
                  SizedBox(height: 5),
                  PerfumeCounter(),
                  SizedBox(height: 5),
                  Text('L.T.Piver Cuir'),
                  SizedBox(height: 5),
                  PerfumeCounter(),
                  Text('Lalique Encre Noire'),
                  SizedBox(height: 5),
                  PerfumeCounter(),
                  SizedBox(height: 5),
                  Text('Lalique Encre Noire'),
                  SizedBox(height: 5),
                  PerfumeCounter(),
                  SizedBox(height: 5),
                  Text('Lalique Encre Noire'),
                  SizedBox(height: 5),
                  PerfumeCounter(),
                  SizedBox(height: 10),
                ],
              ),
              Center(
                child: Container(
                  height: mediaQuery.size.height * 0.45,
                  width: mediaQuery.size.width * 0.7,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image(
                        image: AssetImage('assets/images/zdj$index.jpg'),
                        // fit: BoxFit.fill,
                      );
                    },
                    itemCount: 3,
                    itemWidth: 300.0,
                    itemHeight: 400.0,
                    layout: SwiperLayout.TINDER,
                    pagination: SwiperPagination(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            color: Theme.of(context).primaryColor,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            onPressed: () {
              return showDialog(
                context: context,
                builder: (_) => CheckboxWidget(
                  onSubmit: onSubmit,
                ),
                barrierDismissible: false,
              );
            },
            child: Text('Złóż zamówienie'),
          ),
        ));
  }
}
