<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
body{
    border:0px solid;
    font:25px ;
    background-image:url(../img/beijing.jpg);
    background-repeat:no-repeat;
    background-size:100%;
    
    }
.left{
width:30%;
float:left;
}
.zhong{
width:39%;
float:left;

}
.right{
width:30%;
float:left;

}

.luntan_niuren{
	align:center;
	height:250px;
}
.benzhou_niuren{
	height:250px;

}
.luntan_niutie{
	height:250px;
}
.benzhou_niutie{
	height:250px;
}
.meiri_yitie{
	align:center;
}

</style>
<script>
function fanhui_shouye(id){
	if(id==null){
		window.location.href="../dengluqian.jsp";
	}else{
		window.location.href="../index.jsp";
	}
	
}
function increaseViews(x){
	
	window.location.href = "increaseViewProcess.jsp?id="+x;
}


</script>
<%
    String id = (String)session.getAttribute("id");
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:sqlserver://localhost:1433;databasename = it";
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection conn = DriverManager.getConnection(url,"sa","123456");
	%>
<body>
<div calss="top">  <a href="#" onclick="fanhui_shouye(<%=id%>)">返回首页</a> </div>
<div class="center">
<div class="left">
<div class="luntan_niuren">
<span style="font-size: 15px;color: #8c222c;">论坛牛人</span>
<%
Statement stm0 = conn.createStatement();
String sql0 = "select top 10 uname,id from  usr order by jifen";  
ResultSet rs0 = stm0.executeQuery(sql0); 
int i=1;
while(rs0.next()){
%>
<ui>

<li><a href="../gerenzhongxin/gerenzhuye.jsp?id=<%=rs0.getString("id")%>"><%=i+"."+rs0.getString("uname")%></a></li>

<%i++;} %>
</ui>
</div>
<div class="benzhou_niuren">
<span style="font-size: 15px;color: #8c222c;">本周牛人</span>
<ui>
<%
Statement stm2 = conn.createStatement();
Date today = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(today);
int weekday = cal.get(Calendar.DAY_OF_WEEK);
if(weekday==2){
	today=today;
}else{
	cal.add(Calendar.DATE, -weekday+2);
	today=cal.getTime();
}
cal.setTime(today);  
Date d1=cal.getTime();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
String rtime1 = formatter.format(d1);
cal.add(Calendar.DATE, 7);
Date d2=cal.getTime();
String rtime2 = formatter.format(d2);
String sql2 = "select  usr_id,sum(jifen) s from jifen where time >='"+rtime1+"' and time < '"+rtime2+"'  group by usr_id order by s desc";  
ResultSet rs2 = stm2.executeQuery(sql2);

int i2=0;
String a[]=new String[10];
System.out.println();
while(rs2.next()){
	if(i2<10){
	a[i2]=rs2.getString("usr_id");
	i2++;
	}
}

	for(i2=0;i2<10;i2++){
	Statement stm3 = conn.createStatement();
	String sql3="select uname from usr where id="+a[i2];
	ResultSet rs3 = stm3.executeQuery(sql3);
	while(rs3.next()){
%>

<li><a href="../gerenzhongxin/gerenzhuye.jsp?id=<%=a[i2]%>"><%=i2+1+"."+rs3.getString("uname")%></a></li>

<%} }%>
</ui>
</div>
</div>
<div class="zhong">
<div class="luntan_niutie">
<span style="font-size: 15px;color: #8c222c;">论坛牛贴</span>
<%
Statement stm1 = conn.createStatement();
String sql1 = "select top 10 title,id from  post order by views";  
ResultSet rs1 = stm1.executeQuery(sql1); 
int i1=1;
while(rs1.next()){
	
%>
<ui>

<li><a href="../post/increaseViewProcess.jsp?id=<%=rs1.getString("id")%>"><%=i1+"."+rs1.getString("title")%></a></li>

<%i1++;} %>
</ui>
</div>
<div class="benzhou_niutie">
<span style="font-size: 15px;color: #8c222c;">本周牛贴</span>
<%
Statement stm4 = conn.createStatement();
String sql4 = "select top 10 post_id  from [view] where view_time >='"+rtime1+"' and view_time < '"+rtime2+"'  group by post_id order by count(1) desc";  
ResultSet rs4 = stm4.executeQuery(sql4);
i2=0;
String b[]=new String[10];
System.out.println();
while(rs4.next()){
	b[i2]=rs4.getString("post_id");
	i2++;
}

	for(i2=0;i2<10;i2++){
	Statement stm5 = conn.createStatement();
	String sql5="select title,id from post where id="+b[i2];
	ResultSet rs5 = stm5.executeQuery(sql5);
	while(rs5.next()){
%>

<li><a href="../post/increaseViewProcess.jsp?id=<%=rs5.getString("id")%>"><%=i2+1+"."+rs5.getString("title")%></a></li>

<%} }%>
</ui>

</div>
</div>
<div class="right">
<div class="meiri_yitie">
<span style="font-size: 15px;color: #8c222c;">每日一贴 </span>
<span>
	<a href="postpublisher.jsp" style="font-size: 15px;color: #8c222c;margin-left: 10px;text-decoration: none" onclick="">我要发帖</a>
</span>
<%
Statement stm7 = conn.createStatement();
String sql7 = "select a.uname uname,b.id id,b.title title,b.context context,b.time time,b.views views,b.collection collection,b.replies replynum,b.likenum from usr a,post b where a.id = b.publisher_id and type_id=0";  
ResultSet rs7 = stm4.executeQuery(sql7);

		while(rs7.next()){		
	%>
	
	<div class="community-item">
		<div class="h-tag">
			<div class="title">
				<a onclick="increaseViews(<%=rs7.getString("id") %>)"> 
					<font style="font-size: 18px; line-height: 25px; color: #222226; cursor: pointer; font-weight: 700;">
						<%=rs7.getString("title") %>
					</font>
				</a>
			</div>
		</div>
		<div class="context">	
				<font style="cursor: pointer;">
					<%=rs7.getString("context") %>
				</font>
		</div>
		<div class="operation">
			<div class="like">
			
			点赞：<%=rs7.getString("likenum") %>
			</div>
			<div class="post-publisher">
			作者：<%=rs7.getString("uname") %> 
			</div>
			<div class="post-time">
			<%=rs7.getString("time") %>
			</div>
			<div class="replies">
			
			<%=rs7.getString("replynum") %>回复
			</div>
			<div class="views">
			<%=rs7.getString("views") %>浏览
			</div>
		</div>
	</div>
	<%
		
		}
	%>

</div>
</div>

</div>

<div class="bottom">

</div>
</body>
</html>