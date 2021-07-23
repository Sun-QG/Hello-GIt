
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<style>
 body{
    border:0px solid;
    font:16px "微软雅黑";
    background-image:url(img/beijing.jpg);
    background-repeat:no-repeat;
    background-size:100%;
    align:center;
    }
    form{
    padding-left:40%;
    text-align:left;
    
    }
</style>
<body>
	<div align="center">
	<%
	 String id = request.getParameter("id");
	   
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection conn = DriverManager.getConnection(url,"sa","123456");
    String sql = "select * from usr where id=?";
   	PreparedStatement pstm = conn.prepareStatement(sql);
    pstm.setString(1,id);
    ResultSet rs = pstm.executeQuery();
   
		%>
						<form class="for" action="edPro.jsp" method="get">
						<%  if(rs.next()){%>
							<input type="hidden" name="id" value="<%=id %>">
							  用户名：<%=rs.getString("uname") %><br>
							  密码：<input type="text" name="password" value="<%=rs.getString("pwd") %>"><br>
							 个性签名： <input type="text" name="qianming" value="<%=rs.getString("text") %>"><br>
							 <%} %>
							<input type="submit" value="提交">
							<input type="reset" value="重置">
						</form>
		
						
		</div>
</body>
</html>