# RestDemo

[![Join the chat at https://gitter.im/WildDylan/RestDemo](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/WildDylan/RestDemo?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
RestDemo And OHHTTPStubs Demo And a Normal progress View
好久没有更新文章了, 抱歉拖更、今天带大家熟悉一些新的东西。

工程中使用了标题中的这些东西`RestKit（Rest请求, Mapping对象, 项目中包含了写入到CoreData以及普通对象获取）`, `OHHTTPStubs（在离线条件下模拟网络请求, 也可以在程序没网的时候用作离线数据的提供）`,`CDZPinger（Ping工具, 最近项目要使用socket.io 所以顺便拿来看一下, 岁simplePing的上层封装）`,`CocoaLumberjack（常用的Log工具DDLog）`, 另外还有用作进度框的`M13ProgressSuite（不错的进度条, 大家看界面就行）`.实现了RestKit请求到数据直接存储到CoreData与Get本地对象2个简单的功能


![屏幕快照 2015-06-15 下午8.07.24.png](http://upload-images.jianshu.io/upload_images/144590-656fed3ac0c4642d.png)

项目环境: x-code 6.3.2 Objective-c （x-code7. 还是有很多坑的, 大家慎重使用, 请期待稳定版本。OSX10.11 同样有很多的BUG）。

pod File: 

```json
pod 'RestKit'
pod 'OHHTTPStubs'
pod 'CocoaLumberjack'
pod 'M13ProgressSuite'
pod 'CDZPinger'
pod 'MagicalRecord'

```

![屏幕快照 2015-06-15 下午8.00.13.png](http://upload-images.jianshu.io/upload_images/144590-d394361559ea8d66.png)

文件很少 大致说一下功能：
Sources： json文件, sources文件存放, OHHTTPStubs模拟网络响应的资源
Basement： 公共的头文件, Map以及HttpServer的2个工具类
AppDelegate： 
Model： 模型（包括CoreData生成的模型以及自己创建的模型）
ViewController : 界面 简单的测试。

步骤1：基本的配置, 包括模拟网络响应的配置以及RestKit对对象的Mapping

在AppDelegate中调用Basement中Map, HTTPServer的方法, 并且打开Log


![屏幕快照 2015-06-15 下午8.08.46.png](http://upload-images.jianshu.io/upload_images/144590-dcb442426238bd51.png)

Map-Student CoreData描述:

![屏幕快照 2015-06-15 下午8.09.15.png](http://upload-images.jianshu.io/upload_images/144590-8bb64044e5c106f1.png)

Map-Car 对象


![屏幕快照 2015-06-15 下午8.09.24.png](http://upload-images.jianshu.io/upload_images/144590-1095617d74dcfb9f.png)

HTTPServer-创建请求截获并写出响应


![屏幕快照 2015-06-15 下午8.10.51.png](http://upload-images.jianshu.io/upload_images/144590-23ef357b23b30a33.png)

请求Car对象


![屏幕快照 2015-06-15 下午8.11.23.png](http://upload-images.jianshu.io/upload_images/144590-b664e163f14343e0.png)


我把项目的源码放到GitHub上边 这是一个很好的Demo来学习Rest以及断网处理的OHHTTPStubs， 希望大家会喜欢。并且, 我会在此基础上慢慢增加一些别的东西进来比如说Canvas Pop Shimmer ReactCocoa等新鲜的东西来丰富大家的知识。  喜欢请关注。

源码地址: [Git Hub Page](https://github.com/WildDylan/RestDemo)

CopyRight @WildDylan. 2015-6-15 

