# Kopli
![](https://img.shields.io/badge/Toolkit-Flutter-blue.svg)  ![](https://img.shields.io/badge/Language-Dart-orange.svg)  ![](https://img.shields.io/apm/l/vim-mode)  ![](https://img.shields.io/badge/Process-Developing-blueviolet.svg)

 Markdown编辑器

 🇨🇳简体中文 | 🇺🇸[English](https://github.com/wellmoonloft/kopli)

## 简介

**Kopli** 【爱沙尼亚语是围栏的意思，是北塔林的一个区域的名字】，是使用**flutter**开发的基于Markdown的编辑器，并集成直接上传博客的接口，方便个人写文章使用。

我目前写文章的工具是[Typora](https://typora.io/)，非常漂亮也非常好用，不过由于每次写完还需要手动粘贴到CMS上面，管理起来也挺麻烦，再加上Typora没有iOS端应用，所以我决定自己撸一个。当然了，其实最主要的还是flutter推出了2.0版本，想要试试所谓的一次编码六平台发布。

我想要的需求是这样的：
1. 能够一键上传到CMS系统，并支持一键更新文章
2. 同样风格的APP可以在macOS和iOS上同步编写和查看
3. 支持插入图片自动上传图床

![](https://i.loli.net/2021/03/14/ouYKUxm7NOXEePa.jpg)
![](https://i.loli.net/2021/03/14/nXGN3CcpzT2ODsd.jpg)
![](https://i.loli.net/2021/03/14/fWrMJynYP2GNqbB.jpg)
![](https://i.loli.net/2021/03/14/XpknhlRtErzbwxi.jpg)
------------------------------

## 快速开始

1. Clone 项目

2. 在项目目录中执行 `flutter create . `

3. 在项目目录中执行 `flutter packages get`

4. 如果想要在macOS当中使用的话，需要在macos/Runner/*.entitlements当中添加授权，否则沙盒模式无法访问网络图片

```
	<key>com.apple.security.network.client</key>
	<true/>
```

5. 为了隐藏macOS APP上的标题栏，使用Xcode打开工程，在macos/Runner>Runner>Resources>MainMenu.xib当中点击APP_NAME
  - Hide title = TRUE
  - Show Title bar = TRUE
  - Transparent Title Bar = TRUE
  - Full-Size Content View = TRUE

6.设置窗口最小值以及初始化窗口大小，macos/Runner/MainFlutterWindow.swift
```
  self.contentMinSize = NSSize(width: 800, height: 600)
  self.setContentSize(NSSize(width: 1024, height: 768))
```

## 参考
- [Typora](https://typora.io/) 参考了Typora的设计风格。

## 依赖

- [font_awesome_flutter: ^8.11.0](https://pub.dev/packages/font_awesome_flutter) Font Awesome Icon 的字体图标包，可以用于flutter的图标。
- [intl: ^0.17.0](https://pub.dev/packages/intl) 提供国际化和本地化功能，包括消息翻译，复数形式和性别，日期/数字格式和解析以及双向文本。
- [sqflite: ^2.0.0+2](https://pub.dev/packages/sqflite) SQLite用于flutter的插件。
- [path: ^1.8.0](https://pub.dev/packages/path) 适用于Dart的全面的跨平台路径处理库。
- [path_provider: ^2.0.1](https://pub.dev/packages/path_provider) Flutter插件，用于查找文件系统上的常用位置。
- [file_picker: ^3.0.0](https://pub.dev/packages/file_picker) 用于本机文件浏览器来选择单个或多个绝对文件路径，并具有扩展名过滤支持。
- [provider: ^5.0.0](https://pub.dev/packages/provider) InheritedWidget的包装 ，使它们更易于使用和可重复使用。
- [flutter_markdown: ^0.6.0](https://pub.dev/packages/flutter_markdown) 用于解析并渲染markdown语法。

## 进度

目前还未完成，上传到git只是因为我办公室和家里面有两台电脑，嗯。


## Todo List 

### 页面  
 
- [x] 主页面  
  - [x] 文章区域：文章列表、
  - [x] 编辑区域：文章编辑、保存、更新
  - [x] 预览区域：文章预览  
  

### 基础  
- [x] 数据库：SQLite
- [ ] 本地存储、云存储（iCloud、GooGle Driver）+ （还没对选择路径进行变更，目前不能用）
- [ ] 整体样式：-v0.1
- [ ] 数据上传：
- [ ] 接口自定义：


### Mark



使用 file_chooser插件需要添加 com.apple.security.files.user-selected.read-only或 com.apple.security.files.user-selected.read-write权利。