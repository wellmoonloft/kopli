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

class Settings {
  int id;
  String currency;
  String language;

  Settings({this.id, this.currency, this.language});
  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    language = json['language'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['currency'] = this.currency;
    map['language'] = this.language;
    return map;
  }
}

class Invest {
  int id;
  String date;
  String perDate;
  String endDate;
  num amount;
  num received;
  String status;
  num interest;
  String code;
  String type;
  String currency;
  String country;
  num totalyield;
  Invest(
      {this.id,
      this.date,
      this.perDate,
      this.amount,
      this.endDate,
      this.received,
      this.code,
      this.type,
      this.status,
      this.currency,
      this.country,
      this.interest,
      this.totalyield});
  Invest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    perDate = json['perDate'];
    amount = json['amount'];
    endDate = json['endDate'];
    received = json['received'];
    code = json['code'];
    type = json['type'];
    status = json['status'];
    interest = json['interest'];
    currency = json['currency'];
    country = json['country'];
    totalyield = json['totalyield'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['date'] = this.date;
    map['perDate'] = this.perDate;
    map['amount'] = this.amount;
    map['endDate'] = this.endDate;
    map['received'] = this.received;
    map['code'] = this.code;
    map['type'] = this.type;
    map['status'] = this.status;
    map['interest'] = this.interest;
    map['currency'] = this.currency;
    map['country'] = this.country;
    map['totalyield'] = this.totalyield;
    return map;
  }
}

class Asset {
  int id;
  String date;
  num asset;
  num debt;
  String currency;
  Asset({this.id, this.date, this.asset, this.debt, this.currency});
  Asset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    asset = json['asset'];
    debt = json['debt'];
    currency = json['currency'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['date'] = this.date;
    map['asset'] = this.asset;
    map['debt'] = this.debt;
    map['currency'] = this.currency;
    return map;
  }
}

class Bill {
  int id;
  String date;
  String currency;
  String use;
  String categroy;
  num amount;
  num mark;
  Bill(
      {this.id,
      this.date,
      this.currency,
      this.amount,
      this.use,
      this.mark,
      this.categroy});
  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    currency = json['currency'];
    use = json['use'];
    amount = json['amount'];
    mark = json['mark'];
    categroy = json['categroy'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['date'] = this.date;
    map['currency'] = this.currency;
    map['use'] = this.use;
    map['amount'] = this.amount;
    map['mark'] = this.mark;
    map['categroy'] = this.categroy;
    return map;
  }
}