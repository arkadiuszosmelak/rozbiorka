import 'package:flutter/material.dart';

import 'package:rozbiorka/screens/full_vision_screen.dart';
import 'package:rozbiorka/widgets/products/swiper_image.dart';

class ProductsScreen extends StatelessWidget {
  bool test = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
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
                  FlatButton(
                    textTheme: ButtonTextTheme.normal,
                    shape: BeveledRectangleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullVisionScreen(),
                        ),
                      );
                    },
                    child: Table(columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                    }, children: [
                      TableRow(children: [
                        Text('Lalique encre noire'),
                        Text('180 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                      TableRow(children: [
                        Text('Zara Warm Black'),
                        Text('50 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                      TableRow(children: [
                        Text('L.T.Piver Cuir'),
                        Text('70 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => SwiperImage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Container(
                          height: 300,
                          child: Image(
                            image: AssetImage('assets/images/zdj2.jpg'),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Image(
                                image: AssetImage('assets/images/zdj1.jpg'),
                                height: 148,
                                width: 122,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Image(
                                image: AssetImage('assets/images/zdj0.jpg'),
                                height: 148,
                                width: 122,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
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
                  FlatButton(
                    textTheme: ButtonTextTheme.normal,
                    shape: BeveledRectangleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullVisionScreen(),
                        ),
                      );
                    },
                    child: Table(columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                    }, children: [
                      TableRow(children: [
                        Text('Lalique encre noire'),
                        Text('180 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                      TableRow(children: [
                        Text('Zara Warm Black'),
                        Text('50 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                      TableRow(children: [
                        Text('L.T.Piver Cuir'),
                        Text('70 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => SwiperImage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Container(
                          height: 300,
                          child: Image(
                            image: AssetImage('assets/images/zdj2.jpg'),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Image(
                                image: AssetImage('assets/images/zdj1.jpg'),
                                height: 148,
                                width: 122,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Image(
                                image: AssetImage('assets/images/zdj0.jpg'),
                                height: 148,
                                width: 122,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
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
                  FlatButton(
                    textTheme: ButtonTextTheme.normal,
                    shape: BeveledRectangleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullVisionScreen(),
                        ),
                      );
                    },
                    child: Table(columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                    }, children: [
                      TableRow(children: [
                        Text('Lalique encre noire'),
                        Text('180 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                      TableRow(children: [
                        Text('Zara Warm Black'),
                        Text('50 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                      TableRow(children: [
                        Text('L.T.Piver Cuir'),
                        Text('70 ml', textAlign: TextAlign.center),
                        Text('1.50 zł / 1 ml'),
                      ]),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => SwiperImage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Container(
                          height: 300,
                          child: Image(
                            image: AssetImage('assets/images/zdj2.jpg'),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Image(
                                image: AssetImage('assets/images/zdj1.jpg'),
                                height: 148,
                                width: 122,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Image(
                                image: AssetImage('assets/images/zdj0.jpg'),
                                height: 148,
                                width: 122,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
