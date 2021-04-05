
import 'package:flutter/material.dart';
import 'package:quote_app/data/model/BaseQuoteModel.dart';
import 'package:quote_app/data/network/Resource.dart';
import 'package:quote_app/repo/ApiRepo.dart';

class QuoteProvider extends ChangeNotifier {
  Resource<List<BaseQuoteModel>> _quote;

  Resource<List<BaseQuoteModel>> get quote => _quote;

  List<BaseQuoteModel> _quoteFav = [];

  List<BaseQuoteModel> get quoteFav => _quoteFav;

  BaseQuoteModel _quotDetails;

  BaseQuoteModel get quotDetails => _quotDetails;

  addFav(quote) {
    _quoteFav.add(quote);
    notifyListeners();
  }

  removeFav(quote) {
    _quoteFav.remove(quote);
    notifyListeners();
  }

  details(quotDetails) {
    _quotDetails = quotDetails;
    notifyListeners();
  }

  getQuote() async {
    _quote = Resource.loading(true);
    try {
      List<BaseQuoteModel> quoteModel = await ApiRepo.instance.getQuote();
      _quote = Resource.success(quoteModel);
      notifyListeners();
    } catch (e) {
      _quote = Resource.error(e.toString());
      notifyListeners();
    }
  }
}
