<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	Date date0 = new Date();
	SimpleDateFormat formatter0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
    String time = formatter0.format(date0);
	String text = request.getParameter("text");
	String post_id = request.getParameter("post_id");
	String usr_id = (String)session.getAttribute("id");
	String father_usr_id = request.getParameter("father_usr_id");
	String father_topic_type = request.getParameter("father_topic_type");
	String self_topic_type = request.getParameter("self_topic_type");
	String father_topic_id = request.getParameter("father_topic_id");
	
	
	
	
	Date date = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
    String rtime = formatter.format(date);
    String id = (String)session.getAttribute("id");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Statement stm = conn.createStatement();
	/*String sql = "insert into reply(post_id,usr_id,reply_context,reply_time,father_usr_id,father_topic_type,self_topic_type,father_topic_id) values (?,?,?,?,?,?,?,?)";
    
	
	PreparedStatement pstm = conn.prepareStatement(sql);
    pstm.setString(1, post_id);
    pstm.setString(2, usr_id);
    pstm.setString(3, text);
    pstm.setString(4, rtime);
    pstm.setString(5, father_usr_id);
    pstm.setString(6, father_topic_type);
    pstm.setString(7, self_topic_type);
    pstm.setString(8, father_topic_id);
   pstm.setString(9, self_topic_id); 
    pstm.execute();
    
    response.sendRedirect("postDetail.jsp?id="+post_id);*/
	
	
    String sql2 = "select max(reply_time) time2 from reply where usr_id = " +id;  
    Statement stm2 = conn.createStatement();
    ResultSet rs2 = stm2.executeQuery(sql2);
    if(rs2.next()){
    	String sql3 = "select datediff(minute,'" + rs2.getString(1) + "','"+formatter.format(date)+  "')";
    	 Statement stm3 = conn.createStatement();
    	 ResultSet rs3 = stm3.executeQuery(sql3);
    	 int i=1;
    	 if(rs3.next()){
    		 int minute = rs3.getInt(1);
    		 
    		 if(minute>=2){//时间限制
    			 String sql = "insert into reply(post_id,usr_id,reply_context,reply_time,father_usr_id,father_topic_type,self_topic_type,father_topic_id) values (?,?,?,?,?,?,?,?)";
    			    PreparedStatement pstm = conn.prepareStatement(sql);
    			    pstm.setString(1, post_id);
    			    pstm.setString(2, usr_id);
    			    pstm.setString(3, text);
    			    pstm.setString(4, rtime);
    			    pstm.setString(5, father_usr_id);
    			    pstm.setString(6, father_topic_type);
    			    pstm.setString(7, self_topic_type);
    			    pstm.setString(8, father_topic_id);
    			    
    			    pstm.execute();
    			    
    			    
    			   if(i<5&&text.length()>15){
    			   String sql4="insert into jifen(usr_id,jifen,time) values(?,?,?)";
    			   PreparedStatement pstm2 = conn.prepareStatement(sql4);
	   			    pstm2.setString(1, usr_id);
	   			    pstm2.setString(2, "1");
	   			    pstm2.setString(3, rtime);
	   			    pstm2.execute();
    			    i++;
    			    }
    			    
    			String sql5 = "update post set replies=replies+? where id=? ";
   			    PreparedStatement pstm3 = conn.prepareStatement(sql5);
   			    pstm3.setInt(1,1);
   			    pstm3.setString(2, post_id); 
   			    pstm3.execute();
    			   
   			 response.sendRedirect("postDetail.jsp?id="+post_id);
    		 }else{
    			 response.sendRedirect("timeout2.jsp?pid="+post_id); 
    		 	}
    	 	}
    	 }else{
    		 String sql = "insert into reply(post_id,usr_id,reply_context,reply_time,father_usr_id,father_topic_type,self_topic_type,father_topic_id) values (?,?,?,?,?,?,?,?)";
			    PreparedStatement pstm = conn.prepareStatement(sql);
			    pstm.setString(1, post_id);
			    pstm.setString(2, usr_id);
			    pstm.setString(3, text);
			    pstm.setString(4, rtime);
			    pstm.setString(5, father_usr_id);
			    pstm.setString(6, father_topic_type);
			    pstm.setString(7, self_topic_type);
			    pstm.setString(8, father_topic_id);
			    pstm.execute();
			    
			    String sql4="insert into jifen(usr_id,jifen,time) values(?,?,?)";
 			   PreparedStatement pstm2 = conn.prepareStatement(sql4);
	   			    pstm2.setString(1, id);
	   			    pstm2.setString(2, "1");
	   			    pstm2.setString(3, rtime);
	   			    pstm2.execute();
			    
	   			 String sql5 = "update post set replies=replies+? where id=? ";
	   			    PreparedStatement pstm3 = conn.prepareStatement(sql5);
	   			    pstm3.setInt(1,1);
	   			    pstm3.setString(2, post_id); 
	   			    pstm3.execute();
	   			    
			    response.sendRedirect("postDetail.jsp?id="+post_id);
    	 } 
%>

</body>
</html>