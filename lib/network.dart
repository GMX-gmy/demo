import 'dart:convert';

import 'package:demo/advisor_model.dart';
import 'package:demo/orderModel.dart';
import 'package:dio/dio.dart';

class Network{

  static Network? network;
  Dio? dio;

  final baseUrl = 'https://c5qyslgwde.execute-api.us-east-1.amazonaws.com/prod/';
  final routeLogin = '/login';
  final routeUserMe = '/me';
  final routeAdvisor = '/advisor-list';
  final routeOrderDetail = '/advisor-detail?advisor_id=100001';
  final routeOrderList = '/order-list';
  final routeCreateOrder  = '/create-order';

  static Future<Network> getNetwork() async {
    if (network == null){
      network = Network();
      network?.dio = Dio(BaseOptions(baseUrl: network!.baseUrl));
      //登录
      // Response? response = await network?.login();
      // if (response?.statusCode == 200) {
      //   network?.getUserMe();
      // }

      //获取个人信息
      //network?.getUserMe();

      //获取顾问列表
      //Response? response = await network?.getAdvisorList();
      //解析接口返回的数据
      //final responseObject = json.decode(response!.data.toString());

      //print('advisorList ======== $list');
      //network?.getOrderDetail();
      //network?.getOrderList();
    }
    return network!;
  }

  Future<Response?> login() async {
    Response? response = await network?.dio?.post(routeLogin, data: {'username': 'test1', 'password': 'pass1'});
    int code = response?.statusCode ?? 404;
    print('code ========== $code');
    final jsonString = response?.data.toString();
    print('login jsonString ========== $jsonString');
    return response;
  }

  Future<Response?> getUserMe() async {
    Response? response = await network?.dio?.get(network!.routeUserMe);
    final jsonString = response?.data.toString();
    print('userMe jsonString ========== $jsonString');
    return response;
  }

  Future<Response?> updateUserMe(String name, String bio, String aboutMe) async{
    Response? response = await network?.dio?.post(network!.routeUserMe, data: {"name":name, "bio":bio, "aboutMe":aboutMe});
    int code = response?.statusCode ?? 404;
    print('code ========== $code');
    final jsonString = response?.data.toString();
    print('update jsonString =========== $jsonString');
    return response;
  }

  Future<List<AdvisorModel>> getAdvisorList() async {
    Response? response = await network?.dio?.get(network!.routeAdvisor);
    List<AdvisorModel> list = getAdvisorModelList(response!.data);
    return list;
  }

  Future<Response?> getOrderDetail() async {
    Response? response = await network?.dio?.get(network!.routeOrderDetail);
    final jsonString = response?.data.toString();
    print('orderDetail ===== $jsonString');
    return response;
  }

  Future<List<orderModel>> getOrderList() async {
    Response? response = await network?.dio?.get(network!.routeOrderList);
    List<orderModel> list = getorderModelList(response!.data);
    return list;
  }

  Future<Response?> creatOrder(String advisor_id, String situation, String question, int price, String type) async {
    Response? response = await network?.dio?.post(network!.routeCreateOrder,data: {"advisor_id": "100001","situation": situation,
      "question": question,
      "price": price,
      "type": type}  );
    return response;
  }
}
