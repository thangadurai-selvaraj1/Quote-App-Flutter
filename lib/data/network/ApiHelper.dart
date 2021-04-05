
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:quote_app/data/network/ApiEndPoint.dart';
import 'AppException.dart';

class ApiHelper {
  static final ApiHelper _singleton = ApiHelper();

  static ApiHelper get instance => _singleton;

  Future<dynamic> getQuote() async {
    var response;
    try {
      var result = await http.get(Uri.https(ApiEndPoint.BASE_URL, ApiEndPoint.QUOTE_END_POINT));
      response = _returnResponse(result);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  dynamic _returnResponse(http.Response response) {
    if(response.statusCode == 200){
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    }
    else{
      return FetchDataException("Unable to fetch");
    }
  }

}
