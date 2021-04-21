import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperImage extends StatelessWidget {
  SwiperImage(this.itemCount, this.listaZdjec);
  final int itemCount;
  final listaZdjec;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.9)),
          child: Swiper(
            viewportFraction: 0.8,
            scale: 0.9,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                listaZdjec[index],
                height: mediaQuery.size.height * 0.5,
              );
            },
            itemCount: itemCount,
            pagination: SwiperPagination(),
          ),
        ),
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height * 0.15,
          // decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height:
                      mediaQuery.padding.top + mediaQuery.size.height * .005),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.west_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
