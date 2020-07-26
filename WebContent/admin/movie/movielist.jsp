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
      <form action="method!movielist"  method="post">
      <input  name="biaoti" type="text"  value="${biaoti }" class="textbox" placeholder=" 电影名称"/>
        类别： <select  name="category" id="categoryid" class="select">
                   <option value="" >--所有--</option>
                   <option value="Action" <c:if test="${category=='Action' }">selected</c:if>>Action</option>
                   <option value="Adventure" <c:if test="${category=='Adventure' }">selected</c:if>>Adventure</option>
                   <option value="Animation" <c:if test="${category=='Animation' }">selected</c:if>>Animation</option>
                   <option value="Children" <c:if test="${category=='Children' }">selected</c:if>>Children</option>
                   <option value="Comedy" <c:if test="${category=='Comedy' }">selected</c:if>>Comedy</option>
                   <option value="Documentary" <c:if test="${category=='Documentary' }">selected</c:if>>Documentary</option>
                   <option value="Others" <c:if test="${category=='Others' }">selected</c:if>>Others</option>
                 </select>
      <input type="submit" value="查询" class="group_btn"/>
      </form>
     </section>
     
     <section>
      <div class="page_title">
       <h2 class="fl">影视信息列表</h2>
      </div>
      <table class="table">
       <tr>
       		  <th>电影名称</th>
               <th>类别</th>
               <th>图片</th>
	           <th>导演</th>
	           <th>演员表</th>
	           <th>综合评分</th>
	           <th>发布时间</th>
	           <th>操作</th>
       </tr>
       
       <c:forEach items="${list}"  var="bean">
       <tr>
       			 <td>${bean.biaoti}</td>
	           <td>${bean.category}</td>
	           <td> <img src='<%=basePath %>/temp/${bean.imgpath}' width="80" height="100"/></td>
	          
	           <td>${bean.dao}</td>
	           <td>${bean.zhu}</td>
	           <td>${bean.zong}</td>
	           <td> ${fn:substring(bean.createtime,0, 10)}</td>
        <td>
          <a href="method!movieupdate?id=${bean.id }" >编辑</a>
          <a href="method!moviedelete?id=${bean.id }" onclick=" return confirm('确定要删除吗?');">删除</a>
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
