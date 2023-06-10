
import 'package:digitalflake_hackathon/models/user_data.dart';
import 'package:digitalflake_hackathon/redux/user_data_redux/actions.dart' as user_data_actions;

//* LOGGEDIN USER DATA REDUCER 
UserData? loggedInUserDataReducer(UserData? prevUserData,dynamic action) {
  UserData? newUserData = prevUserData;
  if(action is user_data_actions.UpdateUserData) {
     newUserData = action.payload;
  }
  return newUserData;
} 