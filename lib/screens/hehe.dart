import 'package:flutter/material.dart';

class Hehe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height * 0.1,
                    // color: Colors.red,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: mediaQuery.size.height * 0.02,
                        ),
                        Image.asset(
                          'assets/icons/fb_icon.png',
                          height: 45,
                          width: 45,
                        ),
                        SizedBox(
                          width: mediaQuery.size.height * 0.015,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Piotr Krawczyk',
                                style: TextStyle(fontSize: 16)),
                            Text('Po ile te perfumki byku?'),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
