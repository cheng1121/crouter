
# crouter使用方法

### 使用方法
##### 添加引用到需要使用注解packages的dev_dependencies中
1. 使用本地库
```
   crouter:
     path: crouter
```

2. 使用github库
```
 crouter:
    git:
      url: https://github.com/chengbook/crouter.git
      ref: v0.1.0
```
3. 使用pub
```
crouter: ^0.1.0
```

##### 添加注解
```
@CRouter('example/test1')
class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

##### 激活crouter命令行工具
```
///github 使用方式  执行完pub get 后，github上的项目存放在 flutter sdk -> .pub-cache ->git -> crouter
pub global activate --source path <crouter path>

///上传到pub.dev后，使用此命令
pub global activate crouter

```



##### 执行命令
在项目根目录下执行命令
```
crouter
```
1. 在项目的lib/src生成路由列表
2. 在项目根目录下生成packages，名字为app_router，作用是存放所有页面的路由名称
3. 每个module中的所有页面存放在一个和module名称对应的类中,如果module包含'_',则类名如下：
    app_router -> AppRouter
    




# 发布package到pub的方法

- 命令行设置本地代理
需要开启vpn，全局模式
```
export http_proxy=http://127.0.0.1:1087
export https_proxy=http://127.0.0.1:1087
```
- 测试代理是否成功
```
curl google.com

///结果出现html表示成功
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

```
- 取消当前命令行窗口的flutter镜像,不影响其他窗口使用此镜像
```
unset FLUTTER_STORAGE_BASE_URL
unset PUB_HOSTED_URL

```
- 测试或者发布到https://pub.dartlang.org

1. 测试
```
pub publish --try-run --server=https://pub.dartlang.org
```

2. 发布
```
pub publish --server=https://pub.dartlang.org
```

