<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<meta http-equiv="content-type" content="text/html;charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="../css/default.css" />
<style type="text/css">
* {
    background: none repeat scroll 0 0 transparent;
    border: 1 none;
    margin: 0;
    padding: 0;
    vertical-align: baseline;
	font-family:微软雅黑;
	overflow:hidden;
}
#navi{
	width:100%;
	position:relative;
	word-wrap:break-word;
	border-bottom:1px solid #065FB9;
	margin:0;
	padding:0;
	height:40px;
	line-height:40px;
	vertical-align:middle;
    background-image: -moz-linear-gradient(top,#EBEBEB, #BFBFBF);
    background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #EBEBEB),color-stop(1, 
#BFBFBF));
}
#naviDiv{
	font-size:14px;
	color:#333;
	padding-left:10px;
}
#tips{
	margin-top:10px;
	width:100%;
	height:40px;
}
#buttonGroup{
	padding-left:10px;
	float:left;
	height:35px;
}
.button{
	margin-top:20px;
	padding-left:10px;
	padding-right:10px;
	font-size:14px;
	width:70px;
	height:30px;
	line-height:30px;
	vertical-align:middle;
	text-align:center;
	cursor:pointer;
    border-color: #77D1F6;
    border-width: 1px;
    border-style: solid;
    border-radius: 6px 6px;
    -moz-box-shadow: 2px 2px 4px #282828;
    -webkit-box-shadow: 2px 2px 4px #282828;
    background-image: -moz-linear-gradient(top,#EBEBEB, #BFBFBF);
    background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #EBEBEB),color-stop(1, #BFBFBF));
}
#mainContainer{
	padding-left:10px;
	padding-right:10px;
	text-align:left;
	width:98%;
	font-size:16px;
}
</style>
<body>

<div id="navi">
	<div id='naviDiv'>
		<span><img src="../img/arror.gif" width="7" height="11" border="0" alt=""></span>&nbsp;数据库管理<span>&nbsp;</span>
		<span><img src="../img/arror.gif" width="7" height="11" border="0" alt=""></span>&nbsp;<a href="<%=path%>/database/database_connect.jsp">配置数据库连接</a><span>&nbsp;</span>
	</div>
</div>
<div id="tips">
</div>
<div id="mainContainer">

<strong>配置数据库信息</strong>
<br>
<br>

<form name="connectForm" action="" method="post">
<table width="400" >
  <tr>
    <td width="30%">主机地址：</td>
    <td><input type="text" name="hostip"/></td>
  </tr>
  <tr>
    <td width="30%">端口号：</td>
    <td><input type="text" name="hostport"/></td>
  </tr>
  <tr>
    <td>用户名：</td>
    <td><input type="text" name="servername"/></td>
  </tr>
  <tr>
    <td>密码：</td>
    <td><input type="password" name="serverpasswd"/></td>
  </tr>
  <tr>
      <td><input class="button" onclick="connect();" value="连接"></td>
      <td><input class="button" onclick="connectSave();" value="连接并保存"></td>
  </tr>
</table>
</form>


</div>
</body>
<script type="text/javascript">
	function connect(){
		document.connectForm.action="<%=path%>/database/Database_connect.action";
		document.connectForm.submit();
	}

	function connectSave(){
		document.connectForm.action="<%=path%>/database/Database_connectSave.action";
		document.connectForm.submit();
	}
</script>

</html>