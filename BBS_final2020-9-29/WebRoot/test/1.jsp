<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String url = "jdbc:sqlserver://localhost:1433;databasename = it";
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
Connection conn = DriverManager.getConnection(url,"sa","123456");
String usr_id="2";
String jifen="3";
String sql6="update usr set jifen=jifen+? where id=? ";
PreparedStatement pstm = conn.prepareStatement(sql6);
pstm.setString(1,jifen);
pstm.setString(2,usr_id);
pstm.execute();

%>
</body>
</html>