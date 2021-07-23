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
			String pid = request.getParameter("pid");
		%>
		<h1><%=pid %></h1>
		<h1>距上次评论不超过2分钟，暂时不能发布评论！<a href="postDetail.jsp?id=<%=pid%>">返回</a></h1>
	
</body>
</html>