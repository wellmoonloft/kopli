import 'dart:io';
import 'package:kopli/model/dataModels.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Database _db;

class DBHelper {
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDatabase();
      return _db;
    }
  }

  initDatabase() async {
    Database _db;
    await getApplicationDocumentsDirectory().then((value) async {
      Directory directory = new Directory('${value.path}/db');
      if (!directory.existsSync()) {
        directory.createSync();
      }
      String path = p.join(directory.path, 'kopli.db');
      await openDatabase(path, version: 1, onCreate: _onCreate)
          .then((database) {
        debugPrint('数据库路径' + path);
        _db = database;
      });
    });
    return _db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE article (id INTEGER PRIMARY KEY, createDate TEXT, editDate TEXT, title TEXT, fileName TEXT,filePath TEXT, sort TEXT, outline TEXT)');
    // await db.execute(
    //     'CREATE TABLE invest (id INTEGER PRIMARY KEY, date TEXT, perDate TEXT, amount INTEGER, endDate TEXT,  received INTEGER,code TEXT, type TEXT, status TEXT,interest INTEGER,currency TEXT,country TEXT,totalyield INTEGER)');
    // await db.execute(
    //     'CREATE TABLE asset (id INTEGER PRIMARY KEY, date TEXT,currency TEXT, asset INTEGER, debt INTEGER)');
    // await db.execute(
    //     'CREATE TABLE bill (id INTEGER PRIMARY KEY, date TEXT, currency TEXT, use TEXT, categroy TEXT,amount INTEGER, mark INTEGER)');
    // await db.execute(
    //     'CREATE TABLE settings (id INTEGER PRIMARY KEY, currency TEXT,language TEXT)');

    // Settings settings = Settings();
    // settings.currency = 'EUR';
    // settings.language = 'EN';
    // await db.insert('settings', settings.toJson());
    // Person person = Person();
    // person.age = 25;
    // person.firstname = 'Vara';
    // person.lastname = 'wellmoonloft';
    // person.sex = 1;
    // await db.insert('person', person.toJson());
  }

  Future<List<Article>> getArticle() async {
    var dbClient = await db;
    var result = await dbClient.query('article',
        columns: [
          'id',
          'createDate',
          'editDate',
          'title',
          'fileName',
          'filePath',
          'sort',
          'outline'
        ],
        orderBy: 'editDate');
    List<Article> article = [];
    result.forEach((element) => article.add(Article.fromJson(element)));
    return article;
  }

  Future<int> updateArticle(Article article) async {
    var dbClient = await db;
    if (article.id != null) {
      return await dbClient.update("article", article.toJson(),
          where: 'id = ?', whereArgs: [article.id]);
    } else {
      return await dbClient.insert("article", article.toJson());
    }
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'person',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
