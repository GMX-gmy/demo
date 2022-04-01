import 'dart:convert';

import 'package:demo/HiveUtil.dart';
import 'package:demo/JsonUtil.dart';
import 'package:demo/network.dart';
import 'package:demo/orderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatefulWidget{
  const OrderListPage({Key? key}) : super(key : key);
  @override
  OrderListPageState createState() => OrderListPageState();
}

class OrderListPageState extends State<OrderListPage>{

  List<orderModel> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataList = HiveUtil.instance?.getOrders() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        appBar: AppBar(
          title: const Text(
            'My Order',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: const Color.fromRGBO(241, 227, 216, 1),
        ),
        body:FutureBuilder(
          future: Network.network?.getOrderList(),
          builder: (context, snapshot){
            if (snapshot.hasData == true) {
              dataList = snapshot.data as List<orderModel>;
              HiveUtil.instance?.saveOrderList(dataList);
              //final localList = HiveUtil.instance?.getOrders() ?? [];
              //dataList.insertAll(0, localList);
              print('dataList = $dataList');
            }else if(snapshot.hasError){
              print('error ====== ${snapshot.error}');
            }
            return buildOrderList();
          },
        )
    );
  }

  Container _buildListViewTile(int index) {
    orderModel model = dataList[index];
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(248, 242, 238, 1),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  model.advisor.advisorAvatar ?? "",
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                model.advisor.advisorName ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 1,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(240, 222, 206, 1)
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                model.type,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Text(
                  model.question,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 100,
                ),
              ),
              Text(
                'Mar 14, 2022',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ListView buildOrderList() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 24, bottom: 8),
        itemCount: dataList.length,
        //itemExtent: 180,
        shrinkWrap: false,
        itemBuilder: (BuildContext context, int index){
          return _buildListViewTile(index);
        }
    );
  }
}

