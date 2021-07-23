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
    
    padding-left:0px;
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
    String sql = "select p.title,p.id pid,r.id rid,r.reply_time rtime,r.reply_context  from post p join reply r on p.id=r.post_id where r.usr_id=? order by reply_time ";
    PreparedStatement pstm = conn.prepareStatement(sql);
    pstm.setString(1,id);
    ResultSet rs = pstm.executeQuery();
   
  %>
    <a href="./index.jsp">返回首页 </a>
    			回复
    <a href="./gerenzhongxin/shoucang.jsp?id=<%=id%>">收藏</a>			
    <a href="./gerenzhongxin/tiezi.jsp?id=<%=id%>">帖子</a>
    <a href="./gerenzhongxin/gerenzhuye.jsp?id=<%=id%>">我的信息</a>
    <table width="800">
    <tr>
     	<th> 回复过的帖子</th>
     	<th> 回复内容</th>
     	<th> 回复时间</th>
     	<%if(z.equals(id)){ %>
     	<th>操作</th>
     	<%} %>
     </tr>
    <%  while(rs.next()){%>
    
   <tr>
   		<th><a href="./post/increaseViewProcess.jsp?id=<%=rs.getString("pid")%>"><%=rs.getString("title")%></a> </th>
   		<th><%=rs.getString("reply_context") %> </th>
   		<th><%=rs.getString("rtime") %> </th>
   		<%if(z.equals(id)){ %>
   		<th> <a href="./gerenzhongxin/del_reply.jsp?reply_id=<%=rs.getString("rid")%>&&post_id=<%=rs.getString("pid")%>">删除</a></th>
  		<%} %>
   </tr>
    
   <% 
    }
   %>
   </table>
    </div>
  </body>
</html>
