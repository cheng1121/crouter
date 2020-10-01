import 'package:app_base/app_base.dart';
import 'package:example/main.dart';
import 'package:example/example.dart';
import 'package:flutter/widgets.dart';

class RouteList {
  static final routeMap = <String, WidgetBuilder>{
    'app_base/base': (context) => BasePage(),
    'app_base/splash': (context) => Splash(),
    'app_base/user_login': (context) => Login(),
    'app_base/login_reset_pwd': (context) => Reset(),
    'example/home': (context) => MyHomePage(),
    'example/test1': (context) => Test1(),
    'example/test2': (context) => Test2(),
    'example/test3': (context) => Test3(),
    'example/test4': (context) => Test4(),
    'example/test5': (context) => Test5(),
  };
}
