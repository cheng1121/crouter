
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
      ref: v0.0.6
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
由于上传pub.dev时，google账号登陆授权无法通过，目前只能使用此命令

```
pub global activate --source path <crouter path>

///上传到pub.dev后，使用此命令
pub global activate crouter

```

执行完pub get 后，github上的项目存放在 flutter sdk -> .pub-cache ->git -> crouter

##### 执行命令
在项目根目录下执行命令
```
crouter
```
1. 在项目的lib/src生成路由列表
2. 在项目根目录下生成packages，名字为app_router，作用是存放所有页面的路由名称
3. 每个module中的所有页面存放在一个和module名称对应的类中,如果module包含'_',则类名如下：
    app_router -> AppRouter