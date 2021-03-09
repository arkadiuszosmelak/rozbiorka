import 'package:flutter/material.dart';

import 'package:rozbiorka/screens/chats_screen.dart';
import 'package:rozbiorka/screens/products_screen.dart';
import 'package:rozbiorka/screens/account_screen.dart';
import 'package:rozbiorka/screens/add_perfume.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ProductsScreen(),
    ChatsScreen(),
    Text(
      'Zamówienia',
    ),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rozbiórka'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Start',
            ),
            BottomNavigationBarItem(
              label: 'Wiadomości',
              icon: Stack(
                children: <Widget>[
                  Icon(Icons.message),
                  // Positioned(
                  //   top: 0,
                  //   right: 0,
                  //   child:
                  //       Icon(Icons.brightness_1, size: 12.0, color: Colors.red),
                  // ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'Zamówienia',
              // icon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Konto',
            ),
          ],
          selectedItemColor: Theme.of(context).accentColor,
          selectedLabelStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 13,
          ),
          unselectedItemColor: Theme.of(context).backgroundColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white70,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPerfume(),
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
