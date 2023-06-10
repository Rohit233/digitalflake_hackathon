import 'package:digitalflake_hackathon/models/user_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/utils/basic_utils.dart';
import 'package:digitalflake_hackathon/utils/constants.dart';
import 'package:digitalflake_hackathon/views/home_screen_view/home_screen.dart';
import 'package:digitalflake_hackathon/views/login_screen_view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
    ReduxStore.initialize(); 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: ReduxStore.selectedWorkSpaceStore,
      child: StoreProvider(
        store: ReduxStore.bookingHistoryStore,
        child: StoreProvider(
          store: ReduxStore.loggedInUserDataStore,
          child: StoreProvider(
            store: ReduxStore.workspacesAvailibilityStore,
            child: StoreProvider(
                store: ReduxStore.slotsStore,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Digital Flake Hackathon',
                theme: ThemeData(
                  primaryColor: Constants.primaryColor,
                  buttonTheme: ButtonThemeData(
                    buttonColor:Constants.primaryColor,
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                                          floatingLabelStyle: TextStyle(color: Constants.primaryColor),
                                          prefixIconColor: Constants.primaryColor,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              borderSide: BorderSide(color: Constants.primaryColor)),
                                          enabledBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )),
                                          border: OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              borderSide: BorderSide(
                                                color: Constants.primaryColor,
                                              )),
                                        ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          fixedSize: const Size(300,50),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)))
                    )
                  ) 
                ),
                home: FutureBuilder(
                  future: BasicUtils.getUserDataFromSharedPreference(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                         child:  CircularProgressIndicator(),
                      );
                    }
                    return StoreConnector<UserData?,UserData?>(
                      builder: ((context, UserData? userData) {
                        if(userData == null) {
                          return const LoginScreen();
                        }
                        return const HomeScreen();
                    }), converter: (store) => store.state,);
                  }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
