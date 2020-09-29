import 'dart:io';

import 'package:crouter/src/utils/util.dart';
import 'package:process_run/process_run.dart' as shell;
import '../crouter.dart';

class GenerateFile {
  void generate(String path) async {
    ///在指定文件夹内生成文件
    final srcDir = Directory('$path/src');
    if (!srcDir.existsSync()) {
      srcDir.createSync();
    }

    ///创建存放路由表的文件
    final routeFile = File('${srcDir.path}/crouter_list.dart');
    if (routeFile.existsSync()) {
      routeFile.deleteSync();
    } else {
      routeFile.createSync();
    }
    var buffer = StringBuffer();

    ///首先添加import
    for (var i = 0; i < pages.length; i++) {
      final current = pages[i];
      if(i > 0){
        final previous = pages[i -1];

        if(previous.import != current.import){
          buffer.write(current.import);
        }
      }else{
        buffer.write(current.import);
      }

    }

    ///添加路由页面
    var pageSB = StringBuffer();
    for (var bean in pages) {
      pageSB.write(pageStr(bean.routeName, bean.className));
    }

    buffer.write(routeClass(pageSB.toString()));
    await routeFile.writeAsString(buffer.toString());

    ///使用flutter 命令对代码进行 格式化
    await shell.run('flutter', ['format', routeFile.path]);
  }
}
