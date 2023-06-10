import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digitalflake_hackathon/enums/snackbar_type_enum.dart';
import 'package:digitalflake_hackathon/utils/basic_utils.dart';
import 'package:http/http.dart' as http;

class ServicesUtils {
  static int httpRequestTimeout = 120;
  static String timpoutError = 'Request timeout';

//* SEND HTTP SEND REQUEST FUN
  static Future sendHttpGetRequest(
      String url,context) async {
    try {
      http.Response response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: httpRequestTimeout),);
      var resBody = jsonDecode(response.body);
      return resBody;
    } on http.ClientException catch (error) {
      BasicUtils.showSnackBar(context, error.message, SnackBarType.ERROR);
    } on SocketException catch (error) {
      BasicUtils.showSnackBar(context, error.message, SnackBarType.ERROR);
    } on TimeoutException {
      BasicUtils.showSnackBar(context, 'Request timeout', SnackBarType.ERROR);
    }
    return null;
}

//* SEND HTTP POST REQUEST FUN
  static Future sendHttpPostRequest(String url, payload, context) async {
    try {
      http.Response response = await http
          .post(Uri.parse(url),
              body: jsonEncode(payload))
          .timeout(Duration(seconds: httpRequestTimeout),);
      var resBody = jsonDecode(response.body);
      return resBody;
    } on http.ClientException catch (error) {
      BasicUtils.showSnackBar(context, error.message, SnackBarType.ERROR);
    } on SocketException catch (error) {
      BasicUtils.showSnackBar(context, error.message, SnackBarType.ERROR);
    } on TimeoutException {
      BasicUtils.showSnackBar(context, 'Request timeout', SnackBarType.ERROR);
    }
    return null;
  }


}