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
    	height : auto;
    	border-bottom: 1px solid #f0f0f2; 
    	padding : 24px;
    }
    
    .h-tag {
    	display : block;
    	width : 806px;
    	height : 40px;
    	overflow: hidden;
    }
    
    .context {
    	display : block;
    	width : 962px;
    	height : auto;
    	color: #555666;
    	
    	font-weight: 400;
    }
    
    .operation {
    	display : block;
    	width : 906px;
    	height : 28px;
    	position: relative;
    	margin-top: 16px;
    }
    
    .like{
    	display : block;
    	width: 144px;
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
    
    .airicle-reply-box {
    	display: block; 
    	margin-top : 40px;
    	border-top: 3px solid #111111;
    	margin-bottom : 100px;
    	width: 962px; 
    	height: auto;
    }
    
    .reply-div {
    	display: flex;
    	border-bottom: 1px solid #999; 
    	width: 962px; 
    	height: auto;
    	font-weight: normal;
    	font-size: 14px; 
    	  
    }
    
    .reply-usr,.reply-context,.reply-time{	
    	display: block;
    	float: left;  
    	margin-right: 20px;
    	width: auto;  
    	
    	
    	 
    }
	.reply-time {  
		float: right;
	}
	
    .reply-context {
    	overflow: auto;
    	height: auto;
    }
    
    .reply-box {
    	height: 64px;
    	background-color: #fff;
    	box-shadow: 0 0 6px 0 #5094d5;
    	border: 1px solid #5094d5;
    	border-radius: 4px;
        display: block;
    	width: 962px;
    	box-sizing: border-box;
    	
    	
    	
    }
    
    .go	{
    	  position: relative;
    	  min-width :72px;
    	  height: 30px;
    	  line-height: 28px;
    	  left : 890px;
    	  
    	  border-radius: 15px;
    	  border: none;
    	  cursor: pointer;
    	  font-weight: 500;
    	    
    }
    .reply-text {
    	resize: none;
    	background: rgba(248,249,251,0.8);
    	color: #000;
    	font-family: "SF Pro Display",Roboto,Noto,Arial,"PingFang SC","Hiragino Sans GB","Microsoft YaHei",sans-serif;
    	font-size: 14px;
    	line-height: 22px;	
    	border: 1px solid #dadde0; 
        width: 99.5%; 
       	height: 56px; 
        z-index: 2;
        
        
    } 
    
    button {
		float : left;      
    }
</style>
<script type="text/javascript">
	function replyCheck() {
		
		var pid = document.getElementById("postIdValue").value; 
		var text = document.getElementById("reply-textarea").value; 
		if(text==""){
			alert("评论不能为空！");
		}else{
			window.location.href="replyProcess.jsp?pid="+pid+"&&text="+text;
		}
	}
	
	function shoucang(){
		var collection1 = document.getElementById("collection1").value;
		var post_id = document.getElementById("postIdValue").value;
		window.location.href="shoucang0.jsp?post_id="+post_id+"&&collection="+collection1;
	}
	
	function quxiaoshoucang(){
		var collection1 = document.getElementById("collection1").value;
		var post_id = document.getElementById("postIdValue").value;
		window.location.href="quxiaoshoucang0.jsp?post_id="+post_id+"&&collection="+collection1;
	}
	
	function dianzan(){
		var dianzanshu = document.getElementById("dianzanshu").value;
		var post_id = document.getElementById("postIdValue").value;
		window.location.href="dianzan0.jsp?post_id="+post_id+"&&dianzanshu="+dianzanshu;
	}
	
	function quxiaodianzan(){
		var dianzanshu = document.getElementById("dianzanshu").value;
		var post_id = document.getElementById("postIdValue").value;
		window.location.href="quxiaodianzan0.jsp?post_id="+post_id+"&&dianzanshu="+dianzanshu;
	}
	
	function fanhui(){
		var type_id = document.getElementById("type_id").value;
		window.location.href="tiezi.jsp";
	}
</script>
<body>
	<%
	
	int post_id = Integer.parseInt(request.getParameter("pid"));
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Statement stm = conn.createStatement();//搜索用户名，帖子id，帖子标题，帖子内容，发帖时间，浏览量
    Statement stm2 = conn.createStatement();//计算点赞数
    Statement stm3 = conn.createStatement();//计算回复数
	String sql = "select a.uname uname,b.id id,b.title title,b.context context,b.time time,b.views views,b.collection collection from usr a,post b where a.id = b.publisher_id and b.id = "+post_id;  
	ResultSet rs = stm.executeQuery(sql); 
	

	%> 
	<input type="hidden" name="type_id" id="type_id" value="<%=(String)session.getAttribute("type_id")%>"/>
	<%
		while(rs.next()){
			
	%>
	
	<input type="hidden" id="postIdValue" value="<%=request.getParameter("id")%>">
	<div class="top-title">
		
		<button onclick="fanhui()">返回</button>
	</div>
	<div class="community-item"> 
		<div class="h-tag">
			<div class="title">
				<font style="font-size: 36px; line-height: 40px; color: #222226; cursor: pointer; font-weight: 700;">
					<%=rs.getString("title") %>
				</font>
			</div>
		</div>
		<div class="context">
			<font style="cursor: pointer; font-size: 20px; ">  
				<%=rs.getString("context")%>
			</font>   
		</div>
		<div class="operation">
			<div class="like">
			<%String sql2 = "select count(usr_id) num from likenum where post_id = "+ rs.getString("id"); 
			ResultSet rs2 = stm2.executeQuery(sql2); 
			while(rs2.next()){ 
			%>
			点赞数：<%=rs2.getString("num") %><input type="hidden" id="dianzanshu" value="<%=rs2.getString("num") %>"><%} %>
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
			<div class="collection">
			<%=rs.getString("collection") %>收藏
			<input type="hidden" id="collection1" value="<%=rs.getString("collection") %>">
			
			<%} %>
			
			
			</div>
		</div>
		
		<%
			
			String sql2 = "select a.reply_context context,a.reply_time time,b.uname uname from reply a,usr b,post c where a.usr_id = b.id and a.post_id = c.id and c.id = "+post_id;
			ResultSet rs2 = stm.executeQuery(sql2); 
		%>
		
		
		<div class="airicle-reply-box">
		<%while(rs2.next()){ %>
			<div class="reply-div">
				<div class="reply-usr"><%=rs2.getString("uname") %><%=" "+":"+" " %></div>  
				<div class="reply-context"><%=rs2.getString("context") %></div> 
				<div class="reply-time"><%=rs2.getString("time") %></div> 
			</div>
		<%} %>
		</div>
		
	</div>	
	
</body>
</html>