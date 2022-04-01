import 'package:demo/HiveUtil.dart';
import 'package:demo/orderModel.dart';
import 'package:flutter/cupertino.dart';

class UserInfoChangeNotifier extends ChangeNotifier {
  updateUsername(String name) {
    HiveUtil.instance?.updateUsername(name);
    notifyListeners();
  }

  updateAvatar(String avatar) {
    HiveUtil.instance?.updateAvatar(avatar);
    notifyListeners();
  }

  updateGender(int gender) {
    HiveUtil.instance?.updateGender(gender);
    notifyListeners();
  }

  updateBirth(String birth) {
    HiveUtil.instance?.updateBirth(birth);
    notifyListeners();
  }
}
