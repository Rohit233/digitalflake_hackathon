import 'package:digitalflake_hackathon/enums/snackbar_type_enum.dart';
import 'package:digitalflake_hackathon/models/user_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/services/auth_services.dart';
import 'package:digitalflake_hackathon/utils/basic_utils.dart';
import 'package:digitalflake_hackathon/utils/navigator_utils.dart';
import 'package:digitalflake_hackathon/views/home_screen_view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:digitalflake_hackathon/redux/user_data_redux/actions.dart' as user_data_actions;

class CreateAccViewModel {
  //* CREATE ACCOUNT FUNCTION
   Future createAccount(BuildContext context, String name, String email,String mobileNumber) async {
      if(email.isEmpty) {
      BasicUtils.showSnackBar(context, 'Enter email', SnackBarType.ERROR);
      return;
    }
    else if(name.isEmpty) {
      BasicUtils.showSnackBar(context, 'Enter full name', SnackBarType.ERROR);
      return;
    }
    else if (mobileNumber.isEmpty) {
      BasicUtils.showSnackBar(context, 'Enter mobile number', SnackBarType.ERROR);
      return;
    }
    UserData userData = await AuthServices.createAccout(context,email,name,mobileNumber);
    await BasicUtils.setUserDataInSharedPreference(userData);
    ReduxStore.loggedInUserDataStore.dispatch(user_data_actions.UpdateUserData(userData));
    // ignore: use_build_context_synchronously
    NavigatorUtils.navigate(context, const HomeScreen());
    
  }
}