![image-20210113154916263](https://i.loli.net/2021/01/13/HxzQdcyPgYteXTv.png)

## 实验4代码说明文档

​																													——created by 屈德林 in 2021/1/13

这是编程务实实验lab4，我使用SpringBoot + Flutter技术实现了一个具有登录，注册，邮箱验证，增删改查页面，社区功能，个人中心功能的APP。下面是整个APP项目的页面展示：

<img src="https://i.loli.net/2021/01/13/WiOC7TUf56ughnt.jpg" alt="img" style="zoom: 25%;" /><img src="https://i.loli.net/2021/01/13/qrnQ3xvep2I85Ml.jpg" alt="img" style="zoom:25%;" />

<img src="https://i.loli.net/2021/01/13/1tYisuFrXJoLZcT.jpg" alt="img" style="zoom:25%;" /><img src="https://i.loli.net/2021/01/13/3G87tufojZbmXhY.jpg" alt="img" style="zoom:25%;" />

<img src="https://i.loli.net/2021/01/13/n1UyQAcMD2JCKrI.jpg" alt="img" style="zoom:25%;" /><img src="https://i.loli.net/2021/01/13/c9CTzXwmhGZ7xoE.jpg" alt="img" style="zoom:25%;" />



## 技术栈

**后端:**

- Java JDK
- MySQL
- SpringBoot
- JPA: 持久层
- hibernate: 面向代码编程，而不是面向数据库编程，不再受于数据库表上去思考问题，不再并数据模型的实现模式，以对象模型的表达方式去实现数据模型。先编写模型的数据结构与各模型间的关系，hibernate可以通过代码的实体模型去建表等。
- JavaMail邮件
- druid
- lombok
- SpringMysecrity

```
Java JDK, MySQL, SpringBoot, JPA: 持久层, hibernate: 面向代码编程，而不是面向数据库编程，不再受于数据库表上去思考问题，不再并数据模型的实现模式，以对象模型的表达方式去实现数据模型。先编写模型的数据结构与各模型间的关系，hibernate可以通过代码的实体模型去建表等。
JavaMail邮件, druid, lombok, SpringMysecrity
```

**前端:**

- Android SDK

- Flutter
- 前端语言: Dart
- Dart
- Dio
- OKToast
- FlutterToast
- image_picker

## 环境:

- 操作系统: Ubuntu / windwos

- 编译器: IDEA  / VsCode
- 解释器: JAVA JDK15
- Flutter平台,Flutter 1.22.4
- 解释器 Dart SDK  2.10.4
- 插件: lombok
- mySQL 8.02

## 项目结构

```
整个目录包含两个结构，分别为
后端：springblog
前端：Welcome-Login-Signup-Page-Flutter
```

- 后端

![1.png](https://i.loli.net/2021/01/13/CHeLZlf4mOY6VJT.png)

- config：配置文件
- controller：接口层
- entity：实体类
- repository：继承仓库
- service：图片上传，登录注册，验证码等复杂功能
- util：工具类

- 前端

![2.png](https://i.loli.net/2021/01/13/21CQfS3VlrgejFG.png)

- componts：组件
- screen：页面
- Home：主页面
- login：登录页面
- signup：注册页面
- welcome：欢迎页面
- utils：工具类

