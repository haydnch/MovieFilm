<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="css/base.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/jquery.SuperSlide.2.1.js"></script>
 <script language="JavaScript" src="<%=path %>/js/public.js" type="text/javascript"></script>

<script src="js/common.js"></script>

</head>

<body>
<div class="wrapper">
	<jsp:include page="top.jsp"></jsp:include>
	
	
	
	<div class="contenter clearfix">
		<jsp:include page="left.jsp"></jsp:include>
		
		
		
		
		<div class="contenter-main">
			<div class="cur-pos-wrap">
				<p class="cur-pos">您当前所在的位置：<a >首页</a> &gt; <a >电影信息</a> &gt; <strong>电影详情</strong></p>
			</div>
			<div class="inside-contenter">
				<div class="pro-det">
					<div class="pro-det-head clearfix">
				    <input type="hidden" name="id" value="${bean.id }"/>
						<div class="pic"><img src="<%=basePath%>/temp/${bean.imgpath }"></div>
						<div class="text">
							 <p> <strong>片名：</strong>${bean.biaoti }</p>
                             <p> <strong>类别：</strong>${bean.category }</p>
                             <p> <strong>导演：</strong>${bean.dao }</p>
                             <p> <strong>演员：</strong>${bean.zhu}</p>
                             <p> <strong>评分：</strong>${bean.zong }</p>
                             <br/>
                             <p> 
                              <c:if test="${user!=null  }">
                             <a href="indexmethod!recordsadd?id=${bean.id }"><span style="color: red">【想看】</span></a>&nbsp; &nbsp; &nbsp; &nbsp; 
                             <a href="indexmethod!recordsadd2?id=${bean.id }"><span style="color: #85142B">【看过】</span></a>&nbsp; &nbsp; &nbsp; &nbsp; 
                             </c:if>
                             </p>
						</div>
					</div>
					<div class="pro-det-mess">
						<h3 class="title"><strong>简介：</strong></h3>
						<p>
						${bean.content }
						</p>
						
						
						<h3 class="title"><strong>评价信息：</strong></h3>
						<p>
					

						
			 <table style="width:100% ;border-collapse:separate;border-spacing:8px;" class="hovertable">
              <tr>
               <th align="center" style="width:10%" >评价用户</th>
	           <th align="center" style="width:20%">评分</th>
	           <th align="center">评价内容</th>
              </tr>
              
              <c:forEach items="${list}" var="bean2" varStatus="v">
              <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
	            <td align="center"> <strong>${bean2.user.username }</strong></td>
	            <td align="center"><font style="color:#000000">${bean2.fen}</font></td>
	            <td align="center">${bean2.content}</td>  
              </tr>
              </c:forEach>
              
              
              </table>
				<div>
               ${pagerinfo }
             </div>
						
					</div>
				</div>
				<div class="column-common-one">
					<div class="column-common-tit">
						<i class="tag-view"></i>
						<h3 class="title">	 
						&nbsp; &nbsp; &nbsp; &nbsp; 	
					<a href="indexmethod!evaluateadd?id=${bean.id }"><font color="green">【评价】</font></a>&nbsp; &nbsp; &nbsp; &nbsp; 
                	 <a href="javascript:history.go(-1);" ><font color="red">【返回上页】</font></a>
						</h3> 
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
