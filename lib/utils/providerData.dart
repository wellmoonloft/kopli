import 'package:flutter/material.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';

class ProviderData extends ChangeNotifier {
  // List<CurrencyData> currencyData = CurrencyData.currencyList;
  // CurrencyData currency;

  List<String> documentList = [];
  List<Article> articleList;

  setDocumentList(List<String> _documentList) {
    documentList = _documentList;
    notifyListeners();
  }

  Future getArticle() async {
    articleList = await DBHelper().getArticle();
    notifyListeners();
  }

  Future<int> setArticle(Article article) async {
    int id = await DBHelper().updateArticle(article);
    return id;
  }

  // Future setPerson(Person _person) async {
  //   await DBHelper().updatePerson(_person);
  //   notifyListeners();
  // }

  // setCurrencyData(eurData, currencyTilte) {
  //   currencyData.forEach((element) {
  //     if (eurData != null) {
  //       if (element.short == 'EUR') {
  //         element.rate = 1;
  //       } else {
  //         element.rate = eurData[element.short];
  //       }
  //     } else {
  //       element.rate = 1;
  //     }

  //     if (element.short == currencyTilte) {
  //       currency = element;
  //     }
  //   });
  //   notifyListeners();
  // }

  // setCurrency(String short) {
  //   currencyData.forEach((element) {
  //     if (element.short == short) {
  //       currency = element;
  //     }
  //   });
  //   notifyListeners();
  // }

}
