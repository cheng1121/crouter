import 'dart:io';

import 'package:crouter/src/utils/util.dart';
import 'package:process_run/process_run.dart' as shell;

import '../crouter.dart';

///author: cheng
///date: 2020/9/26
///time: 4:40 PM
///desc: 生成AppRouter module
class GenerateModule {
  final module = <String, File>{};
  final modulePages = <String, StringBuffer>{};

  void generate() async {
    var path = localePath();
    var dir = Directory('$path/app_router');

    ///如果存在该module，则删除
    if (dir.existsSync()) {
      print('app_router已存在，删除它');
      dir.deleteSync(recursive: true);
    }

    ///执行flutter 命令创建package
    var result = await shell.run(
        'flutter', ['create', '--template=package', 'app_router'],
        verbose: true);
    print('执行结果 ====${result.exitCode}');
    if (result.exitCode != 0) {
      print('创建module失败');
    } else {
      ///生成文件
      final lib = Directory('${dir.path}/lib');
      final src = Directory('${lib.path}/src');

      ///生成module中的页面名字
      await generateModulePageFile(src.path);

      await generateLibFile(lib.path);
    }
  }

  Future<void> generateModulePageFile(String path) async {
    print('module page path =====$path');
    for (final bean in pages) {
      if (module.containsKey(bean.moduleName)) {
        final sb = modulePages[bean.moduleName];
        sb.write(moduleClassPage(bean.routeName));
      } else {
        final file = File('$path/${bean.moduleName}.dart');
        if (file.existsSync()) {
          file.deleteSync();
        } else {
          file.createSync(recursive: true);
        }
        module[bean.moduleName] = file;
        final page = StringBuffer();
        page.write(moduleClassPage(bean.routeName));
        modulePages[bean.moduleName] = page;
      }
    }

    ///写入数据
    for (var e in module.entries) {
      final file = e.value;
      await file
          .writeAsString(moduleClass(e.key, modulePages[e.key].toString()));

      ///格式化代码
      await shell.run('flutter', ['format', file.path]);
    }
  }

  ///生成导出文件的库
  Future<void> generateLibFile(String lib) async {
    final libFile = File('$lib/app_router.dart');
    if (libFile.existsSync()) {
      libFile.deleteSync();
    } else {
      libFile.createSync();
    }
    final sb = StringBuffer();
    sb.writeln('library app_router;');

    ///export 'src/www.dart';
    for (final e in module.entries) {
      sb.writeln('export \'src/${e.key}.dart\';');
    }
    await libFile.writeAsString(sb.toString());

    ///格式化代码
    await shell.run('flutter', ['format', libFile.path]);
  }
}
