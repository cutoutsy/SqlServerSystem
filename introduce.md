##简介

本SQL Server数据库安全性保障系统主要采用Structs2框架来进行开发.Struts2是一个基于MVC设计模式的Web应用框架，它本质上相当于一个servlet，
在MVC设计模式中，Struts2作为控制器(Controller)来建立模型与视图的数据交互.Struts 2以WebWork为核心，采用拦截器的机制来处理用户的请求，
这样的设计也使得业务逻辑控制器能够与ServletAPI完全脱离开，代码更加利于维护.


##核心代码

1.structs.xml

structs.xml是Struts2的核心文件,主要负责管理应用中的Action映射，以及该Action包含的Result定义等.配置项目中的一些全局的属性,用户请求和响
应Action之间的对应关系,以及配置Action中可能用到的参数,以及处理结果的返回页面.还包含各种拦截器的配置等.

2.Sql Server数据库连接

Sql Server数据库连接是整个系统的基础,备份,恢复都是建立在数据库连接的基础上的,因此编写一个公共的连接函数:

```Java
public boolean connSqlServer(Servers s){
    Connection conn = null;
    String url = "jdbc:jtds:sqlserver://"+s.getHostip()+":"+s.getHostport()+"/";
    String userid = s.getServername();
    String password = s.getServerpasswd();
    try{
        Class.forName("net.sourceforge.jtds.jdbc.Driver");
        conn = DriverManager.getConnection(url, userid, password);
        conn.close();
        return true;
    }catch (Exception e){
        e.printStackTrace();
        return false;
    }
}
```

采用JTDS连接,JDTS是一个开发源代码的纯Java写的,用于Microsoft SQL Server的驱动程序,这个函数连接成功返回true,失败返回false.

3. Session机制

整个系统代码里使用了session机制,session是web开发里的一个重要概念.主要用来存储关于用户会话的信息或者更改用户会话的设置.在系统代码里存储了
用户的session信息,以便登录的用户才可以进行访问.针对数据库连接,也将正在连接的数据库设置在seesion里,这样可以保证在备份,查询,还原时操作的是
同一个数据库.下面是一些系统代码里使用session的地方:

```java
session.setAttribute("dblist", dbList);
session.setAttribute("severconn", datadao.getSqlServerConnection(servers));
session.setAttribute("serverconncted", servers);
```

4.SQL Server存储过程

SQL Server存储过程是一组为了完成特定功能的SQL语句集合,经编译后存储在数据库中,用户通过指定存储过程的名称并给出参数来执行.存储过程中可以包
含逻辑控制有和数据操纵语句,它可以接受参数,输出参数,返回单个或多个结果集以及返回值.

在将数据库备份还原的时候,java的语句不能直接将备份还原到数据库中,需要使用SQL Server存储过程.下面是存储过程的代码:

```sql
create proc killrestore (@dbname varchar(20),@dbpath varchar(40))
as
begin
declare @sql   nvarchar(500)
declare @spid  int
set @sql='declare getspid cursor for select spid from sysprocesses where dbid=db_id('''+@dbname+''')'
exec (@sql)
open getspid
fetch next from getspid into @spid
while @@fetch_status <> -1
begin
exec('kill '+@spid)
fetch next from getspid into @spid
end
close getspid
deallocate getspid
restore database @dbname from disk= @dbpath with replace
end
```

使用SQL Server Management Studio连接数据库,并在系统数据库masterr上新建存储过程并执行,执行成功,然后在java代码里面调用,并传入参数,
调用的代码如下:

```java
String recoverySql = "ALTER DATABASE " +dbname+ " SET   ONLINE   WITH   ROLLBACK   IMMEDIATE";// 恢复所有连接
PreparedStatement ps = conn.prepareStatement(recoverySql);
CallableStatement cs = conn.prepareCall("{call killrestore(?,?)}");
cs.setString(1, dbname); // 数据库名
cs.setString(2, path); // 已备份数据库所在路径
cs.execute(); // 还原数据库
ps.execute(); // 恢复数据库连接
```

主要传入参数数据库名和备份数据库所在的路径,这样就可以进行数据库的备份还原了.
































