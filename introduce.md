##简介

本SQL Server数据库安全性保障系统主要采用Structs2框架来进行开发.Struts2是一个基于MVC设计模式的Web应用框架，它本质上相当于一个servlet，
在MVC设计模式中，Struts2作为控制器(Controller)来建立模型与视图的数据交互.Struts 2以WebWork为核心，采用拦截器的机制来处理用户的请求，
这样的设计也使得业务逻辑控制器能够与ServletAPI完全脱离开，代码更加利于维护.


##核心代码

1.structs.xml

structs.xml是Struts2的核心文件,主要负责管理应用中的Action映射，以及该Action包含的Result定义等.配置项目中的一些全局的属性,用户请求和响
应Action之间的对应关系,以及配置Action中可能用到的参数,以及处理结果的返回页面.还包含各种拦截器的配置等.

