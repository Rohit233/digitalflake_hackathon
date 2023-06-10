import 'package:digitalflake_hackathon/enums/snackbar_type_enum.dart';
import 'package:digitalflake_hackathon/models/user_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digitalflake_hackathon/redux/user_data_redux/actions.dart' as user_data_actions;

class BasicUtils {
  static showSnackBar(BuildContext context, String msg, SnackBarType? type) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
        backgroundColor: type == SnackBarType.SUCCESS
            ? Colors.greenAccent
            : type == SnackBarType.ERROR
                ? Colors.redAccent
                : null,
        content: Text(msg)));
  }

  //* SET USER DATA IN SHARED PREFERENCE 
  static Future setUserDataInSharedPreference(UserData userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userData.email);
    prefs.setString('mobileNumber', userData.mobileNumber);
    prefs.setString('name', userData.name);
    prefs.setInt('userId', userData.userId);
    return;
  }
  
  //* GET USER DATA FROM SHARED PREFERENCE
  static Future getUserDataFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? email = prefs.getString('email');
    String? name = prefs.getString('name');
    String? mobileNumber = prefs.getString('mobileNumber');
    if(userId == null || email == null || name == null || mobileNumber == null) {
      return null;
    }
    UserData userData = UserData( userId: userId , email: email, name: name, mobileNumber: mobileNumber);
    ReduxStore.loggedInUserDataStore.dispatch(user_data_actions.UpdateUserData(userData));
  }


}