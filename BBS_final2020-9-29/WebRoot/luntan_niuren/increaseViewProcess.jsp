<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

<title>Insert title here</title>
</head>
<body>
<%
	String uid = (String)session.getAttribute("id");
	
    int postId = Integer.parseInt(request.getParameter("id"));
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Statement stm = conn.createStatement();
    Statement stm2 = conn.createStatement();
    
	String sql = "select views,replies,type_id from post where id = "+postId; 
	
	ResultSet rs = stm.executeQuery(sql);
	if(rs.next()){
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String rtime = formatter.format(date);
		int views2 = Integer.parseInt(rs.getString("views"))+1;
		String sql2 = "update post set views = "+views2+" where id = "+postId;  
		stm2.execute(sql2);
		
		
		String sql3="insert into [view](post_id,usr_id,view_time) values(?,?,?)";
		PreparedStatement pstm3 = conn.prepareStatement(sql3);
		pstm3.setInt(1,postId);
		pstm3.setString(2,uid);
		pstm3.setString(3,rtime);
		pstm3.execute();
		
		
		
	}
		
	response.sendRedirect("../post/postDetail.jsp?id="+postId);
%> 
	
	
</body>
</html>