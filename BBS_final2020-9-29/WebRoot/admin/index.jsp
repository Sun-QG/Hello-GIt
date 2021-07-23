<%@ page import="javax.websocket.Session"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>后台管理</title>
<style type="text/css">
	body {
        margin: 0;
        
    }
    
    .table-box {
    	display : block;
    	border: 1px solid black;
    	width: 1600px;
    	height: 950px;
    }
    
    .left {
    	display : flex;
    	border: 1px solid black; 
    	width: 400px;
    	height: 900px;
    	float: left;
    }
    
    .right {
    	display : flex;
    	border: 1px solid black;   
    	width: 1100px;
    	height: 900px;
    	float: right;
    }
    
    ul {
    	float : left;
    	list-style: none;
    }
    
    a {
    	cursor: pointer;
    }
    
    ul li {
    	display : flex;
    	border: 1px solid black;   
    	width: 200px;
    	height: 100px;
    }
    
    ul li a{
    	margin: auto;
    
    }
</style>
<script type="text/javascript"></script>
</head>
<body>
	<%
	
    String id = (String)session.getAttribute("id");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
	Statement stm = conn.createStatement();
	String sql = "select * from admin where id = 1";
	ResultSet rs = stm.executeQuery(sql);
%> 
<div class="table-box">
	<div class="left">
		<ul>
			<li><a href="caidan.jsp">菜单管理</a></li>
			<li><a href="tiezi.jsp">帖子管理</a></li>
			<li><a href="pinglun.jsp">评论管理</a></li>
			<li><a href="wendang.jsp">文档管理</a></li>
			<li><a href="xinxiweihu.jsp">公告信息维护</a></li>
			
		</ul>
		
	</div>
	<div class="right">
		<%if(rs.next()){ %>
		 欢迎，管理员：<%=rs.getString("aname") %> 
		 <%} %>
	</div>
</div>

</body>
</html>