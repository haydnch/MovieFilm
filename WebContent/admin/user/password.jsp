<%@ page language="java" import="java.util.*,model.Manage" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% 
	Manage manage = (Manage) session.getAttribute("manage");
 	String  opd=manage.getPassword();

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
<script language="javascript" type="text/javascript">


function checkform()
{
	if (document.getElementById('password1id').value=="")
	{
		alert("原密码不能为空");
		return false;
	}
	if (document.getElementById('password2id').value=="")
	{
		alert("新密码不能为空");
		return false;
	}
	
	if (document.getElementById('password2id').value.length<6)
	{
		alert("新密码长度必须大于6位");
		return false;
	}
	if (document.getElementById('password2id').value != document.getElementById('password3id').value)
	{
		alert("新密码与新密码确认不一致");
		return false;
	}	 
	return true;
	
}
</script>
</head>
<body>


<section class="rt_wrap content mCustomScrollbar">
 <div class="rt_content">

      
    <form action="method!changepwd2" method="post" onsubmit="return checkform()">
     <section>
      <h2><strong style="color:grey;">密码修改</strong></h2>
      <ul class="ulColumn2">
      
       <li>
        <span class="item_name" style="width:120px;">原密码：</span>
        <input type="password" name="password1"  id='password1id' class="textbox textbox_295" />
       </li>
       
        <li>
        <span class="item_name" style="width:120px;">新密码：</span>
        <input type="password" name="password2"  id='password2id' class="textbox textbox_295" />
       </li>
       
        <li>
        <span class="item_name" style="width:120px;">确认密码：</span>
        <input type="password" name="password3"  id='password3id' class="textbox textbox_295" />
       </li>
       
     
       <li>
         <span class="item_name" style="width:120px;"></span>
          <input type="submit" value="提交" class="link_btn"/>
          <input type="button" class="link_btn" onclick="javascript:history.go(-1);" value="返回">
       </li>
       
       
      </ul>
     </section>
     </form>
     
     
    
   
 </div>
</section>
</body>
</html>
