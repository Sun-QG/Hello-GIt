<%@page import="java.sql.PreparedStatement"%>
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
<title>帖子展示</title>
</head>
<style>
	body {
        margin: 0;
        
    }
    
    .community-item {
    	display : block;
    	width : 1034px;
    	height : 125px;
    	border-bottom: 2px solid #f0f0f2;
    	 
    	padding : 24px;
    }
    
    .h-tag {
    	display : block;
    	width : 806px;
    	height : 24px;
    	overflow: hidden;
    }
    
    .context {
    	display : block;
    	width : 806px;
    	height : 41px;
    	color: #555666;
    	overflow: hidden;
    	font-weight: 400;
    }
    
    .operation {
    	display : block;
    	width : 806px;
    	height : 28px;
    }
    
    .like{
    	display : block;
    	width: 84px;
    	height: 28px;
    	float: left;
    }
    
    .post-publisher{
    	display : block;  
    	width: 140px;
    	height: 20px;
    	float: left;
    	text-align: center;
    }
    
    .post-time {
    	display : block;
    	width: 200px;
    	height: 20px;
    	float: left;
    }
    
    .replies {
    	display : block;
    	width: 60px;
    	height: 28px;
    	float: left;
    }
    
    .views {
 		display : block;
    	width: 80px;
    	height: 28px;
    	float: left;
    	
    }
    
    font{
    	color: #999aaa; 
    }
    
    a {
    	text-decoration: none;
    }
    
</style>
<script type="text/javascript">
	function increaseViews(x){
		
		window.location.href = "increaseViewProcess.jsp?id="+x;
	}
	
	function fanhui(){
		window.location.href="../index.jsp";
	}
</script>
<body>

 <button onclick="fanhui()">返回</button>
	<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String text = request.getParameter("wenben");
    String id = (String)session.getAttribute("id");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
   
    Statement stm2 = conn.createStatement();
    Statement stm3 = conn.createStatement();
	String sql = "select a.uname uname,b.id id,b.title title,b.context context,b.time time,b.views views,";
	sql+=" b.collection collection from usr a,post b where a.id = b.publisher_id and title like ?   ";   
	PreparedStatement pstm = conn.prepareStatement(sql);
	pstm.setString(1, "%"+text+"%");
	ResultSet rs = pstm.executeQuery();
	
	
%> 
	<%
		while(rs.next()){
			
	%>
	
	<div class="community-item">
		<div class="h-tag">
			<div class="title">
				<a onclick="increaseViews(<%=rs.getString("id") %>)"> 
					<font style="font-size: 18px; line-height: 25px; color: #222226; cursor: pointer; font-weight: 700;">
						<%=rs.getString("title") %>
					</font>
				</a>
			</div>
		</div>
		<div class="context">	
				<font style="cursor: pointer;">
					<%=rs.getString("context") %>
				</font>
		</div>
		<div class="operation">
			<div class="like">
			<%String sql2 = "select count(usr_id) num from likenum where post_id = "+ rs.getString("id"); 
			ResultSet rs2 = stm2.executeQuery(sql2); 
			while(rs2.next()){ 
			%>
			点赞数：<%=rs2.getString("num") %><%} %>
			</div>
			<div class="post-publisher">
			<%=rs.getString("uname") %> 
			</div>
			<div class="post-time">
			<%=rs.getString("time") %>
			</div>
			<div class="replies">
			<%String sql3 = "select count(usr_id) replynum from reply where post_id = "+ rs.getString("id"); 
			ResultSet rs3 = stm3.executeQuery(sql3); 
			while(rs3.next()){ 
			%>
			<%=rs3.getString("replynum") %><%} %>回复
			</div>
			<div class="views">
			<%=rs.getString("views") %>浏览
			</div>
		</div>
	</div>
	<%
		
		}
	%>
</body>
</html>