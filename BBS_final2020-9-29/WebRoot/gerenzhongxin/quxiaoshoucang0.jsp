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
    
    <title>My JSP 'guanzhu.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  </head>
  
  <body>
    <%
    
   
    
    String pid=request.getParameter("post_id");
    String yhid=(String)session.getAttribute("id");
   
    String url = "jdbc:sqlserver://localhost:1433;databasename=it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    String sql="delete from shoucang  where usr_id=? and post_id=?";
    String sql2 = "update post set collection =collection+ ? where id = ?";
    PreparedStatement pstm=conn.prepareStatement(sql);
    PreparedStatement pstm2=conn.prepareStatement(sql2);
    pstm.setString(1,yhid);
    pstm.setString(2,pid);
    pstm.execute();
    
    pstm2.setInt(1, -1);
    pstm2.setString(2, pid);
    pstm2.execute();
    
    pstm2.close();
    pstm.close();
    conn.close();
    response.sendRedirect("shoucang.jsp?id="+yhid);
     %>
   
  </body>
</html>
