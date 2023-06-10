import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorUtils {
//* NAVIGATOR FUN
  static Future navigate(context, page,) async {
    await Navigator.of(context).push(
        PageTransition(
          child: page,
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
          isIos: true,
        ));
    return;
  }

//* NAVIGATOR PUSH AND REMOVE UNTIL
  static Future navigatePushReplacement(context,page,{Color previousStatusBarColor = Colors.white})async {
    await Navigator.pushReplacement(
        context,
        PageTransition(
          child: page,
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
          isIos: true,
        ));
  }

//* NAVIGATE BACK
  static navigateBack(BuildContext context){
    Navigator.pop(context);
  } 
  
}