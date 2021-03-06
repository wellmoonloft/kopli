# Kopli
![](https://img.shields.io/badge/Toolkit-Flutter-blue.svg)  ![](https://img.shields.io/badge/Language-Dart-orange.svg)  ![](https://img.shields.io/badge/license-WTFPL-0xFFFFFFFF)  ![](https://img.shields.io/badge/Process-Developing-blueviolet.svg)

 Markdown Editor
🇨🇳[简体中文](README-zh-cn.md) | 🇺🇸English

## Introduction

**Vara** [Estonian](Estonian for "Paddock") is a subdistrict of the district of Põhja-Tallinn (Northern Tallinn) in Tallinn, A markdown editor developed by flutter, it also integrates an interface for uploading blogs directly, which is convenient for individuals to write articles.

My current tool for writing articles is [Typora] (https://typora.io/), which is very beautiful and very easy to use, but since it needs to be manually upload to CMS after writing, it is very troublesome to manage, plus There is no iOS app on Typora, so I decided to pick one by myself. Of course, in fact, the most important thing is that flutter has launched version 2.0, and wants to try the so-called one-time coding six platform release.

The demand I want is this:
1. Able to upload to the CMS system with one click, and support one click to update articles
2. Apps of the same style can be written and viewed simultaneously on macOS and iOS
3. Support inserting pictures and uploading pictures automatically

![](https://i.loli.net/2021/03/14/ouYKUxm7NOXEePa.jpg)
![](https://i.loli.net/2021/03/14/nXGN3CcpzT2ODsd.jpg)
![](https://i.loli.net/2021/03/14/fWrMJynYP2GNqbB.jpg)
![](https://i.loli.net/2021/03/14/XpknhlRtErzbwxi.jpg)
------------------------------

## Quick start

1. Clone from git

2. Do `flutter create . ` in your project directory

3. Do `flutter packages get` in your project directory

4. If you want to use it in macOS, you need to add authorization in macos/Runner/*.entitlements, otherwise the sandbox mode cannot access network pictures

```
	<key>com.apple.security.network.client</key>
	<true/>
```

5. In order to hide the title bar on the macOS APP, use Xcode to open the project and click APP_NAME in macos/Runner>Runner>Resources>MainMenu.xib
  - Hide title = TRUE
  - Show Title bar = TRUE
  - Transparent Title Bar = TRUE
  - Full-Size Content View = TRUE

6. Set window size and initial window size, macos/Runner/MainFlutterWindow.swift
```
  self.contentMinSize = NSSize(width: 800, height: 600)
  self.setContentSize(NSSize(width: 1024, height: 768))
```

## Reference

- [Typora](https://typora.io/) Reference to Typora's design style.

## Dependents

- [font_awesome_flutter: ^8.11.0](https://pub.dev/packages/font_awesome_flutter) The Font Awesome Icon pack available as set of Flutter Icons.
- [intl: ^0.17.0](https://pub.dev/packages/intl) This package provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
- [sqflite: ^2.0.0+2](https://pub.dev/packages/sqflite) SQLite plugin for Flutter.
- [path: ^1.8.0](https://pub.dev/packages/path) A comprehensive, cross-platform path manipulation library for Dart.
- [path_provider: ^2.0.1](https://pub.dev/packages/path_provider) A Flutter plugin for finding commonly used locations on the filesystem. 
- [file_picker: ^3.0.0](https://pub.dev/packages/file_picker) A package that allows you to use a native file explorer to pick single or multiple absolute file paths, with extensions filtering support.
- [provider: ^5.0.0](https://pub.dev/packages/provider) A wrapper around InheritedWidget to make them easier to use and more reusable.
- [flutter_markdown: ^0.6.0](https://pub.dev/packages/flutter_markdown) A markdown renderer for Flutter. 
   
## Progress

It's not finished yet. I uploaded it to git just because there are two computers in my office and home, umm.
