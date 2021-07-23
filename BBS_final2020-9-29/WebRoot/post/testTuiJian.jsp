<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	body {
        margin: 0;
        
    }
    
    .community-item {
    	display : block;
    	width : 1034px;
    	height : 125px;
    	border-bottom: 2px solid #f0f0f2;
    	 
    	padding : 24px;
    }
    
    .h-tag {
    	display : block;
    	width : 806px;
    	height : 24px;
    	overflow: hidden;
    }
    
    .context {
    	display : block;
    	width : 806px;
    	height : 41px;
    	color: #555666;
    	overflow: hidden;
    	font-weight: 400;
    }
    
    .operation {
    	display : block;
    	width : 806px;
    	height : 28px;
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
    
    a {
    	text-decoration: none;
    }
    
</style>
<script type="text/javascript">
	function increaseViews(x){
		
		window.location.href = "increaseViewProcess.jsp?id="+x;
	}
	
	
</script>
<body>

	<%
	  double [ ][ ] arr=new  double [6][2];
	  for (int i=0;i<=5;i++)
	  {
		  for (int j=0;j<=1;j++)
		  {
			  if(j==0)//type
			  {
				  arr[i][j]=i+1;
			  }
			  else if(j==1)//type对应的分值
			  {
				  arr[i][j]=0;
			  }  
			  
		  }
		  
	  }
	  String z = (String)session.getAttribute("id");
	  if(z==null || z==""){
        z="";
      }
	  String url = "jdbc:sqlserver://localhost:1433;databasename = it";
	  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	  Connection conn = DriverManager.getConnection(url,"sa","123456");

	  //view,浏览表
	  Statement stm = conn.createStatement();
	  String sql0 = "select b.type_id,count(type_id) count  from [view]  a, post b ";
	  sql0+=" where a.post_id=b.id and usr_id ="+z;//暂时写死用户id
	  sql0+=" group by type_id";
	  ResultSet rs0 = stm.executeQuery(sql0);
	  while (rs0.next())
	  {
		  String type_id= rs0.getString("type_id");
		  String count= rs0.getString("count");
		  int type_id2 = Integer.parseInt(type_id);
		  int count2 = Integer.parseInt(count);
		  for(int i=0;i<=5;i++)
		  {
			  if(arr[i][0]==type_id2)
			  {
				  arr[i][1]+=count2 */* 0.1 */0.35;
			  }
		  }
	  }
	  rs0.close();
	  stm.close();
/*  	  for(int i=0;i<=5;i++)
	  {
		  System.out.println(arr[i][1]);
	  }
	  System.out.println("-----------------------------------");  */
	  
	  //题目没有要求对点赞。 GLS 2021.7.4
	  /* //linum，点赞表
	  Statement stm1 = conn.createStatement();
	  String sql1 = "select b.type_id,count(type_id) count  from likenum a, post b ";
	  sql1+=" where a.post_id=b.id and usr_id =1";//暂时写死用户id
	  sql1+=" group by type_id";
	  ResultSet rs1 = stm1.executeQuery(sql1);
	  while (rs1.next())
	  {
		  String type_id= rs1.getString("type_id");
		  String count= rs1.getString("count");
		  int type_id2 = Integer.parseInt(type_id);
		  int count2 = Integer.parseInt(count);
		  for(int i=0;i<=5;i++)
		  {
			  if(arr[i][0]==type_id2)
			  {
				  arr[i][1]+=count2 *0.35;
			  }
		  }
	  }
	  rs1.close();
	  stm1.close(); */
/*  	  for(int i=0;i<=5;i++)
	  {
		  System.out.println(arr[i][1]);
	  }
	  System.out.println("-----------------------------------"); */ 
	  
	//shoucang，收藏表
	  Statement stm2 = conn.createStatement();
	  String sql2 = "select b.type_id,count(type_id) count  from shoucang a, post b ";
	  sql2+=" where a.post_id=b.id and usr_id ="+z;//暂时写死用户id
	  sql2+=" group by type_id";
	  ResultSet rs2 = stm2.executeQuery(sql2);
	  while (rs2.next())
	  {
		  String type_id= rs2.getString("type_id");
		  String count= rs2.getString("count");
		  int type_id2 = Integer.parseInt(type_id);
		  int count2 = Integer.parseInt(count);
		  for(int i=0;i<=5;i++)
		  {
			  if(arr[i][0]==type_id2)
			  {
				  arr[i][1]+=count2 */* 0.55 */0.65;
			  }
		  }
	  }
	  rs2.close();
	  stm2.close();
/*  	  for(int i=0;i<=5;i++)
	  {
		  System.out.println(arr[i][1]);
	  }
	  System.out.println("-----------------------------------"); */ 
	  double [ ][ ] arr1=new  double [1][2];
	  //冒泡排序
	  for(int i=0;i<=4;i++)
	  {
		  for(int j=i+1;j<=5;j++)
		  {
			  if(arr[i][1]>arr[j][1])
			  {
				  arr1[0][0]=arr[i][0];
				  arr1[0][1]=arr[i][1];
				  
				  arr[i][0]=arr[j][0];
				  arr[i][1]=arr[j][1];
				  
				  arr[j][0]=arr1[0][0];
				  arr[j][1]=arr1[0][1];
				  
			  }
		  }
		  
	  }
      for(int i=0;i<=5;i++)
	  {
		  System.out.println(arr[i][0]+"  "+arr[i][1]);
	  }
	  System.out.println("-----------------------------------"); 
	  
	  //避免冷启动
	  if(arr[5][1]>0)
	  {
		  Statement stm3 = conn.createStatement();
		  /* String sql3 = "select distinct * from post a "; */
		  String sql3 = "select distinct * from usr a,post b where a.id = b.publisher_id ";   
		  sql3+="and ( type_id = "+arr[5][0]+" or type_id = "+arr[4][0]+" ) ";
		  sql3+=" order by b.likenum desc";
		  ResultSet rs3 = stm3.executeQuery(sql3);
		  int jump=0;//跳出
		  while (rs3.next())
		  {
			  
			  jump+=1;
			  if(jump>10)
			  {
				  break;
			  }
			  System.out.println(rs3.getString("title"));
			  %>
			  <div class="community-item">
		<div class="h-tag">
			<div class="title">
				<a onclick="increaseViews(<%=rs3.getString("id") %>)"> 
					<font style="font-size: 18px; line-height: 25px; color: #222226; cursor: pointer; font-weight: 700;">
						<%=rs3.getString("title") %>
					</font>
				</a>
			</div>
		</div>
		<div class="context">	
				<font style="cursor: pointer;">
					<%=rs3.getString("context") %>
				</font>
		</div>
		<div class="operation">
			<div class="like">
			
			点赞：<%=rs3.getString("likenum") %>
			</div>
			<div class="post-publisher">
			<%=rs3.getString("uname") %> 
			</div>
			<div class="post-time">
			<%=rs3.getString("time") %>
			</div>
			<div class="replies">
			
			<%=rs3.getString("replies") %>回复
			</div>
			<div class="views">
			<%=rs3.getString("views") %>浏览
			</div>
		</div>
	</div>
			<%  
		  }
		  rs3.close();
		  stm3.close();
	  }
	  else//若初始数据为空 用浏览量高的 GLS 2021.7.4 //若初始数据为空，则推荐点赞量最高的(想用牛榜里的)
	  {
		  Statement stm4 = conn.createStatement();
		  /* String sql4 = "select distinct * from post a"; */
		  String sql4 = "select distinct * from usr a,post b where a.id = b.publisher_id ";
		  sql4+=" order by b.views desc";
		  ResultSet rs4 = stm4.executeQuery(sql4);
		  int jump=0;//跳出
		  while (rs4.next())
		  {
			  
			  jump+=1;
			  if(jump>10)
			  {
				  break;
			  }
			  %>
			  
			  <div class="community-item">
		<div class="h-tag">
			<div class="title">
				<a onclick="increaseViews(<%=rs4.getString("id") %>)"> 
					<font style="font-size: 18px; line-height: 25px; color: #222226; cursor: pointer; font-weight: 700;">
						<%=rs4.getString("title") %>
					</font>
				</a>
			</div>
		</div>
		<div class="context">	
				<font style="cursor: pointer;">
					<%=rs4.getString("context") %>
				</font>
		</div>
		<div class="operation">
			<div class="like">
			
			点赞：<%=rs4.getString("likenum") %>
			</div>
			<div class="post-publisher">
			<%=rs4.getString("uname") %> 
			</div>
			<div class="post-time">
			<%=rs4.getString("time") %>
			</div>
			<div class="replies">
			
			<%=rs4.getString("replies") %>回复
			</div>
			<div class="views">
			<%=rs4.getString("views") %>浏览
			</div>
		</div>
	</div>
			  <%
			  System.out.println(rs4.getString("title"));
			  
		  }
		  rs4.close();
		  stm4.close();
	  }
	  
    
	  
	
     %>
</body>
</html>