import 'package:quote_app/data/model/BaseQuoteModel.dart';
import 'package:quote_app/data/network/ApiHelper.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quote_app/data/network/AppException.dart';


class ApiRepo {
  static final ApiRepo _singleton = ApiRepo();

  static ApiRepo get instance => _singleton;


  Future<List<BaseQuoteModel>> getQuote() async {
    final response = await ApiHelper.instance.getQuote();
    return  (response as List)
        .map((p) => BaseQuoteModel.fromJson(p))
        .toList();
  }

}
