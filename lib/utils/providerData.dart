import 'package:flutter/material.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';

class ProviderData extends ChangeNotifier {
  List<Article> articleList;
  List<Sorts> sortsList;
  Article activeArticle;
  String dir = "";
  String activeData = "";
  bool isEdit = false;
  TextEditingController controller = TextEditingController();

  setDir(String _dir) {
    dir = _dir;
    notifyListeners();
  }

  setIsEdit(bool _isEdit) {
    isEdit = _isEdit;
    notifyListeners();
  }

  setController(String _text, TextSelection makeLast) {
    controller.text = _text;
    controller.selection = makeLast;
    notifyListeners();
  }

  setActveData(String _activeData) {
    activeData = _activeData;
    notifyListeners();
  }

  setActiveArticle(Article _activeArticle) {
    activeArticle = _activeArticle;
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
