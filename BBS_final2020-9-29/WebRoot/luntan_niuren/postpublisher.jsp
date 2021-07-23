<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    body {
        margin: 0;
        
    }

    .outer-box {
        display: block;
        padding: 0;
        width: auto;
        height: 1500px;
        background-color: #F5F6F7;
	

    }
	
	.head-div {
		display: block;
		width : 100%;  
		height: 100px;
	}
	
	.back-button{
		position: relative; 
		left: 100px;
		top:50px;  	
	}
    .title-div{
    	display: block;
        width: 816px;
        height: 112px;
        margin: auto;
        border-bottom: 5px solid #F5F6F7;
        font-weight: 600;  

    }
 
    .text-box { 
        width: 816px;
        height: 800px;
        margin: auto;
        /*outline: 1px solid #1E9FFF;*/ 
        text-align: center;
    }
    
    .select-div {
 		display: block;
 		width: 608px;
 		height: 100px;
 		
 		margin: auto;
 		margin-bottom: 50px;  
    } 
     
    .select-font{
    	display: block;
    	position: relative; 
    	margin: auto;
    	top:35%;
    	float: left;
    } 
    
    .select-type {
    	display: block;
 		width: 180px;  
 		height: 32px;
 		margin-left: 100px;
 		top: 30%;
 		position: relative;
    }
    
    .submit-div {
    	display: block;
    	width: 100%;
    	height: 64px;
    	margin-bottom: 100px;  
    }
    
    .submit-button{
    	display: block;
    	position: relative; 
    	top: 20px;
    	left: 800px;
    	width: 112px;
    	height: 40px; 
    	font-weight: 400; 
    }
</style>
<script type="text/javascript">
	function back(){
		window.history.back();
		return false;
	}
	
	
	function check(){
		var title = document.getElementById("title").value;
		var context = document.getElementById("text").value;
		var select = document.getElementById("select-type").value;
		if(title==""){
		 	alert("标题不能为空！");
			return false;
		}else if(context==""){
			alert("内容不能为空!");
			return false;
		}else{
			var form = document.getElementById("publishPostForm"); 
			form.sumbit();
			alert("上传成功！");
			return true;
		} 
		
	}
</script>
<body>

<%
    String id = (String)session.getAttribute("id");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Statement stm = conn.createStatement();
    String sql = "select * from usr where id="+id;
    ResultSet rs = stm.executeQuery(sql);


%>
<% if (rs.next()){
        String name = null;
        name = rs.getString("uname"); 
        %>

<%
    }
%>

<div>
	<input type="hidden" value="<%=id%>">
	
	
    <form method="post" id="publishPostForm" onsubmit="return check()" action="../post/postPublisherProcess.jsp">  
        <div class="outer-box">
        	<div class="head-div">
        		<input type="button" class="back-button" onclick="back()" value="返回上一页" />
        	</div>
            <div class="title-div">
                <input id="title" name="title" style="position: relative; left:64px; width:688px; height: 55px; top:20px; text-align: center; font-size: 23px; color: #606266;" type="text" name="title" maxlength="50" alt="" placeholder="请输入标题(最长50字):"/>

            </div>
            <div class="text-box">
                <textarea id="text" name="text" style="position: relative; width:688px; top:20px; height: 7	50px; line-height: 26px; font-size: 18px;" name="text" rows="30"  maxlength="4000"  name="text" ></textarea>
            </div>
            
            <div class="select-div">
            
         		<div class="select-font" >
            	<font>文章主题：</font>
            	</div>
				<select class="select-type" name="select-type"  id="select-type"> 
					<option value="0">--请选择 --</option>  
					<option value="0">大数据</option>
					<option value="0">编程语言</option>
					<option value="0">Web前端</option>
					<option value="0">数据库技术</option>
					<option value="0">操作系统</option>
					<option value="0">云计算</option>
				</select>
            </div>
            <div class="submit-div">
            	<input class="submit-button" type="submit" name="submit-button" value="发布帖子" ">
            </div>
        </div>
    </form>
</div>

</body>
</html>
