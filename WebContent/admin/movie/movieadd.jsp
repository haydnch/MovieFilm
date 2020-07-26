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
	<script language="javascript" type="text/javascript">
function checkform()
{
	if (document.getElementById('daoid').value=="")
	{
		alert("导演不能为空");
		return false;
	}	
	if (document.getElementById('categoryid').value=="")
	{
		alert("分类不能为空");
		return false;
	}	
	if (document.getElementById('biaotiid').value=="")
	{
		alert("电影名称不能为空");
		return false;
	}	
	if (document.getElementById('uploadfileid').value=="")
	{
		alert("图片不能为空");
		return false;
	}	
	
	
	return true;
}
</script>
</head>
<body>


<section class="rt_wrap content mCustomScrollbar">
 <div class="rt_content">

      
    <form action="method!movieadd2" method="post" onsubmit="return checkform()" enctype="multipart/form-data">	
     <section>
      <h2><strong style="color:grey;">电影信息添加</strong></h2>
      <ul class="ulColumn2">
      
       <li>
        <span class="item_name" style="width:120px;">分类：</span>
           <select  name="category" id="categoryid" class="select">
                   <option value="">--请选择--</option>
                   <option value="Action">Action</option>
                   <option value="Adventrue">Adventure</option>
                   <option value="Animation">Animation</option>
                   <option value="Children">Children</option>
                   <option value="Comedy">Comedy</option>
                   <option value="Documentary">Documentary</option>
                   <option value="Others">Others</option>
                 </select>
       </li>
       
       <li>
        <span class="item_name" style="width:120px;">电影名称：</span>
        <input type="text" name="biaoti"  id='biaotiid' class="textbox textbox_295" />
       </li>
       
       <li>
        <span class="item_name" style="width:120px;">导演：</span>
        <input type="text" name="dao"  id='daoid' class="textbox textbox_295" />
       </li>
       
       <li>
        <span class="item_name" style="width:120px;">演员表：</span>
        <input type="text" name="zhu"  id='zhuid' class="textbox textbox_295" />
       </li>
       
       
        <li>
        <span class="item_name" style="width:120px;">简介：</span>
        <textarea name="content"  id="contentid" placeholder="简介信息输入" class="textarea" style="width:500px;height:100px;"></textarea>
       </li>
       
       
       <li>
        <span class="item_name" style="width:120px;">电影图片：</span>
        <input  type="file"  name="uploadfile"  id="uploadfileid" class="textbox textbox_295" />
       </li>
       
     
       <li>
         <span class="item_name" style="width:120px;"></span>
          <input type="submit" value="提交" class="link_btn"/>
       <button class="link_btn" onclick="javascript:history.go(-1);">返回</button>
       </li>
       
       
      </ul>
     </section>
     </form>
     
     
    
   
 </div>
</section>
</body>
</html>
