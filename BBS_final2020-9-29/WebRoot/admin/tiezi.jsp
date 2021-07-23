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
    	width: 100px;  
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
    .title{
    	width: 200px; 
    	
    }
    .time{
    	width: 200px;  
    }
</style>
<script type="text/javascript">
	function delete1(pid){
		
		if(confirm("确认删除该帖子？")==true){
			alert("删除成功！");
			window.location.href="delete_post.jsp?pid="+pid;
			return true;
			
		}else{
			
			return false; 
		}  
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
	String sql = "select a.id id,a.title title,a.context context,a.time time,b.uname publisher,a.views views,";
			sql+="a.collection collection,a.likenum likenum,c.type_name type from post a,usr b,type c ";
					sql+="where a.publisher_id = b.id and a.type_id = c.id";
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
			<td class="title">标题</td>
			<td class="time">发布时间</td>
			<td>发布作者</td>
			<td>收藏</td>
			<td>浏览量</td>
			<td>点赞数</td>
			<td>类型</td>
			<td>操作</td> 
		</tr>
		<%while(rs.next()){ %>
		<tr class="text">
			<td class="title"><%=rs.getString("title") %></td>
			<td class="time"><%=rs.getString("time") %> </td> 
			<td><%=rs.getString("publisher") %>  </td>   
			<td><%=rs.getString("collection") %> </td>
			<td><%=rs.getString("views") %> </td>
			<td><%=rs.getString("likenum") %> </td>
			<td><%=rs.getString("type") %> </td> 
			<td>
			<a href="tieziyulan.jsp?pid=<%=rs.getString("id")%> "><button class="edit">查看</button></a>
			<button class="delete" id="delete" onclick="delete1(<%=rs.getString("id")%>)">删除</button>
			</td>
		</tr>
		<%} %>
	</table>
</div>

</body>
</html>