class Article {
  int id;
  String createDate;
  String editDate;
  String title;
  String fileName;
  String filePath;
  String sort;
  String outline;

  Article(
      {this.id,
      this.createDate,
      this.editDate,
      this.title,
      this.fileName,
      this.filePath,
      this.sort,
      this.outline});
  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    editDate = json['editDate'];
    title = json['title'];
    fileName = json['fileName'];
    filePath = json['filePath'];
    sort = json['sort'];
    outline = json['outline'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['createDate'] = this.createDate;
    map['editDate'] = this.editDate;
    map['title'] = this.title;
    map['fileName'] = this.fileName;
    map['filePath'] = this.filePath;
    map['sort'] = this.sort;
    map['outline'] = this.outline;
    return map;
  }
}

class Sorts {
  int id;
  String sortsName;
  String sortsCode;

  Sorts({this.id, this.sortsName, this.sortsCode});
  Sorts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sortsName = json['sortsName'];
    sortsCode = json['sortsCode'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['sortsName'] = this.sortsName;
    map['sortsCode'] = this.sortsCode;
    return map;
  }
}
