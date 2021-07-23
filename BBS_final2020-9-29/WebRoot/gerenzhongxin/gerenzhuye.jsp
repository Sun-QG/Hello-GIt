<%@page import="java.sql.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'gerenzhuye.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	 body{
    border:0px solid;
    font:20px "微软雅黑";
    background-image:url(img/beijing.jpg);
    background-repeat:no-repeat;
    background-size:100%;
    
    }
   
    th{
    
    padding-left:300px;
    padding-top:20px;
    text-align:left;
    }
	</style>

  </head>
  
  <body>
    <div class="top" align="center">
    <img src="img/1.jpg" width="800" height="300" />
    </div>
    <div class="center" align="center">
   <%
       String z = (String)session.getAttribute("id");
       if(z==null || z==""){
           z="";
       }
   
    String id = request.getParameter("id");
   
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection conn = DriverManager.getConnection(url,"sa","123456");
    String sql = "select u.uname,u.jifen,u.text,count(1) c,sum(views) v,sum(likenum) lnum,sum(replies) rplnum from usr u join post p on u.id=p.publisher_id where u.id=? group by uname,jifen,text";
    PreparedStatement pstm = conn.prepareStatement(sql);
    pstm.setString(1,id);
    ResultSet rs = pstm.executeQuery();
    if(rs.next()){
  %>
    <a href="./index.jsp">返回首页 </a>
    <a href="./gerenzhongxin/reply.jsp?id=<%=id%>">回复</a>
    <a href="./gerenzhongxin/shoucang.jsp?id=<%=id%>">收藏</a>
    <a href="./gerenzhongxin/tiezi.jsp?id=<%=id%>">帖子</a>
    我的信息
    
    <table width="800">
    <tr> <th>姓名：<%=rs.getString("uname") %></th></tr>
     <tr><th>积分: <%=rs.getString("jifen") %></th></tr>
   <tr><th>个性签名: <%=rs.getString("text") %></th></tr>
   <tr><th > 发帖数：<%=rs.getString("c") %></th></tr>
   <tr><th>总浏览量: <%=rs.getString("v") %></th></tr>
   <tr><th>总点赞数: <%=rs.getString("lnum") %></th></tr>
   <tr><th>总回复数: <%=rs.getString("rplnum") %></th></tr>
   
    </table>
   <%} 
   if(z.equals(id)){
   %>
   <tr><th> <a href="./gerenzhongxin/edit.jsp?id=<%=id%>">修改信息</a></th></tr>
   <%} %>
    </div>
  </body>
</html>
