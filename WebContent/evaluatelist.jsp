<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="css/base.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/test.css">
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/jquery.SuperSlide.2.1.js"></script>
<script src="js/common.js"></script>
<!--[if IE 6]>
<script src="js/DD_belatedPNG.js"></script>
<script>
  DD_belatedPNG.fix('#');
</script>
<![endif]-->
<style type="text/css">
	.hovertable a:link{color:blue;}
	.hovertable a:visited {color: blue}	/* 已访问的链接 */
	.hovertable a:hover{color:red;}
</style>
</head>

<body>
<div class="wrapper">
	  <jsp:include page="top.jsp"></jsp:include>
	  
	<div class="contenter clearfix">
		  <jsp:include page="left.jsp"></jsp:include>
		
		
		
		
		<div class="contenter-main">
			<div class="cur-pos-wrap">
				<p class="cur-pos">您当前所在的位置：<strong>我的影评记录</strong></p>
			</div>
			
			<div class="inside-contenter">
			

            <table style="width:100%" class="hovertable">
              <tr>
              <th>电影名称</th>
               <th>电影类别</th>
	           <th>评分</th>
	           <th>评价内容</th>
	           <th>操作</th>
              </tr>
              
               <c:forEach items="${list}" var="bean" varStatus="v">
             <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
	           <td>${bean.movie.biaoti}</td>
	           <td>${bean.movie.category}</td>	            
	            <td>${bean.fen}</td>
	             <td>${bean.content}</td>
	              <td>   
                    <a href="indexmethod!evaluatedelete?id=${bean.id }" onclick=" return confirm('确定要删除吗?'); ">【删除】</a>     
	              </td>
             </tr>
              </c:forEach>
              
              


            </table>
            
				<table class="hovertable">
				 <tr>
               ${pagerinfo }
               </tr>
				 </table>
			</div>
			
			
		</div>
		
		
		
		  <jsp:include page="right.jsp"></jsp:include>
	</div>
	  <jsp:include page="down.jsp"></jsp:include>
</div>
</body>
</html>
