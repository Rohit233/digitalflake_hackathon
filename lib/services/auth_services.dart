import 'package:digitalflake_hackathon/models/user_data.dart';
import 'package:digitalflake_hackathon/utils/api_routes.dart';
import 'package:digitalflake_hackathon/utils/services_utils.dart';
import 'package:flutter/widgets.dart';


class AuthServices {

  //* LOGIN SERVICE 
   static Future<UserData> login(BuildContext context, String email,String password) async {
      var payload = {
        'email': email,
        'password': password,
      };
      String url = ApiRoutes.getLoginApiRoute();
      var res = await ServicesUtils.sendHttpPostRequest(url, payload, context);
      UserData userData = UserData(userId: res['user_id'], email: email, name: 'Rohit Lokhande',mobileNumber: '7517910673');
      return userData;
   }

  //* CREATE ACCOUT SERVICE
  static Future<UserData> createAccout(BuildContext context,String email, String name,String mobileNumber) async {
    var payload = {
      'email': email,
      'name': name,
    };
    String url = ApiRoutes.getCreateAccountApiRoute();
    var res = await ServicesUtils.sendHttpPostRequest(url, payload, context);
    UserData userData = UserData(userId: res['user_id'], email: email, name: name,mobileNumber: mobileNumber);
    return userData;
  }  
}