<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>后台管理系统</title>
<meta name="author" content="DeathGhost" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!--[if lt IE 9]>
<script src="js/html5.js"></script>
<![endif]-->
<script src="js/jquery.js"></script>
<script type=text/javascript>
$(document).ready(function(){
	$("#firstpane .menu_body:eq(0)").show();
	$("#firstpane p.menu_head").click(function(){
		$(this).addClass("current").next("div.menu_body").slideToggle(300).siblings("div.menu_body").slideUp("slow");
		$(this).siblings().removeClass("current");
	});
	$("#secondpane .menu_body:eq(0)").show();
	$("#secondpane p.menu_head").mouseover(function(){
		$(this).addClass("current").next("div.menu_body").slideDown(500).siblings("div.menu_body").slideUp("slow");
		$(this).siblings().removeClass("current");
	});
	
});
</script>
<script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
<link rel=stylesheet type=text/css href="css/zzsc.css"/>
<script type=text/javascript src="js/jquery.min.js"></script>
</head>
<body>
<aside class="lt_aside_nav ">
  <div id="firstpane" class="menu_list">

    <p class="menu_head">用户管理</p>
    <div style="display:none" class=menu_body >
       <a href="method!userlist" target="main">用户信息管理</a>
    </div>
     
 
    <p class="menu_head">电影信息管理</p>
    <div style="display:none" class=menu_body >
       <a href="method!movieadd" target="main">电影信息添加</a>
       <a href="method!movielist" target="main">电影信息管理</a>
    </div>
    
    
    <p class="menu_head">电影评价管理</p>
    <div style="display:none" class=menu_body >
       <a href="method!evaluatelist" target="main">电影评价管理</a>
    </div>
    
    
      <p class="menu_head">用户观影记录管理</p>
    <div style="display:none" class=menu_body >
       <a href="method!recordslist" target="main">用户观影记录管理</a>
    </div>
   
   <p class="menu_head">公告管理</p>
    <div style="display:none" class=menu_body >
      <a href="method!gonggaoadd" target="main">公告添加</a>
       <a href="method!gonggaolist" target="main">公告信息管理</a>
    </div>

</div>
</aside>
 



</body>
</html>
