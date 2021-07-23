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
    	width: 300px;  
    	height: 100px; 
    	float: left; 
    	border: 1px solid red; 
    	overflow: auto; 
    	text-align: center; 
    	line-height: 20px; 
    }
   ::-webkit-scrollbar {
		/*隐藏滚轮*/
		display: none;
	}
    .title{
    	width: 200px; 
    	
    }
    .time{
    	width: 500px;   
    }
    
    .head td{
    	height: 30px;  
    }
</style>
<script type="text/javascript">
	function homeDetail(id){
		
		window.location.href="homeDetail.jsp?typeid="+id;  
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
	String sql = "select a.title,a.context,a.author,a.time,b.id,b.type from news a,news_type b where a.type_id = b.id";
			sql+="";
					sql+="";
	ResultSet rs = stm.executeQuery(sql);
%> 
<div class="table-box">
	<table class="right">
	
		<tr class="head">
			<td class="title">标题</td>
			<td class="time">内容</td>
			<td>操作</td>
			
		</tr>
		<%while(rs.next()){ %>
		<tr class="text">
			<td class="title"><%=rs.getString("title") %></td>
			<td class="time"><%=rs.getString("context") %> </td> 
			<td><button onclick="homeDetail(<%=rs.getString("id") %>)">查看</button></td>
		</tr>
		<%} %>
	</table>
</div>

</body>
</html>