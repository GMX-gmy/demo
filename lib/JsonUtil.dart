import 'package:flutter/services.dart';
import 'package:demo/InfoModel.dart';
import 'dart:convert';
import 'package:demo/UerInfoChangeNotifier.dart';

class JsonUtil {

  static JsonUtil? instance;
  UserInfoChangeNotifier? infoChangeNotifier;
  List<InfoModel> infoModels = [];

  static Future<JsonUtil> initInstance() async {
    if (instance == null) {
      instance = JsonUtil();
      instance!.infoChangeNotifier = UserInfoChangeNotifier();
    }
    return instance!;
  }
}