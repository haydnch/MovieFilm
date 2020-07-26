<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

      
    <form action="method!movieupdate2" method="post" onsubmit="return checkform()">
    <input type="hidden" name="id" value="${bean.id }"/>
     <section>
      <h2><strong style="color:grey;">电影信息修改</strong></h2>
      <ul class="ulColumn2">
      
       
        <li>
        <span class="item_name" style="width:120px;">分类：</span>
                <select  name="category" id="categoryid" class="select">
                   <option value="" >--所有--</option>
                   <option value="Action" <c:if test="${category=='Action' }">selected</c:if>>Action</option>
                   <option value="Adventure" <c:if test="${category=='Adventure' }">selected</c:if>>Adventure</option>
                   <option value="Animation" <c:if test="${category=='Animation' }">selected</c:if>>Animation</option>
                   <option value="Children" <c:if test="${category=='Children' }">selected</c:if>>Children</option>
                   <option value="Comedy" <c:if test="${category=='Comedy' }">selected</c:if>>Comedy</option>
                   <option value="Documentary" <c:if test="${category=='Documentary' }">selected</c:if>>Documentary</option>
                   <option value="Others" <c:if test="${category=='Others' }">selected</c:if>>Others</option>
                 </select>
       </li>
       
       <li>
        <span class="item_name" style="width:120px;">电影名称：</span>
        <input type="text" name="biaoti"  id='biaotiid' value="${bean.biaoti}" class="textbox textbox_295" />
       </li>
       
       <li>
        <span class="item_name" style="width:120px;">导演：</span>
        <input type="text" name="dao"  id='daoid' value="${bean.dao}" class="textbox textbox_295" />
       </li>
       
       <li>
        <span class="item_name" style="width:120px;">演员表：</span>
        <input type="text" name="zhu"  id='zhuid' value="${bean.zhu}" class="textbox textbox_295" />
       </li>
       
       
        <li>
        <span class="item_name" style="width:120px;">简介：</span>
        <textarea name="content"  id="contentid"  class="textarea" style="width:500px;height:100px;">${bean.content}</textarea>
       </li>
       
       
       <li>
        <span class="item_name" style="width:120px;">电影图片：</span>
        <img src='<%=basePath %>/temp/${bean.imgpath}' width="80" height="100"/>
         
       </li>
       
       
     
       <li>
         <span class="item_name" style="width:120px;"></span>
          <input type="submit" value="提交" class="link_btn"/>
        <input type="button" onclick="javascript:history.go(-1);" value="返回"  class="link_btn"/>
       </li>
       
       
      </ul>
     </section>
     </form>
     
     
    
   
 </div>
</section>
</body>
</html>
