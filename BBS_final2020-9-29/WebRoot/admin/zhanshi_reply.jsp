<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>评论</title>
</head>
<script type="text/javascript">
	function back(){
		
		window.location.href="pinglun.jsp";
	}
</script>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("UTF-8");
	String context = request.getParameter("context");
	
	%>
	<button onclick="back()">返回上一页</button>
	<h4><%=request.getParameter("context") %></h4>
</body>
</html>