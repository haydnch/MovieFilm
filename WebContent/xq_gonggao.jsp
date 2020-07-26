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
				<p class="cur-pos">您当前所在的位置：<a href="index.html">首页</a> &gt; <a href="news.html">公告信息</a> &gt; 公告详细</p>
			</div>
			<div class="inside-contenter">
				<div class="article-detail">
					<div class="article-tit">
					<input type="hidden" name="id" value="${bean.id }"/>
						<h1 class="title">${bean.biaoti }</h1>
						<p class="title-exp">作者：admin</p>
						<p class="title-exp">发布日期：${fn:substring(bean.createtime,0, 10)}</p>
					</div>
					<div class="article-cont">
						<p>${bean.content}</p>
						</div>
				</div>
			</div>
		</div>
		
		
	<jsp:include page="right.jsp"></jsp:include>
		
		
		
	</div>
	<jsp:include page="down.jsp"></jsp:include>
</div>
</body>
</html>
