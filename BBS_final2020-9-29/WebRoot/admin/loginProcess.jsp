<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 42494
  Date: 2020/9/18
  Time: 8:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
	String aname = request.getParameter("aname");
	String pwd = request.getParameter("pwd");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
    Statement stm = conn.createStatement();
    //检索用户表
    String sql = "select aname,pwd,id from admin";
    ResultSet rs = stm.executeQuery(sql);
    int flag = 0;
    while (rs.next()) {
        if (rs.getString("aname").equals(aname)&&rs.getString("pwd").equals(pwd))
        {
            flag = 1;
//            System.out.println();

            session.setAttribute("id",rs.getString("id"));
            
            break;
        }
    }
    if(flag==1)
    {

//        session.setAttribute("state",1);//1已登录
        response.sendRedirect("caidan.jsp");
    }else
    {
    	response.sendRedirect("error.jsp");
       /*  response.sendRedirect("error.jsp"); */
    }
%>
</body>
</html>
