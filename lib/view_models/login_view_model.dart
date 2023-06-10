import 'package:digitalflake_hackathon/enums/snackbar_type_enum.dart';
import 'package:digitalflake_hackathon/models/user_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/services/auth_services.dart';
import 'package:digitalflake_hackathon/utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:digitalflake_hackathon/redux/user_data_redux/actions.dart' as user_data_actions;

class LoginViewModel {

  //* LOGIN FUNCTION
   Future login(BuildContext context, String email,String password) async {
    if(email.isEmpty) {
        BasicUtils.showSnackBar(context, 'Enter email', SnackBarType.ERROR);
        return;
    }
    else if (password.isEmpty) {
      BasicUtils.showSnackBar(context, 'Enter password', SnackBarType.ERROR);
      return;
    }
    UserData userData = await AuthServices.login(context, email, password);
    await BasicUtils.setUserDataInSharedPreference(userData);
    ReduxStore.loggedInUserDataStore.dispatch(user_data_actions.UpdateUserData(userData));
  }
}