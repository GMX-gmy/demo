
import 'package:demo/new_advisors_page.dart';
import 'package:demo/orderListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/main.dart';
import 'package:demo/settingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      builder: EasyLoading.init(),
      home: Scaffold(
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            MyHomePage(),
            OrderListPage(),
            SettingPage(),
            NewAdvisorsPage()
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          child: TabBar(
            controller: _controller,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                text: 'Advisors',
                icon: Image.asset(_currentIndex == 0 ? 'images/home2.png' : 'images/home2.png'),
              ),
              Tab(
                text: 'Orders',
                icon: Image.asset(_currentIndex == 0 ? 'images/home2.png' : 'images/home2.png'),
              ),
              Tab(
                text: 'Mine',
                icon: Image.asset(_currentIndex == 1 ? 'images/me.png' : 'images/me.png'),
              ),
              Tab(
                text: 'Mine',
                icon: Image.asset(_currentIndex == 1 ? 'images/me.png' : 'images/me.png'),
              )
            ],
            onTap: (currentIndex) {
              if(_currentIndex == currentIndex) {
                return;
              }
              _currentIndex = currentIndex;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}