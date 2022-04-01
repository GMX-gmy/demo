import 'dart:convert';
import 'package:demo/TestUtil.dart';
import 'package:demo/editPage.dart';
import 'package:flutter/material.dart';
import 'package:demo/HiveUtil.dart';
import 'JsonUtil.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {


  @override
  void initState() {
    // TODO: implement initState
    TestUtil.instance?.updateName('settingName');
    super.initState();
    JsonUtil.instance!.infoChangeNotifier!.addListener(() {
      if(mounted) {
        setState(() {});
      }
    });
  }

  @override
  dispose(){
    super.dispose();
    JsonUtil.instance?.infoChangeNotifier?.removeListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Material(
        child: Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(249, 249, 249, 1),
          image: DecorationImage(
              image: AssetImage(
                'images/bg2.png',
              ),
              alignment: Alignment.topRight)),
      child: Stack(children: [
        Positioned(
          child: GestureDetector(
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/edit.png'), fit: BoxFit.cover)),
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditPage();
              }));
            },
          ),
          top: 44,
          right: 24,
        ),
        Positioned(
          child: Container(
            width: 100,
            height: 100,
            child: ClipOval(
              child:
              HiveUtil.instance!.getAvatar().isNotEmpty ? Image.memory(
                base64.decode(HiveUtil.instance!.getAvatar().split(',')[1]),
                fit: BoxFit.fill,
                gaplessPlayback: true,
              ) : Image.asset(
                'images/image1.jpeg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          top: 88,
          left: 24,
        ),
        Positioned(
          child: Text(
              HiveUtil.instance!.getUsername(),
              style: const TextStyle(
                //取消文本底部的黄色双划线
                  decoration: TextDecoration.none,
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              )
          ),
          top: 220,
          left: 24,
          ),
          // _username,
          // style: TextStyle(
          //   //取消文本底部的黄色双划线
          //     decoration: TextDecoration.none,
          //     fontSize: 24,
          //     color: Colors.black,
          //     fontWeight: FontWeight.w500),
          // top: 220,
          // left: 24,

        Positioned(
          child: SizedBox(
              child: Column(
            children: [
              row('images/buy.png', 'Buy Coins', width),
              myDivider(width),
              row('images/Feedback.png', 'Feedback', width),
              myDivider(width),
              row('images/logout.png', 'Logout', width),
              const SizedBox(
                height: 18,
              ),
              Container(
                  width: width - 40,
                  height: 1,
                  color: const Color.fromRGBO(242, 231, 221, 1)),
            ],
          )),
          top: 300,
        )
      ]),
    ));
  }

  Widget row(String leftImageName, String rowName, double width) {
    return Container(
      width: width - 40,
      margin: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: Image(
                  image: AssetImage(leftImageName),
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                rowName,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            child: const Image(
              image: AssetImage('images/arrow.png'),
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }

  Widget myDivider(double width) {
    return Column(
      children: [
        const SizedBox(
          height: 18,
        ),
        Container(
            width: width - 40,
            height: 1,
            color: const Color.fromRGBO(242, 231, 221, 1)),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
