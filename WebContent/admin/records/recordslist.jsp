<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="author" content="DeathGhost" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!--[if lt IE 9]>
<script src="js/html5.js"></script>
<![endif]-->
<script src="js/jquery.js"></script>
<script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
</head>

<body>

<section class="rt_wrap content mCustomScrollbar">
 <div class="rt_content">

      <section>
      <h2></h2>
      <form action="method!recordslist"  method="post">
      <input  name="biaoti" type="text"  value="${biaoti }" class="textbox" placeholder=" 电影名称"/>
      <input  name="username" type="text"  value="${username }" class="textbox" placeholder=" 用户"/>
         类别：<select  name="status" class="select">
         <option value="">--所有--</option>
          <option value="想看" <c:if test="${status=='想看' }">selected</c:if> >想看</option>
          <option value="已看过" <c:if test="${status=='已看过' }">selected</c:if>>已看过</option>
         </select>
      <input type="submit" value="查询" class="group_btn"/>
      </form>
     </section>
     
     <section>
      <div class="page_title">
       <h2 class="fl">观影记录列表</h2>
      </div>
      <table class="table">
       <tr>
               <th>电影类别</th>
	           <th>电影名称</th>
	           <th>用户</th>
	            <th>类别</th>
	           <th>添加时间</th>
	           <th>操作</th>
       </tr>
       
       <c:forEach items="${list}"  var="bean">
       <tr>
	           <td>${bean.movie.category}</td>
	           <td>${bean.movie.biaoti}</td>
	           <td>${bean.user.username}</td>
	             <td>${bean.status}</td>
	           <td> ${fn:substring(bean.createtime,0, 11)}</td>
        <td>
          <a href="method!recordsdelete?id=${bean.id }" onclick=" return confirm('确定要删除吗?');">删除</a>
        </td>
       </tr>
      </c:forEach>
      
      </table>
      
      <aside class="paging">
       <a>${pagerinfo }</a>
      </aside>
     </section>
    
   
   
 </div>
</section>
</body>
</html>
