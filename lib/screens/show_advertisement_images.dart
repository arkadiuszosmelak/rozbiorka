import 'package:flutter/material.dart';

class ShowAdvertisementImage extends StatefulWidget {
  ShowAdvertisementImage({this.countImage, this.img1, this.img2, this.img3});
  final int countImage;
  final Image img1;
  final Image img2;
  final Image img3;
  @override
  _ShowAdvertisementImageState createState() => _ShowAdvertisementImageState();
}

class _ShowAdvertisementImageState extends State<ShowAdvertisementImage> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    Widget showImages(number) {
      if (number == 1) {
        return Container(
          height: 300,
          width: mediaQuery.width * 0.88,
          child: widget.img1,
        );
      } else if (number == 2) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Container(
              height: 300,
              width: mediaQuery.width * 0.44,
              child: widget.img1,
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              height: 300,
              width: mediaQuery.width * 0.44,
              child: widget.img2,
            ),
          ],
        );
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: mediaQuery.width * 0.61,
              height: 300,
              child: widget.img1,
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              width: mediaQuery.width * 0.27,
              child: Column(
                children: [
                  Container(
                    height: 147,
                    width: mediaQuery.width * 0.27,
                    child: widget.img2,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 147,
                    width: mediaQuery.width * 0.44,
                    child: widget.img3,
                  ),
                ],
              ),
            )
          ],
        );
      }
    }

    return showImages(widget.countImage);
  }
}
