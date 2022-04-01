import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NewAdvisorsPage extends StatefulWidget {
  const NewAdvisorsPage({Key? key}) : super(key: key);
  @override
  _NewAdvisorsPagState createState() => _NewAdvisorsPagState();
}

class _NewAdvisorsPagState extends State<NewAdvisorsPage> {
  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;

    Gradient gradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(128, 56, 153, 1),
        Color.fromRGBO(107, 74, 186, 1)
      ],
    );
    Shader shader =
        gradient.createShader(const Rect.fromLTWH(50, 100, 150, 50));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Soulight',
          style: TextStyle(
            fontSize: 24,
            foreground: Paint()..shader = shader,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: false,
        actions: [
              GestureDetector(
                  child: Image.asset('images/paixu.png', width: 24, height: 24),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                child: Image.asset('images/shaixuan.png', width: 24,height: 24),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                child: Image.asset('images/sousuo.png', width: 24, height: 24,),
              ),
              const SizedBox(width: 24)
        ],
      ),
      body: ListView(
        children: [
          activityCard(),
          advisorCard(kWidth),
          testCard(),
          twoTestCard(),
        ],
      ),
    );
  }

  activityCard() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top:12, left: 16, right: 16, bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(227, 218, 235, 1),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  advisorCard(double width) {
    return Container(
      width: width - 32,
      height: 250,
      margin: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
              image: AssetImage('images/image1.jpeg'),
              fit: BoxFit.fill)
              ),
      child: Stack(
        children: [
          Positioned(
              child:Row(
                children: [
                  labelCard('images/ziyuan.png'),
                  labelCard('images/xiaoxi.png'),
                  labelCard('images/huatong.png'),
                  labelCard('images/shipin.png'),
                ],
              ),
            top: 16,
            right: 16,
          ),
          Positioned(
              child:Container(
                width: 100,
                height: 30,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 234, 76, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Top Accuracy',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
            right: 16,
            bottom: 100,
          ),
          Positioned(
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(width: 2, color: Colors.white),
                        image: const DecorationImage(
                            image: AssetImage('images/image2.jpeg'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                    ],
                  )
                ],
              ),
            bottom: 8,
            left: 12,
            right: 12,
          ),
        ],
      ),
    );
  }

  labelCard(String imageName) {
    return Container(
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Image.asset(imageName, fit: BoxFit.cover,),
    );
  }

  testCard() {
    //当container没有子组件时，设置的width和height是没有效果的，它会无限变大，
    return Container(
      width: 20,
      //height: 10,
      decoration: BoxDecoration(
        color: Colors.pink.withAlpha(50),
      ),
      child:Column(
        children: [
          Row(

            children: [
              //expanded的flex是等比适应宽度，高度不变。
              Expanded(child: Container(width: 20, height: 20, color: Colors.pink,), flex: 1,),
              Expanded(child: Container(width: 20, height: 20, color: Colors.purple,), flex: 2,),
              Expanded(child: Container(width: 20, height: 40, color: Colors.blue,)),
              Expanded(child: Container(width: 20, height: 60, color: Colors.blue,), )
            ],
          ),
          //Row布局:Row的高度由子组件中高度最大的决定。宽度是屏幕的宽
          Row(
            children: [
              Container(width: 20, height: 20, color: Colors.pink,),
              Container(width: 20, height: 20, color: Colors.purple,),
              Container(width: 20, height: 40, color: Colors.blue,)
            ],
          ),
        ],
      )

    );
  }

  twoTestCard() {
    return Container(
      width: 200,
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.purple,
      ),
    );
  }

}
