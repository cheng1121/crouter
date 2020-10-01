import 'dart:io';

///获取当前所在目录
String localePath() {
  final envVarMap = Platform.environment;
  return envVarMap['PWD'];
}

bool isDartFile(String path) {
  return path.endsWith('.dart');
}

///import 'package:crouter/src/bean/page_bean.dart';
String import(String package, String path) {
  return '''import \'package:${package}${path}\';\n''';
}

///author: cheng
///date: 2020/9/28
///time: 2:05 PM
///desc: 导入WidgetBuilder
String importWidgets() {
  return 'import \'package:flutter/widgets.dart\';\n';
}

String pageStr(String pageName, String className) {
  return '\'$pageName\':(context) => ${className}(),\n';
}

String moduleClassPage(String routeName) {
  final page = routeName.split('/').last;
  final name = toFirstUpper(page, true);
  return 'static const String $name = \'$routeName\';\n';
}

///author: cheng
///date: 2020/10/1
///time: 10:53 AM
///desc: 单词首字母大写(变量第一个单词首字母小写)
String toFirstUpper(String text, bool isVar) {
  String castUpper(String text) {
    ///修改首字母为大写
    final first = text.substring(0, 1);
    final name = text.replaceFirst(first, first.toUpperCase());
    return name;
  }

  String castLower(String text) {
    final first = text.substring(0, 1);
    final name = text.replaceFirst(first, first.toLowerCase());
    return name;
  }

  final sb = StringBuffer();
  if (text.contains('_')) {
    final list = text.split('_');
    for (final str in list) {
      sb.write(castUpper(str));
    }
  } else {
    sb.write(castUpper(text));
  }

  ///是变量
  if (isVar) {
    final name = castLower(sb.toString());
    sb.clear();
    sb.write(name);
  }

  return sb.toString();
}

String moduleClass(String moduleName, String pages) {
  ///获取类名
  final name = toFirstUpper(moduleName, false);
  print('generate file =========$name');
  return '''
  class $name{
  $name._();
  
  $pages
  
  }
  ''';
}

///author: cheng
///date: 2020/9/28
///time: 2:07 PM
///desc: class 字符串
String routeClass(String pages) {
  return '''
     ${importWidgets()}
    class RouteList{
     static final routeMap =<String,WidgetBuilder>{
       $pages
     };
    }
  ''';
}
