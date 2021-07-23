<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt((String)session.getAttribute("id"));
	String text = request.getParameter("text");
	String title = request.getParameter("title");
	String type_id = request.getParameter("select-type");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Date date = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
    String rtime = formatter.format(date);
    String sql2 = "select max(time) time2 from post where publisher_id = " +id;
    Statement stm2 = conn.createStatement();
    ResultSet rs2 = stm2.executeQuery(sql2);
    if(rs2.next()){
    	String sql3 = "select datediff(minute,'" + rs2.getString(1) + "','"+formatter.format(date)+  "')";
    	 Statement stm3 = conn.createStatement();
    	 ResultSet rs3 = stm3.executeQuery(sql3);
    	 if(rs3.next()){
    		 int minute = rs3.getInt(1);
    		 if(minute>=30){
    			 	Statement stm = conn.createStatement();
    			    String sql = "insert into post(title,context,time,publisher_id,type_id,collection,replies,views,likenum) values (?,?,?,?,?,0,0,0,0)";
    			    PreparedStatement pstm = conn.prepareStatement(sql);
    			    pstm.setString(1, title);
    			    pstm.setString(2, text);
    			    pstm.setString(3, rtime);
    			    pstm.setInt(4, id);
    			    pstm.setString(5, type_id); 
    			    
    			    pstm.execute();
    			    response.sendRedirect("postPublisherSuccess.jsp");
    		 }else{
    			 response.sendRedirect("timeout.jsp");
    		 }
    	 }
    }else{
    	Statement stm = conn.createStatement(); 
	    String sql = "insert into post(title,context,time,publisher_id,type_id,collection,replies,views,likenum) values (?,?,?,?,?,0,0,0,0)";
	    PreparedStatement pstm = conn.prepareStatement(sql);   
	    pstm.setString(1, title);
	    pstm.setString(2, text);
	    pstm.setString(3, rtime);
	    pstm.setInt(4, id);
	    pstm.setString(5, type_id); 
	    
	    pstm.execute();
	    response.sendRedirect("postPublisherSuccess.jsp");
    }
    
	

%>

</body>
</html>