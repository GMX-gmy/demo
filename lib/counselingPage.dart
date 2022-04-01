

import 'package:demo/HiveUtil.dart';
import 'package:demo/InfoModel.dart';
import 'package:demo/advisorHomePage.dart';
import 'package:demo/advisor_model.dart';
import 'package:demo/network.dart';
import 'package:demo/orderModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_format/date_format.dart';

class CounselingPage extends StatefulWidget{
  const CounselingPage({Key? key, this.model }) : super(key: key);
  final AdvisorModel? model;
  @override
  _CounselingPageState createState() => _CounselingPageState();
}



class _CounselingPageState  extends State<CounselingPage> {

  FToast? fToast;
  TextEditingController myController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fToast = FToast();
    fToast?.init(context);
  }

  @override
  void dispose() {
    myController.dispose();
    twoController.dispose();
    threeController.dispose();
    super.dispose();
  }

  bool setType() {
    if(myController.text.isNotEmpty && twoController.text.isNotEmpty && threeController.text.isNotEmpty){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Colors.black,
        // ),
        leading: GestureDetector(
          child: Image.asset(
              'images/back.png'
          ),
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
            if(myController.text.isNotEmpty || twoController.text.isNotEmpty || threeController.text.isNotEmpty){
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('提示'),
                      content: const Text('确认退出？'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('确认'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoDialogAction(
                            child: const Text('取消'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },

                        )
                      ],
                    );
                  });
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: const Text(
          'Counseling Form',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: const Color.fromRGBO(241, 227, 216, 1),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: createForm(),
      )
    );
  }

  createForm() {
    return ListView(
      children: [
        Container(
          //整体左右距离24
          margin: const EdgeInsets.only(left: 24, top: 32, right: 24, bottom: 24),
          child: Column(
            children: [
              //第一行 头像和顾问id
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      widget.model?.advisorAvatar ?? 'images/image1.jpeg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.model?.advisorName ?? 'Psychic Cynthia',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              //行1和行2之间的间距
              SizedBox(
                height: 40,
              ),
              //行2 Name
              Row(
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),
                  )
                ],
              ),
              //行2和行3的间距
              SizedBox(
                height: 8,
              ),
              //行3 Name TextField
              TextField(
                controller: myController,
                decoration: InputDecoration(
                    hintText: 'Please enter your name......'
                ),
                onChanged: (text){
                  setState(() {

                  });
                },
              ),
              //行3行4的间距
              SizedBox(
                height: 40,
              ),
              //行4 Text和Container和TextField
              inputRow('General Situation', 150.0, 0),
              //行4行5间距
              SizedBox(
                height: 12,
              ),
              //行5 第二个inputRow
              inputRow('Specific Question', 80, 1),
              //行5行6间距
              SizedBox(
                height: 18,
              ),
              //行6 下单按钮
              InkWell(
                child: Container(
                  height: 76,
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: setType() == false ? Colors.grey : const Color.fromRGBO(67, 115, 139, 1),
                      borderRadius: const BorderRadius.all(Radius.circular(24))
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('images/coin.png')),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${widget.model?.services?[0].servicePrice}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  if(myController.text.isEmpty){
                    showToast('name can not be empty');
                    return;
                  }
                  if(twoController.text.isEmpty){
                    showToast('situation can not be empty');
                    return;
                  }
                  if(threeController.text.isEmpty){
                    showToast('question can not be empty ');
                    return;
                  }
                  //final name = myController.text;
                  final situation = twoController.text;
                  final question = threeController.text;
                  final createTime = formatDate(DateTime.now(), ['MM', ' ', 'dd', ',', 'yyyy']);

                  EasyLoading.show(status: 'loading...');
                  Response? response = await Network.network?.creatOrder(widget.model?.advisorId ?? '', situation, question, widget.model?.services?[0].servicePrice ?? 0, widget.model?.services?[0].serviceName ?? '');
                  if (response == null) {
                    EasyLoading.showError('Create order error!!!');
                  } else {
                    EasyLoading.dismiss();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget inputRow(String text1, double height, int type) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text1,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
            height: height,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Color.fromRGBO(222, 222, 222, 1),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: TextField(
              scrollPadding: EdgeInsets.only(bottom: type == 0 ? 130 : 50),
                maxLines: 8,
                controller: type == 0 ? twoController : threeController,
                decoration: InputDecoration.collapsed(
                    hintText: 'Enter ${text1}....'
                ),
                onChanged: (text){
                  setState(() {

                  });
                },
              ),
        ),
      ],
    );
  }

  showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );
    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}


