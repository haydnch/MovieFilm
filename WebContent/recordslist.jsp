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
				<p class="cur-pos">您当前所在的位置：<a >观影记录</a> &gt; <strong>我的观影记录</strong></p>
			</div>
			
			<div class="inside-contenter">
			 <form action="indexmethod!recordslist"  method="post">
     
        类别：<select  name="status">
         <option value="">--所有--</option>
          <option value="想看" <c:if test="${status=='想看' }">selected</c:if> >想看</option>
          <option value="已看过" <c:if test="${status=='看过' }">selected</c:if>>看过</option>
         </select>
      <input type="submit" value="查询" class="group_btn"/>
      </form>	
				<br/>

            <table style="width:100%" class="hovertable">
              <tr>
               <th>电影名称</th>
               <th>电影类别</th>
	          
	           <th>状态</th>
	           <th>用户</th>
	           <th>添加时间</th>
	           <th>操作</th>
              </tr>
              
               <c:forEach items="${list}" var="bean" varStatus="v">
             <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
	           <td>${bean.movie.biaoti}</td>
	           <td>${bean.movie.category}</td>
	           <td>${bean.status}</td>
	            <td>${bean.user.username}</td>
	             <td> ${fn:substring(bean.createtime,0, 11)}</td>
	              <td>   
                    <a href="indexmethod!xq_movie?id=${bean.movie.id } " >【电影详情】</a>
                    <a  href="indexmethod!recordsdelete?id=${bean.id }" onclick=" return confirm('确定要删除吗?'); ">【删除】</a>     
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
