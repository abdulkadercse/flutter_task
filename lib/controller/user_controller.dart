import 'dart:convert';

import 'package:http/http.dart' as http;
import '../const/server_config.dart';
import '../model/user_model.dart';
class UserController{
  Future<UserModel> getData() async {
    var url = ServerConfig.baseUrl;
    var response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return UserModel.fromJson(jsonDecode(response.body));
    }else{
      return throw Exception("Something wrong, please try again");
    }
  }
}