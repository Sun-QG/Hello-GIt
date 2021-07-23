<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 42494
  Date: 2020/9/5
  Time: 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
	  <meta charset="utf-8">
    <title>论坛</title>
	 
    <style>
      body{
        width: 70%;
        margin: 0 auto;
      }
      .sousuo{
        border: 2px solid #8c222c
      }
      .wenben{
        width: 350px;
        height: 28px;
        padding: 10px 84px 10px 10px;
        margin-right: 20px;
        line-height: 18px;
        font-size: 14px;
        color: #333;
        border: none;
      }
      .sub{
        width: 88px;
        height: 30px;
        border: 0;
        padding-left: 2px;
        line-height: 28px;
        font-size: 16px;
        color: #fff;
        border-radius: 0;
        background-color: #8c222c;
        text-align: center;
        cursor: pointer;
      }
      ul{
        margin:0;
        padding:0;
        list-style:none;
      }
      .box{
        width:1100px;
        height:400px;
        position:relative;
        border:0px red solid;
        /*margin-left: -130px;*/
      }
      .ul1{
        width:100%;
        height:100%;
      }
      .ul1 li{
        position:absolute;
        top:0;
        left:0;
      }
      .left-botton{
        width:35px;
        height:70px;
        background-color:#00000050;
        color:#fff;
        text-align:center;
        line-height:70px;
        position:absolute;
        font-size:27px;
        top:135px;
        left:0;
        border-radius:0 5px 5px 0;
      }
      .right-botton{
        width:35px;
        height:70px;
        background-color:#00000050;
        color:#fff;
        text-align:center;
        line-height:70px;
        position:absolute;
        font-size:27px;
        top:135px;
        right:0;
        border-radius:5px 0 0 5px;
      }
      .ul2{
        position:absolute;
        bottom:20px;
        right:100px;
      }
      .ul2 li{
        width:170px;
        height:26px;
        background-color: rgba(150,150,150,0.5);
        text-align:center;
        line-height:20px;
        /*float:left;*/
        /*border-radius:100%;*/
        margin-right:10px;
        margin-top: -80px;
      }
      .ul2 li:hover{
        background-color: #bebab8;
        color:#fff;
      }
      .indexs{
        z-index:1000;
      }
      .nav-lunbo-left{
        width:220px;
        height:720px;
        float:left;
        /*border-radius:5px 5px 0 0;*/
        border:1px #8C222C solid;
      }
      .nav-lunbo-left>div:nth-child(1){
        width:100%;
        height:35px;
        border-radius:4px 4px 0 0;
        /* background-color:#487A6F; */
        color:#8C222C;
        line-height:35px;
        text-align:center;
        font-weight:bold;
      }
      .nav-lunbo-left-two{
        position:relative;
        background-color:#fff;
        color:#487A6F;
        line-height:32px;
        font-weight:bold;
        border-top:1px #8C222C dotted;
      }
      .nav-lunbo-left-samll{
        width:220px;

      }
      .nav-lunbo-left-big{
        width:220px;
        clear:both;
      }
      .nav-lunbo-left-samll>a{
        width:180px;
        height:100%;
        display:block;
        border-top:1px rgba(0,0,0,0) solid;
        border-bottom:1px rgba(0,0,0,0) solid;
        border-right:1px rgba(0,0,0,0) solid;
        margin-top:-1px;
        padding-left:10px;
        color:#8C222C;
        font-size:14px;
        font-family:Microsoft Yahei;
      }
      .nav-lunbo-left-big>div{
        width:180px;
        display:block;
        border-top:1px rgba(0,0,0,0) solid;
        border-bottom:1px rgba(0,0,0,0) solid;
        border-right:1px rgba(0,0,0,0) solid;
        margin-top:-1px;
        padding-left:10px;
        color:#8C222C;
        font-size:14px;
        font-family:Microsoft Yahei;
        clear:both;
      }
      .clearf:before, .clearf:after{
        content:"";
        display:block;
        clear: both;
      }
      .clearf{
        zoom:1;
      }
      .g{
        clear:both;
        padding-top:8px;
      }
      .nav-lunbo-left-samll:hover>a{
        background-color:#fff;
        border-top:1px #487A6F solid;
        border-bottom:1px #487A6F solid;
        border-right:1px #fff solid;
        position:relative;
        width:180px;
        z-index:1001;
      }
      .nav-lunbo-left-two:hover>span{
        /* display:block; */
        z-index:1000;
      }
      .nav-lunbo-left-two:hover+div{
        border-top:1px rgba(0,0,0,0) solid;
      }
      .nav-lunbo-left-big:hover>div{
        border-top:1px #487A6F solid;
        border-bottom:1px #487A6F solid;
        border-right:1px #fff solid;
        position:relative;
        background-color:#fff;
        z-index:1001;
      }
      .nav-lunbo-left-big>div>div:nth-child(2){
        margin-top: -10px;
        clear:both;
      }
      .clearfix:after{
        content:"|";
        display:block;
        color:#929292;
        visibility:hidden;
      }
      .nav-lunbo-left-big>div>div:nth-child(2)>a{
        color:#487A6F;
        font-size:12px;
        color:#929292;
        display:block;
        float:left;
        padding-right:5px;
        font-family:Arial;
        line-height:23px;
      }
      .nav-lunbo-left-big>div>div:nth-child(2)>a:hover{
        color:rgb(236,120,20);
        text-decoration: underline;
      }
      .nav-lunbo-left-two-span{
        position:absolute;
        left:190px;
        top:-1px;
        width:590px;
        height:500px;
        border:1px #487A6F solid;
        display:none;
        background-color:#fff;
        /* box-shadow:-1px 1px 8px #bbb; */ 
      }
      .nav-lunbo-zhong-long{
        position:relative;
        width:910px;
        height:535px;
      }
      .nav-lunbo-zhong-bottom-lunbo-ul{
        width:800px;
        height:535px;
        position:absolute;
        top:0;
        left:0;
        float:left;
      }
      .nav-lunbo-zhong-bottom-lunbo-ul>li{
        list-style:none;
        width:150px;
        height:250px;
        background-color:#fff;
        float:left;
        margin-right:50px;
        margin-bottom:16px;
      }
      .boxborder{
        margin-bottom: 10px;
      }
      .ziti{
        color: #929292;
        text-decoration: none;
        font-weight: 400;

      }
	  .black_overlay{
		  display: none;
		  position: fixed;
		  top: 0%;
		  left: 0%;
		  width: 100%;
		  height: 100%;
		  background-color: rgba(0, 0, 0, 0.8);
		  z-index:1001;
		  -moz-opacity: 0.8;
		  opacity:.80;
		  /* filter: alpha(opacity=88); */
	  }
	  .white_content {
		  display: none;
		  position: fixed;
		  top: 25%;
		  left: 35%;
		  width: 500px;
		  height: 350px;
		  /*padding: 20px;*/
		  /*border: 1px solid #8c222c;*/
		  background-color: white;
		  z-index:1002;
		  overflow: auto;
		  background-image: url("picture/背景.PNG");
	  }
	  /*#tab{*/
		/*  margin: 0;*/
		/*  padding: 0;*/
	  /*}*/
	  li{
		  list-style: none;
	  }
	  #tab{
		  /*width: 400px;*/
		  /*height: 400px;*/
		  /*border: 1px solid black;*/
		  /*margin:50px  auto;*/
	  }
	  #tabMenu{
		  overflow: hidden;
		  /*width: 650px;*/
	  }

	  #tabMenu li{
		  float: left;
		  width: 100px;
		  height: 50px;
		  line-height: 50px;
		  text-align: center;
		  /* background-color: cornflowerblue; */
		  /* border: 1px black solid; */
		  color: black;
		  cursor: pointer;
		  list-style: none;
	  }
	  #tabMenu li.active{
		  /* background-color: rgb(16, 57, 134); */
		  width: 18%;
		  border-bottom: 5px #15a0f4 solid;
	  }
	  #tabConent p{
		  display: none;
	  }
	  #tabConent p.on{
		  display: block;
	  }
	#tab a{
		color: white;
		font-size: 30px;
		text-decoration: none;
		float: right;
		margin-right: 16px;
	}
	
	.suibian {
		display: block;
		font-size: 16px;
		line-height: 24px;
		margin: 10px 0 0 10px;
	}
	
	a {
		text-decoration: none;
	}
	
	a:hover {
	   text-decoration: underline;
}
	</style>
  </head>
  <body>

  <%
  		String name = null;
 	 	String z = (String)session.getAttribute("id");
 	 		
 	 
		  String url = "jdbc:sqlserver://localhost:1433;databasename = it";
		  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		  Connection conn = DriverManager.getConnection(url,"sa","123456");

		  Statement stm = conn.createStatement();
		  String sql0 = "select uname from usr where id ="+z;
		  ResultSet rs0 = stm.executeQuery(sql0);
		  while (rs0.next())
		  {
			  name = rs0.getString("uname");
		  }
		  
 	   
  %>

  <div id="light" class="white_content">

	  <div id="tab">
		  <a href="javascript:void(0)" onclick = "y()">×</a>
		  <ul id="tabMenu">
			  <li class="active">登录</li>
			  <li>注册</li>
		  </ul>

		  <div id="tabConent">

			  <form action="login.jsp" method="post" id="myform">
				  <p class="on">
					  <input type="text" placeholder=" 用户名：" style="line-height: 40px;width: 300px;margin-left: 100px;border-radius: 25px;margin-top: 30px" name="account">
					  <br>
					  <input type="password" placeholder=" 密码：" style="line-height: 40px;margin-top: 25px;width: 300px;margin-left: 100px;border-radius: 25px" name="pwd">
					  <br>
					  <a href="#" onclick="login()" style="font-size: 20px;height: 40px;width: 300px;background-color: #5a9789;margin-right: 100px;line-height: 40px;text-align: center;margin-top: 38px;border-radius: 20px;">登录</a>
					  <br>
					  <a href="#" style="font-size: 18px;float: right;margin-top: 10px">
						  忘记密码？
					  </a>
				  </p>
		      </form>


			  <form id="myform2" method="post" action="zhuce.jsp">
				  <p>
					  <input type="text" name="name" placeholder="用户名" style="line-height: 40px;width: 300px;margin-left: 100px;border-radius: 25px;margin-top: 10px">
					  <input type="text" name="account" placeholder=" 用户账号：" style="line-height: 40px;width: 300px;margin-left: 100px;border-radius: 25px;margin-top: 25px">
					  <br>
					  <input type="password" id="mima1" name="pwd" placeholder=" 密码：" style="line-height: 40px;margin-top: 25px;width: 300px;margin-left: 100px;border-radius: 25px">
					  <br>
					  <input type="password" id="mima2" placeholder=" 确认密码：" style="line-height: 40px;margin-top: 25px;width: 300px;margin-left: 100px;border-radius: 25px">
					  <br>
					  <a href="#" onclick="zhuce()" style="font-size: 20px;height: 40px;width: 300px;background-color: #5a9789;margin-right: 100px;line-height: 40px;text-align: center;margin-top: 25px;border-radius: 20px">注册</a>
				  </p>
			  </form>


		  </div>
	  </div>

  </div>
  <div id="fade" class="black_overlay"></div>
  <div	style="height: 40px;background-color: #f2eeec">
	  <div style="height: 4px"></div>
	  <div style="margin-top: 5px">
		  <%
			  if(z.equals("")){
		  %>
		  <a id="top1" href="javascript:void(0)" onclick="x()" style="text-decoration: none;margin-left: 850px;font-size: 15px;color: #8c222c;align-content: center">登录/注册</a>
		  <%
			  }
			  else{
		  %>

		  <span id="top3" style="font-size: 15px;color: #8c222c;margin-left: 650px">
			欢迎：<%=name%>
		  </span>
		  <span >
			  <a href="gerenzhongxin/gerenzhuye.jsp?id=<%=z %>" style="font-size: 15px;color: #8c222c;margin-left: 10px;text-decoration: none" >我的论坛</a>
		  </span>
		  <span >
			  <a href="luntan_niuren/niuren.jsp" style="font-size: 15px;color: #8c222c;margin-left: 10px;text-decoration: none" >论坛牛人</a>
		  </span>
		  <span>
			  <a href="post/postpublisher.jsp" style="font-size: 15px;color: #8c222c;margin-left: 10px;text-decoration: none" onclick="">我要发帖</a>
		  </span>
		  <span>
			  <a href="fuwu_zhuanqu/home.jsp" style="font-size: 15px;color: #8c222c;margin-left: 10px;text-decoration: none" >服务专区</a>
		  </span>
		  <span>
			  <a href="out.jsp" style="font-size: 15px;color: #8c222c;margin-left: 10px;text-decoration: none" onclick="out()">退出登录</a>
		  </span>
		  
		  <%
			  }
		  %>
	  </div>
  </div>
  <div align="center" style="height: 60px">
    <div style="float: left;width: 50px;height: 40px"></div>
    <div style="float: left;font-family: 字魂170号-俊逸手书（非商用）;font-size: 40px;color: #be0200;margin-top: -10px;margin-left: 80px">
      IT论坛
    </div>
    <div style="float: right;width: 70px;height: 30px;"></div>
    <form action="post/searchResult.jsp" method="post">
      <div style="float: right" class="sousuo">
        <input name="wenben" type="text" class="wenben">
        <input type="submit" value="搜索" class="sub">
      </div>
    </form>
  </div>
  <div class="box">
	  <ul class="ul1" id="ul1">
		  <!-- <li class="indexs"><img src="picture/1.png" width="1063.43" height="350"><> -->
		  <li><img class="img-slide" src="image/lol.gif" width="1063.43" height="350">
		  <li><img class="img-slide" src="image/lwp.jpg" width="1063.43" height="350">
		  <li><img class="img-slide" src="image/cq.jpg" width="1063.43" height="350">
		  <li><img class="img-slide" src="image/zjl.jpg" width="1063.43" height="350">
	  </ul>
<%--	  <div class="left-botton indexs" id="left">&lt;</div>--%>
<%--	  <div class="right-botton indexs" id="right">&gt;</div>--%>

  </div>

  <script type="text/javascript">
	  var index=0;
	  //改变图片
	  function ChangeImg() {
		  index++;
		  var a=document.getElementsByClassName("img-slide");
		  if(index>=a.length) index=0;
		  for(var i=0;i<a.length;i++){
			  a[i].style.display='none';
		  }
		  a[index].style.display='block';
	  }
	  //设置定时器，每隔两秒切换一张图片
	  setInterval(ChangeImg,2000);
  </script>
  <div>
    <div style="float: left;width: 25%">
        <div class="nav-lunbo-left">
          <div >IT社区分类</div>

          <div class="nav-lunbo-left-two nav-lunbo-left-big">
            <div class="boxborder">
              <div class="g clearf">
                <a href="post/post.jsp?type_id=1" style="color:#ff3b00;" id="i8">Web前端</a>
              </div>
            </div>
             
          </div>

          <div class="nav-lunbo-left-two nav-lunbo-left-big">  
            <div class="boxborder">
              <div class="g clearf">
                <a href="post/post.jsp?type_id=2" style="color:#ff3b00;" id="i7">编程语言</a>
              </div>
            </div>
          </div>

          <div class="nav-lunbo-left-two nav-lunbo-left-big">
            <div class="boxborder">
              <div class="g clearf">
                <a href="post/post.jsp?type_id=4" style="color:#ff3b00;" id="i4">数据库技术</a>
              </div>
            </div>
          </div>

          <div class="nav-lunbo-left-two nav-lunbo-left-big">
            <div class="boxborder">
              <div class="g clearf">
                <a href="post/post.jsp?type_id=5" style="color:#ff3b00;" id="i3">操作系统</a>
              </div>
            </div>
          </div>
          
          <div class="nav-lunbo-left-two nav-lunbo-left-big">
            <div class="boxborder">
              <div class="g clearf">
                <a href="post/post.jsp?type_id=6" style="color:#ff3b00;" id="i3">云计算</a>
              </div>
            </div>
          </div>

          <div class="nav-lunbo-left-two nav-lunbo-left-big">
            <div class="boxborder">
              <div class="g clearf">
                <a href="post/post.jsp?type_id=1" style="color:#ff3b00;" id="i7">大数据</a>
              </div>
            </div>
            <span class="nav-lunbo-left-two-span" style="top:-400px">
										<div style="margin-left: 30px;">
											<div style="margin-top: 20px;font-size: 20px;color: #8C222C;margin-bottom: 5px;border-bottom: 1px #8C222C solid;">大数据</div>
											<div >
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a> 
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
												<a href="#" class="ziti"></a>
												<a class="ziti">|</a>
											</div>

										</div>
									</span>
          </div>
        
          <div  >
				<!-- <h2>热榜</h2>
				<div class="boxborder">
					<ul class="boxborder">
						<li ><em>1.</em><a href="https://www.zhihu.com/question/422170519">如何看待我国新设北京、湖南、安徽3个自贸区？会给当地带来哪些发展机遇？</a></li>
						<li ><em>2.</em><a href="https://www.zhihu.com/question/33572597">中国为什么不取缔电动车和电动三轮车？</a></li>
						<li><em>3.</em><a href="https://www.zhihu.com/question/422165720">兰州市规定「的哥大面积文身可能致女性、小孩等不适，应清除或遮盖」，你怎么看</a></li>
						<li><em>4.</em><a href="https://www.zhihu.com/question/292715190">你怎样看待一个说脏话的女生?</a></li>
						<li><em>5.</em><a href="https://www.zhihu.com/question/422217606">如何看待某迈腾车主恶意别车后还往别人前档风扔奶茶，曝光后发现5年前就是惯犯？</a></li>
						<li><em>6.</em><a href="https://www.zhihu.com/question/422262312">如何看待微软以75亿美元收购贝塞斯达母公司ZeniMax Media，并获得旗下所有工作室与IP？</a></li>
						<li><em>7.</em><a href="https://www.zhihu.com/question/422149986">如何看待《极限挑战宝藏行》刘宇宁等人采摘珍稀植物雪兔子，刘宇宁道歉称是「道具」，节目组致歉一事？</a></li>
						<li><em>8.</em><a href="https://www.zhihu.com/question/323277376">如果以比李白大一岁的年纪穿越到唐朝，每一篇诗都比李白早一年发表，李白还会出名吗？</a></li>
						<li><em>9.</em><a href="https://www.zhihu.com/question/422210169">如何看待家长给学生点的外卖被扔垃圾桶，校方称外卖一律不准入校？有没有更好的解决办法？</a></li>
						<li><em>10.</em><a href="https://www.zhihu.com/question/284797534">准时准点的睡眠真的那么重要吗?</a></li>
					</ul>
				</div> -->
			</div>
        </div>
    </div>
	  <%
		  request.setCharacterEncoding("UTF-8");
		  String url1 = "jdbc:sqlserver://localhost:1433;databasename = it";
		  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		  Connection conn1 = DriverManager.getConnection(url,"sa","123456");
		  Statement stm1 =conn1.createStatement();
		  String sql1="select top 4 * from post order by newid()";
		  ResultSet rs1=stm1.executeQuery(sql1);  

	  %>
	  <div style="float: right;  width: 74%;">
		  <div style="border: 1px #8c222c solid;height: 300px">
			  <div style="margin-left: 10px;color: #bf2737">
				  随便看看
			  </div>
			  <%while(rs1.next()){ %>
			  <a href="post/postDetail.jsp?id=<%=rs1.getInt("id") %> ">
			  	<div class="suibian"><%=rs1.getString("title") %></div>
			  </a>
			  <%} %>
		  </div>
		  <div style="margin-left: 10px;color: #bf2737">
				  <a href="post/testTuiJian.jsp" style="font-size: 15px;color: #8c222c;margin-left: 10px;text-decoration: none" onclick="">猜你喜欢</a>
			  </div>
	  </div>
    
 
  <script>
	  /* function forSection(y,id){
		  location=("Section.jsp?y="+y+"&postbar="+id);
	  } */
  </script>
  <script type="text/javascript">
	function x(){
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
	}
	function y(){
		document.getElementById('light').style.display='none';
		document.getElementById('fade').style.display='none';
	}
	// 1.获取元素
	let li = document.querySelectorAll('#tabMenu li')
	let p = document.querySelectorAll('#tabConent p')

	// 2.遍历li
	for (let i = 0; i < li.length; i++) {
		// 3.添加事件
		li[i].addEventListener('mouseover', function () {
			// 添加样式之前清除又有li的样式
			for (let j = 0; j < li.length; j++) {
				// 清除active样式类
				li[j].classList.remove('active')
			}
			// 添加样式
			this.classList.add('active')
			// 显示内容之前,把所有显示的隐藏
			for (let j = 0; j < li.length; j++) {
				// 清除on样式
				p[j].classList.remove('on')
			}
			// 显示对应内容
			p[i].classList.add('on')
		})
	}
	function login() {
		document.getElementById("myform").submit();
	}
	function zhuce() {
		if(document.getElementById("mima1").value==document.getElementById("mima2").value){
			document.getElementById("myform2").submit();
		}
		else{
			alert("密码不一致");
		}
	}
	function out() {
		document.location="out.jsp";
	}
	function person() {
		document.location="gerenzhongxin/gerenzhuye.jsp";
		
	}
  </script>
  </body>
</html>
