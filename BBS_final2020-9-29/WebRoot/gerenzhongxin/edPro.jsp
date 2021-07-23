<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	 String id = request.getParameter("id");
	 String pwd=request.getParameter("password");
	 String qianming=request.getParameter("qianming");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection conn = DriverManager.getConnection(url,"sa","123456");
    String sql = "update usr set  pwd=?,text=? where id=?";
   	PreparedStatement pstm = conn.prepareStatement(sql);
    pstm.setString(1,pwd);
    pstm.setString(2,qianming);
    pstm.setString(3,id);
    pstm.execute();
    
    response.sendRedirect("gerenzhuye.jsp?id="+id);
    %>
</body>
</html>