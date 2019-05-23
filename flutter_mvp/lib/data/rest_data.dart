import 'package:flutter_mvp/models/user.dart';
import 'package:flutter_mvp/utils/network_utils.dart';
import 'dart:async';

class RestData {
  NetworkUtil _netUtil = NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";


  Future<User> login(String username, String password){
    return new Future.value(new User(username, password));
  }
}