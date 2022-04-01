import 'dart:convert';
import 'dart:io';
import 'package:demo/advisor_model.dart';
import 'package:demo/orderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// Hive 数据操作
class HiveUtil {
  /// 实例
  static HiveUtil? instance;
  /// 标签
  Box? infoBox;
  Box? advisorBox;
  Box? orderBox;

  /// 初始化，需要在 main.dart 调用
  /// <https://docs.hivedb.dev/>
  static Future<void> install() async {
    /// 初始化数据库地址
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);

    /// 注册自定义对象（实体）
    /// <https://docs.hivedb.dev/#/custom-objects/type_adapters>
    /// Hive.registerAdapter(SettingsAdapter());
  }

  /// 初始化 Box
  static Future<HiveUtil> getInstance() async {
    if (instance == null) {
      instance = HiveUtil();
      await Hive.initFlutter();
      /// 标签
      instance!.infoBox = await Hive.openBox('Infos');
      instance!.orderBox = await Hive.openBox('orders');
      instance!.advisorBox = await Hive.openBox('advisors');
    }
    return instance!;
  }

  List<orderModel> getOrders() {
    String jsonString = orderBox?.get('orderList') ?? '';
    print('get jsonString ====== $jsonString');
    if (jsonString.isEmpty) {
      return [];
    }
    final jsonObject = json.decode(jsonString);
    print('get jsonObject ======== $jsonObject');
    return getorderModelList(jsonObject);
  }

  saveOrder(orderModel order) {
    List<orderModel> orders = instance?.getOrders() ?? [];
    orders.insert(0, order);
    final jsonString = json.encode(orders);
    print('order jsonstring =========== $jsonString');
    orderBox?.put('orderList', jsonString);
  }

  saveOrderList(List<orderModel> list) {
    final jsonString = json.encode(list);
    orderBox?.put('orderList', jsonString);
  }

  List<AdvisorModel> getAdvisors() {
    String jsonString = advisorBox?.get('advisorList') ?? '';
    if(jsonString.isEmpty) {
      return [];
    }
    final jsonObject = json.decode(jsonString);
    print("getAdvisors jsonString ========= $jsonString");
    return getAdvisorModelList(jsonObject);
  }

  saveAdvisor(List<AdvisorModel> list) {
    final jsonString = json.encode(list);
    advisorBox?.put('advisorList', jsonString);
  }

  updateAvatar(String avatar){
    infoBox?.put('avatar', avatar);
  }

  updateUsername(String name){
    infoBox?.put('username', name);
  }

  updateBio(String bio){
    infoBox?.put('bio', bio);
  }

  updateGender(int gender){
    infoBox?.put('gender', gender);
  }

  updateBirth(String birth){
    infoBox?.put('birth', birth);
  }

  updateAbout(String about){
    infoBox?.put('about', about);
  }

  String getAvatar(){
    return infoBox?.get('avatar') ?? '';
  }

  String getUsername(){
    return infoBox?.get('username') ?? 'Lily';
  }

  String getBio(){
    return infoBox?.get('bio') ?? '';
  }

  int getGender(){
    return infoBox?.get('gender') ?? 0;
  }

  String getBirth(){
    return infoBox?.get('birth') ?? '';
  }

  String getAbout(){
    return infoBox?.get('about') ?? '';
  }
}