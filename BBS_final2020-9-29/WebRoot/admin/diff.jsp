<%@page import="java.sql.PreparedStatement"%>
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
		window.location.href="../index.jsp";
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
		}else if(select=="0"){
			alert("请选择帖子类型！");
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
    int usrid = Integer.parseInt(request.getParameter("usrid"));
	int diffnum = Integer.parseInt(request.getParameter("diff_num"));
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Statement stm = conn.createStatement();
    
    String sql = "update usr set jifen = jifen - ? where id = ?";
   	PreparedStatement pstm = conn.prepareStatement(sql);
   	pstm.setInt(1, diffnum);
   	pstm.setInt(2, usrid);
   	pstm.execute();
	response.sendRedirect("pinglun.jsp");

%>



</body>
</html>
