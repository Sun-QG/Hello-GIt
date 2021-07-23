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
  </head>
  
  <body>
    <%
    String pid=request.getParameter("post_id");
    String yhid=(String)session.getAttribute("id");
    int collection = Integer.parseInt(request.getParameter("collection"));
    collection+=1;
    String time=new java.util.Date().toLocaleString();
	
    String url = "jdbc:sqlserver://localhost:1433;databasename=it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    String sql="insert into shoucang(usr_id,post_id,time) values(?,?,?)";
    String sql2 = "update post set collection = ? where id = ?";
    PreparedStatement pstm=conn.prepareStatement(sql);
    PreparedStatement pstm2=conn.prepareStatement(sql2);
    pstm.setString(1,yhid);
    pstm.setString(2,pid);
    pstm.setString(3,time);
    pstm.execute();
    pstm2.setInt(1, collection);
    pstm2.setString(2, pid);
    
    pstm2.execute();
    pstm.close();
    conn.close();
    response.sendRedirect("postDetail.jsp?id="+pid);
     %>
   
  </body>
</html>
