import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:crouter/src/bean/page_bean.dart';
import 'package:crouter/src/utils/util.dart';

import '../crouter.dart';

///author: cheng
///date: 2020/9/26
///time: 12:32 AM
///desc: 分析dart类，查找CRouter注解
class AnalyzerAnnotation {
  void readFile(File file) {
    var content = file.readAsStringSync();
    var result = parseString(content: content);
    var unit = result.unit;
    unit.visitChildren(CRouterVisitor(file.path));
  }
}

class CRouterVisitor extends RecursiveAstVisitor {
  final String path;
  static const String annotation = 'CRouter';
  var className;

  CRouterVisitor(this.path);

  @override
  dynamic visitAnnotation(Annotation node) {
    if (node.name.name == annotation) {
      final routeName = node.arguments.arguments.first.toSource();
      var moduleName;
      if (!routeName.contains('/')) {
        stderr.writeln(
            'crouter 格式错误: routeName=$routeName. 正确格式为：moduleName/pageName');
      } else {
        final list = routeName.split('/');
        moduleName = list.first.substring(1);
      }

      if (!path.contains(moduleName)) {
        stderr.writeln('$moduleName中，未发现$path文件');
      }
      var importPath = path.split('lib').last;

      ///得到路由注解,并解析
      final page = PageBean(
        className: className,
        moduleName: moduleName,
        routeName: routeName.substring(1, routeName.length - 1),
        import: import(moduleName, importPath),
      );

      ///检查是否有重复命名
      final index =
          pages.indexWhere((element) => element.routeName == page.routeName);
      if (index > -1) {
        stderr.writeln('crouter 命名重复 ${page.routeName}');
      } else {
        stdout.writeln('扫描到页面：${page.asMap()}');
        pages.add(page);
      }
    }
  }

  @override
  dynamic visitClassDeclaration(ClassDeclaration node) {
    className = node.name.name;
    return super.visitClassDeclaration(node);
  }

  @override
  dynamic visitImportDirective(ImportDirective node) {}
}
