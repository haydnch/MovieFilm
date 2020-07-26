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
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/jquery.SuperSlide.2.1.js"></script>
<script src="js/common.js"></script>
<!--[if IE 6]>
<script src="js/DD_belatedPNG.js"></script>
<script>
  DD_belatedPNG.fix('#');
</script>
<![endif]-->
</head>

<body>
<div class="wrapper">
	<jsp:include page="top.jsp"></jsp:include>
	
	<div class="contenter clearfix">
		<jsp:include page="left.jsp"></jsp:include>
		
		
		
		
		<div class="contenter-main">
			<div class="cur-pos-wrap">
				<p class="cur-pos">您当前所在的位置：<a >首页</a> &gt; <strong>新闻公告</strong></p>
			</div>
			<div class="inside-contenter">
				<ul class="innews-list">
					<li>
					  <c:forEach items="${list}" var="bean">
						<div class="innews-one">
							<div class="innews-tit">
								<h3 class="title"><a href="indexmethod!xq_gonggao?id=${bean.id }">${bean.biaoti }</a></h3>
								<span class="time">${fn:substring(bean.createtime,0, 10)}</span>
							</div>
							<p class="innews-exp">内容详情：${bean.content }</p>
							
						</div>
						 </c:forEach> 
					</li>
					
					
				</ul>
			</div>
			
			
		</div>
		
		
		<jsp:include page="right.jsp"></jsp:include>
		
		
	</div>
	
	<jsp:include page="down.jsp"></jsp:include>
</div>
</body>
</html>
