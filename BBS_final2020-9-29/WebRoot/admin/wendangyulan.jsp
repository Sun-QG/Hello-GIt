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
	
	#submit {
		margin-top: 30px;
	}
</style>
</head>

<body>
	<%
	String aid = (String)session.getAttribute("id");
	String typeid = request.getParameter("typeid");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
	Statement stm = conn.createStatement();
	String sql = "select a.title,a.context,a.author,a.time,b.id,b.type from news a,news_type b where a.type_id = b.id and b.id = "+ typeid;
	ResultSet rs = stm.executeQuery(sql);
%>
	<%
		if(rs.next()){
			
		
	%>
	<form method="post" action="wendangEdit.jsp" >
	<input type="hidden" name="typeid" value="<%=typeid%>">
	标题：<input type="text" name="title" value="<%=rs.getString("title") %>" disabled="disabled" /><br> 
	内容：<input id="text" type="text" name="context" value="<%=rs.getString("context") %>" /><br>
	<%
	
	String sql2 = "select aname from admin where id = "+ aid;
	ResultSet rs2 = stm.executeQuery(sql2);
	if(rs2.next()){
%>
	修改者：<input type="text" name="a" value="<%=rs2.getString("aname") %>"  readonly="readonly" />
	<%} %>
	<input id="submit" type="submit" value="修改"/> 
	</form>
	<%} %>
</body>
</html>