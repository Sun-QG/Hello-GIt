<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.lang.*" %>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	input {
		font-size: 16px;
		line-height: 20px;
		display: block;
		width: 1000px;
		height: 60px;
	}
	
	#text {
		height: 60px;
	}
</style>
</head>

<body>
	<%
	String author = request.getParameter("a");
	String context = request.getParameter("context");
	String typeid = request.getParameter("typeid");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Date date = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
    String rtime = formatter.format(date);
	String sql = "update news set context = ?,author = ?,time=? where type_id = "+ typeid;
	
	PreparedStatement pstm = conn.prepareStatement(sql);
	pstm.setString(1, context);
	pstm.setString(2, author);
	pstm.setString(3, rtime);
	pstm.execute();
	response.sendRedirect("wendang.jsp");
%>
	
</body>
</html>