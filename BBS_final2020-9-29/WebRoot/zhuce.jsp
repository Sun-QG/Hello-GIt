<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: 42494
  Date: 2020/9/18
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = BBS";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
	
	String account = request.getParameter("account");
	
	Statement stm =conn.createStatement();
	String sql1="select * from yh ";
	ResultSet rs1=stm.executeQuery(sql1);
	
	
	int flag = 0 ;
	while(rs1.next()){

		if ( account.equals( rs1.getString("account") ) ){
			flag = 1 ;
		}
	}
	
	if(flag == 0 )
    {
    String sql2 = "insert into yh values(?,?,?,?,?,?,?)";
    PreparedStatement psm = conn.prepareStatement(sql2);
    
	String name = request.getParameter("name");
    String pwd = request.getParameter("pwd");
    psm.setString(1,name);
    psm.setString(2,null);
    psm.setString(3,"0");
    psm.setString(4,"0");
    psm.setString(5,pwd);
    psm.setString(6,account);
    psm.setString(7,"0");
    psm.executeUpdate();
     psm.close();
    conn.close(); 
	response.sendRedirect("dengluqian.jsp");
	}
	else{
		
		response.sendRedirect("dengluqian.jsp");
	}
    
%>
</body>
</html>
