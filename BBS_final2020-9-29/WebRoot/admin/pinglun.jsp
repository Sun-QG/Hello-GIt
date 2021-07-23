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
    tr {
    	display: block;
    	
    	width: 1100px;
    	
    }
   tr td {
    	display: block; 
    	width: 200px;  
    	height: 30px;
    	float: left;  
    	border: 1px solid red; 
    	overflow: auto;
    	text-align: center;
    	line-height: 30px;
    }
   ::-webkit-scrollbar {
		/*隐藏滚轮*/
		display: none;
	} 
	
	.operation {
		width: 390px;
		float: left;  
	}
    
    input,form{
     margin:0px;
     display: inline;
	}

    
    
</style>
<script type="text/javascript">
	function delete1(rid){
		
		if(confirm("确认删除该评论？")==true){
			
			window.location.href="delete_reply.jsp?replyid="+rid;
			alert("fuck成功！");
			return true;
			 
		}else{
			
			return false; 
		}  
	}
	function diff(usrid){
		var num = document.getElementById("diff_num").value;
		
		
	}
</script>
</head>
<body>
	<%
	
    
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
	Statement stm = conn.createStatement();
	String sql = "select a.id usrid,a.uname,b.id replyid,b.reply_context,b.reply_time from usr a,reply b where a.id=b.usr_id";
	ResultSet rs = stm.executeQuery(sql);
%> 
<div class="table-box">
	<div class="left">
		<ul>
			<li><a href="caidan.jsp">菜单管理</a></li>
			<li><a href="tiezi.jsp">帖子管理</a></li>
			<li><a href="pinglun.jsp">评论管理</a></li>
			<li><a href="wendang.jsp">文档管理</a></li>
			<li><a href="xinxiweihu.jsp">个人信息维护</a></li>   
			
		</ul>
		
	</div>
	<table class="right">
	
		<tr class="head">
			<td>评论者</td>
			<td class="title">评论内容</td>
			<td class="time">评论时间</td>
			<td class="operation">操作</td>
			
		</tr>
		<%	while(rs.next()){ %>
		<tr class="text">
			<td><%=rs.getString("uname") %>  </td>   
			<td class="title"><%=rs.getString("reply_context") %></td> 
			<td class="time"><%=rs.getString("reply_time") %> </td> 
 			<td class="operation">   
			<a href="zhanshi_reply.jsp?context=<%=rs.getString("reply_context")%>"><button class="edit" >查看</button></a> 
			<form id="diff_form" method="get" action="diff.jsp" >
			<input  type="hidden" name="usrid" value="<%=rs.getString("usrid") %>" />
			<input  type="text" name="diff_num" value="0" id="diff_num"/>
			<input class="diff_btn" type="submit" id="diff_btn" value="扣分"  /> 
			</form>
			<button class="delete"  id="delete" onclick="delete1(<%=rs.getString("replyid")%>)">删除</button>
			</td>
		</tr>
		<%} %>
	</table>
</div>

</body>
</html>