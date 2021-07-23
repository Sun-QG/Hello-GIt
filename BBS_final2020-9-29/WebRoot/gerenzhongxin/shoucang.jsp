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
    
    <title>My JSP 'gerenzhuye.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	 body{
    border:0px solid;
    font:16px "宋体";
    background-image:url(img/beijing.jpg);
    background-repeat:no-repeat;
    background-size:100%;
    
    }
     th{
    
    padding-left:100px;
    padding-top:20px;
    text-align:left;
    }
	</style>

  </head>
  
  <body>
    <div class="top" align="center">
    <img src="img/1.jpg" width="800" height="300" />
    </div>
    <div class="center" align="center">
   <%
       String z = (String)session.getAttribute("id");
       if(z==null || z==""){
           z="";
       }
    
    String id = request.getParameter("id");
   
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection conn = DriverManager.getConnection(url,"sa","123456");
    String sql = "select u.uname,s.id,s.post_id pid,p.title,s.time stime from usr u,shoucang s,post p where u.id=s.usr_id and p.id=s.post_id and u.id=?";
    PreparedStatement pstm = conn.prepareStatement(sql);
    pstm.setString(1,id);
    ResultSet rs = pstm.executeQuery();
   
  %>
    <a href="./index.jsp">返回首页 </a>
    <a href="./gerenzhongxin/reply.jsp?id=<%=id%>">回复</a>
    			收藏
    <a href="./gerenzhongxin/tiezi.jsp?id=<%=id%>">帖子</a>
    	<a href="./gerenzhongxin/gerenzhuye.jsp?id=<%=id%>">我的信息</a>
    <table width="800">
    <tr>
     	<th> 标题</th>
     	<th> 收藏时间</th>
     	<%if(z.equals(id)){ %>
     	<th>操作</th>
     	<%} %>
     </tr>
    <%  while(rs.next()){%>
    
   <tr>
   		<th><a href="./post/increaseViewProcess.jsp?id=<%=rs.getString("pid")%>"><%=rs.getString("title")%></a> </th>
   		<th><%=rs.getString("stime") %> </th>
   		<%if(z.equals(id)){ %>
   		<th> <a href="./gerenzhongxin/quxiaoshoucang0.jsp?post_id=<%=rs.getString("pid")%>">取消收藏</a></th>
   		<%} %>
   </tr>
    
   <% 
    }
   %>
   </table>
    </div>
  </body>
</html>
