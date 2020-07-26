<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

      
    <form action="method!gonggaoupdate2" method="post" onsubmit="return checkform()">
    <input type="hidden" name="id" value="${bean.id }"/>
     <section>
      <h2><strong style="color:grey;">公告信息修改</strong></h2>
      <ul class="ulColumn2">
      
       <li>
        <span class="item_name" style="width:120px;">公告标题：</span>
        <input type="text" name="biaoti"  id='biaotiid' value="${bean.biaoti}" class="textbox textbox_295" />
       </li>
       
       
        <li>
        <span class="item_name" style="width:120px;">公告内容：</span>
        <textarea name="content"  id="contentid"  class="textarea" style="width:500px;height:100px;">${bean.content}</textarea>
       </li>
       
       
     
       <li>
         <span class="item_name" style="width:120px;"></span>
          <input type="submit" value="提交" class="link_btn"/>
        <input type="button" onclick="javascript:history.go(-1);" value="返回" class="group_btn"/>
       </li>
       
       
      </ul>
     </section>
     </form>
     
     
    
   
 </div>
</section>
</body>
</html>
