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
    	margin: auto;
    }
    
    .h-tag {
    	display : block;
    	width : 806px;
    	height : 40px;
    	overflow: hidden;
    	margin: 20px 0 20px 0; 
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
    	width : 806px;
    	height : 28px;
    	position: relative;
    	margin-top: 16px;
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
    .reply-text2 {
    	resize: none;
    	background: rgba(248,249,251,0.8);
    	color: #000;
    	font-family: "SF Pro Display",Roboto,Noto,Arial,"PingFang SC","Hiragino Sans GB","Microsoft YaHei",sans-serif;
    	font-size: 14px;
    	line-height: 22px;	
    	border: 1px solid #dadde0; 
        width: 810px; 
       	height: 60px; 
        z-index: 2;
        
    } 
    .reply-div2 {
    	display: flex;
    	border-bottom: 1px solid #999; 
    	width: 962px; 
    	height: 70px;
    	font-weight: normal;
    	font-size: 14px; 
    	  
    }
</style>
<script type="text/javascript">
	function hidediv(father_topic_id){
		/* var test= father_usr_id+"_"+father_topic_id;*/
		/* alert(test); */ 
		var obj = document.getElementById("testhuifu_"+father_topic_id);
		if(obj.style.display == "none"){
			obj.style.display = "";
			 
			}else{
			obj.style.display = "none";
			}
	}
	
	/* father_topic_type:,用数字表示 GLS 2021.7.4
	1表示post 
	2表示comment 
	3表示reply */
	function replyCheck() {
		
		/* Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	    var time = formatter.format(date);  */
	    
		var post_id = document.getElementById("postIdValue").value; 
		var text = document.getElementById("reply-textarea").value
		var father_usr_id = document.getElementById("publisherIdValue1").value; 
		var father_topic_type = "1";
		var self_topic_type = "2";
		var father_topic_id = post_id;
		/* var father_topic_id = "post"+time;
		var self_topic_id = "comment"+time;  */
		/* var test = "test"; */
		
		if(text==""){
			alert("评论不能为空！");
		}
		else
		{
			 window.location.href="replyProcess.jsp?post_id="+post_id+"&&text="+text+"&&father_usr_id="+father_usr_id+"&&father_topic_type="+father_topic_type+"&&self_topic_type="+self_topic_type+"&&father_topic_id="+father_topic_id;
		}  
		 /* +"&&father_topic_type="+father_topic_type+"&&self_topic_type="+self_topic_type  */
		/* var self_topic_type = "comment";
		alert(self_topic_type); */
	}
	
	/* father_topic_type:,用数字表示 GLS 2021.7.4
		1表示post 
		2表示comment 
		3表示reply */
function replyCheck2(father_usr_id,father_topic_id,father_topic_type) {//待修改 GLS 2021.7.2
		
		
		var post_id = document.getElementById("postIdValue").value; 
		var textareaId="textareaId_"+father_topic_id;
		var text = document.getElementById(textareaId).value;//不确定要不要加引号 GLS 2021.7.4
		var father_usr_id = father_usr_id;
		var father_topic_id = father_topic_id;
		var father_topic_type = father_topic_type;
		var self_topic_type = "3"; 
		
		
		
		if(text==""){
			alert("评论不能为空！");
		}
		else
		{
			 window.location.href="replyProcess.jsp?post_id="+post_id+"&&text="+text+"&&father_usr_id="+father_usr_id+"&&father_topic_type="+father_topic_type+"&&self_topic_type="+self_topic_type+"&&father_topic_id="+father_topic_id;
		} 
		/* alert(father_topic_type); */
		 /* +"&&father_topic_type="+father_topic_type+"&&self_topic_type="+self_topic_type  */
		/* var self_topic_type = "comment";
		alert(self_topic_type); */
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
	
	function fanhui(){
		window.location.href="post.jsp";
	}
</script>
<body>
	<%
	int post_id = Integer.parseInt(request.getParameter("id"));
    int id = Integer.parseInt((String)session.getAttribute("id"));
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Statement stm = conn.createStatement();//搜索用户名，帖子id，帖子标题，帖子内容，发帖时间，浏览量
    Statement stm2 = conn.createStatement();//计算点赞数
    Statement stm3 = conn.createStatement();//计算回复数
	String sql = "select a.uname uname,b.id id,b.title title,b.context context,b.time time,b.views views,b.collection collection,b.publisher_id publisher_id from usr a,post b where a.id = b.publisher_id and b.id = "+post_id;  
	ResultSet rs = stm.executeQuery(sql); 
	

	%> 

	<%
		while(rs.next()){
			
	%>
	<input type="hidden" id="postIdValue" value="<%=request.getParameter("id")%>">
	
	<!-- 利用隐藏text来存一些属性值 GLS 2021.7.1 -->
	<input type="text" id="publisherIdValue1" style="display:none;" value="<%=rs.getString("publisher_id") %>" >
	
	<div class="top-title">
		<%-- <font><%=id %></font> --%>
		<!-- <button onclick="fanhui()">返回</button> -->
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
			<div class="collection">
			<%=rs.getString("collection") %>收藏
			<input type="hidden" id="collection1" value="<%=rs.getString("collection") %>">
			
			<%} %>
			
			<%
			String shoucang=null;
			String sql4 ="select * from shoucang where post_id = ? and usr_id = ? ";
			PreparedStatement pstm = conn.prepareStatement(sql4);
			pstm.setInt(1, post_id);
			pstm.setInt(2, id);
			ResultSet rs4 = pstm.executeQuery();
			if(rs4.next()){
				
			
				 %>
				<button onclick="quxiaoshoucang()">取消收藏</button>
			<%}else{ %>
				<button onclick="shoucang()">收藏</button>
				<%} %>
			</div>
		</div>
		
		
		
		<!-- 对post的回复 -->
		<%
			
		String sql2 = "select a.reply_context context,a.reply_time time,b.uname uname,a.usr_id self_usr_id,a.id self_topic_id,self_topic_type,father_usr_id  from reply a,usr b,post c where a.usr_id = b.id and a.post_id = c.id and c.id = "+post_id;
		sql2 +=	" and a.self_topic_type =2 order by reply_time desc";
		ResultSet rs2 = stm.executeQuery(sql2); 
		%>
		
		
		<div class="reply-box">
			
			<textarea id="reply-textarea" class="reply-text" maxlength="500"></textarea>
			<button class="go" onclick="replyCheck()">发表评论</button>
			<!-- <button onclick="replyCheck()">发表评论</button>发评论  --> 
		</div>
		
		
		
		
		<div class="airicle-reply-box">
		<%while(rs2.next()){ %>
			
			<%
			String sql7 = "select * from usr where id = " +rs2.getString("father_usr_id");
			Statement stm7 = conn.createStatement();
			ResultSet rs7 = stm7.executeQuery(sql7); 
			%>
			
			
			<table>
			<tr>
			<div class="reply-div">
				
				<th><div class="reply-usr"><%=rs2.getString("uname") %><%=" "+":"+" " %></div>  </th>
				<th><div class="reply-context"><%=rs2.getString("context") %></div></th>
				<th><div class="reply-time"><%=rs2.getString("time") %></div></th>
				<th><button  onclick='hidediv(<%=rs2.getString("self_topic_id") %>)'>回复</button></th>
			</div>
			</tr>
			
			<!-- 对comment和reply的回复 -->
			<%
			String sql6 = "select a.reply_context context,a.reply_time time,b.uname uname,a.usr_id self_usr_id,a.id self_topic_id,self_topic_type from reply a,usr b,post c where a.usr_id = b.id and a.post_id = c.id and c.id = "+post_id;
			sql6 +=	" and a.self_topic_type =3 and father_topic_id="+rs2.getString("self_topic_id")+" order by reply_time desc"; 
			Statement stm6 = conn.createStatement();
			ResultSet rs6 = stm6.executeQuery(sql6); 
			%> 
			<%while(rs6.next()){ %>
				<div class="reply-div" style="color:#F00">
				<tr>
				<th><div class="reply-usr"><%=rs6.getString("uname") %><%=" "+":"+" " %></div> </th> 
				<th><div class="reply-context"><%=rs6.getString("context") %></div></th>
				<th><div class="reply-time"><%=rs6.getString("time") %></div></th>
				<th><button  onclick='hidediv(<%=rs2.getString("self_topic_id")%>)'>回复</button></th>
				</tr>
			
				<%String testhuifu ="testhuifu_"+rs2.getString("self_topic_id"); %>
			    <%String textareaId ="textareaId_"+rs2.getString("self_topic_id"); %>
				
				<div id="<%=testhuifu%>" class="reply-div2" style="display:none;">
					<button class="go" onclick='replyCheck2(<%=rs6.getString("self_usr_id")%>,<%=rs2.getString("self_topic_id")%>,<%=rs6.getString("self_topic_type")%>)'>发表回复</button>
					<textarea id="<%=textareaId%>" class="reply-text2" maxlength="500"><%=textareaId%></textarea>
				</div>
			</div>
			<%} %>
			<%rs6.close();%> 
			 
			    <%String testhuifu ="testhuifu_"+rs2.getString("self_topic_id") ; %>
			    <%String textareaId ="textareaId_"+rs2.getString("self_topic_id") ; %>
				
				<div id="<%=testhuifu%>" class="reply-div2" style="display:none;">
					<button class="go" onclick='replyCheck2(<%=rs2.getString("self_usr_id")%>,<%=rs2.getString("self_topic_id")%>,<%=rs2.getString("self_topic_type")%>)'>发表回复</button>
					<textarea id="<%=textareaId%>" class="reply-text2" maxlength="500"><%=textareaId%></textarea>
				</div> 
			
		<%} %>	
		</table>
		</div>
		 
	</div>	
	
</body>
</html>