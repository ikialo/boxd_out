import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taka_box/WarehousingScreen/scanqr.dart';
import 'package:taka_box/WarehousingScreen/wareprod_list.dart';
import 'package:taka_box/main.dart';

class MainWareScreen extends StatefulWidget {
  const MainWareScreen({super.key});

  @override
  State<MainWareScreen> createState() => _MainWareScreenState();
}

class _MainWareScreenState extends State<MainWareScreen> {
  int _currentIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    // ListProduct(),
    // Profile(),
    // MapSample()
    WarehouseListProduct(),
    ScanQR()
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boxed Out'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                              title: 'BOXd Out')) //MainView()),
                      );
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: SafeArea(child: _widgetOptions.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Product List',
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: 'Scan',
            icon: Icon(Icons.camera_enhance),
          ),
        ],
      ),
    );
  }
}
