import 'dart:io';
import 'package:crouter/src/analyzer/analyzer_annotation.dart';
import 'package:crouter/src/bean/page_bean.dart';
import 'package:crouter/src/generate/generate_module.dart';

import 'generate/generate_file.dart';
import 'utils/util.dart';

final pages = <PageBean>[];

void run() {
  stdout.writeln('begin scanning crouter annotation...');
  final path = localePath();
  Scanning()..scanning(path);
  stdout.writeln('扫描完成：已扫描到页面数量：${pages.length} ');

  ///生成路由表
  GenerateFile()..generate('$path/lib');
  GenerateModule()..generate();
}

///扫描文件
class Scanning {
  final annotationFiles = <File>[];

  void scanning(String path) {
    final dir = Directory(path);
    var analyzerAnnotation = AnalyzerAnnotation();
    if (dir.existsSync()) {
      for (var entity in dir.listSync()) {
        var path = entity.path;

        if (isDartFile(path)) {
          ///文件,分析文件
          analyzerAnnotation.readFile(File(path));
        } else {
          ///目录
          if (!path.contains('.')) {
            scanning(path);
          }
        }
      }
    }
  }
}
