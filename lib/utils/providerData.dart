import 'package:flutter/material.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';

class ProviderData extends ChangeNotifier {
  // List<CurrencyData> currencyData = CurrencyData.currencyList;
  // CurrencyData currency;

  List<String> documentList = [];
  List<Article> articleList;
  List<Sorts> sortsList;

  setDocumentList(List<String> _documentList) {
    documentList = _documentList;
    notifyListeners();
  }

  Future getArticle() async {
    articleList = await DBHelper().getArticle();
    notifyListeners();
  }

  Future getSorts() async {
    sortsList = await DBHelper().getSorts();
    notifyListeners();
  }
}
