<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

 <!doctype html>
 <html lang="zh-CN">
 <head>
  
    <link rel="stylesheet" href="css/common.css">
   <link rel="stylesheet" href="css/main.css">
   <script type="text/javascript" src="js/jquery.min.js"></script>
   <script type="text/javascript" src="js/colResizable-1.3.min.js"></script>
   <script type="text/javascript" src="js/common.js"></script>
   <script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
   
   <script type="text/javascript">
      $(function(){  
        $(".list_table").colResizable({
          liveDrag:true,
          gripInnerHtml:"<div class='grip'></div>", 
          draggingClass:"dragging", 
          minWidth:30
        }); 
        
      }); 
   </script>
   <script language="javascript" type="text/javascript" src="../js/jquery.min.js"></script>
<script language="javascript" type="text/javascript">
 function add_words()
{
	
 var valus = documnet.getElementsByName("likes");
  if(valus.length!=0)
  {
  var str = "";
  for(var i=0;i<valus.length;i++)  
  {
  if(valus[i].checked)
  {
  str+= valus[i].value;
  }
}
</script>
   <title></title>
 </head>
 <body>
  <form action="indexmethod!register" method="post"  onsubmit="return checkform()">
  <div class="container">
    
     <div id="forms" class="mt10">
        <div class="box">
          <div class="box_border">
            <div class="box_top"><b class="pl15">用户注册</b></div>
            <div class="box_center">
             
               <table class="form_table pt15 pb15" width="100%" border="0" cellpadding="0" cellspacing="0">

                  <tr>
                  <td class="td_right">用户名:</td>
                  <td class="">
                  <input type="text" name="username" id="usernameid" class="input-text lh30" size="40">
                  </td>
                 </tr>
                 
               
                 <tr>
                  <td class="td_right">密码:</td>
                  <td class="">
                  <input type="password" name="password" id="passwordid" class="input-text lh30" size="40">
                  </td>
                 </tr>
                 
                  <tr>
                  <td class="td_right">确认密码:</td>
                  <td class="">
                  <input type="password"  id="password2id" class="input-text lh30" size="40">
                  </td>
                 </tr>
                 
                 
                
                 
                   <tr>
                  <td class="td_right">性别:</td>
                  <td class="">
                  <span class="fl">
                  <select  name="sex" id="sexid"> 
                    <option value="男">男</option>
                    <option value="女">女</option>
                   </select>
                    </span> 
                  </td>
                 </tr>
                 
          
                
                  
                   
                 <tr>
                  <td class="td_right">邮箱:</td>
                  <td class="">
                  <input type="text" name="email" id="emailid" class="input-text lh30" size="40">
                  </td>
                 </tr>  
                 
                 
                   <tr>
                  <td class="td_right">喜好:</td>
                  <td class="">
                  <input type="checkbox" name="likes" id="likes" value="Action">Action
                   <input type="checkbox" name="likes" id="likes" value="Animation">Animation
                    <input type="checkbox" name="likes" id="likes" value="Adventure">Adventure
                     <input type="checkbox" name="likes" id="likes" value="Children">Children
                      <input type="checkbox" name="likes" id="likes" value="Comedy">Comedy
                       <input type="checkbox" name="likes" id="likes" value="Documentary">Documentary
                       <br/>
                        <input type="checkbox" name="likes" id="likes" value="Crime">Crime
                   <input type="checkbox" name="likes" id="likes" value="Drama">Drama
                    <input type="checkbox" name="likes" id="likes" value="Fantasy">Fantasy
                     <input type="checkbox" name="likes" id="likes" value="Film-Noir">Film-Noir
                      <input type="checkbox" name="likes" id="likes" value="Horror">Horror
                       <input type="checkbox" name="likes" id="likes" value="Musical">Musical
                       <br/>
                        <input type="checkbox" name="likes" id="likes" value="Mystery">Mystery
                   <input type="checkbox" name="likes" id="likes" value="Romance">Romance
                    <input type="checkbox" name="likes" id="likes" value="Sci-Fi">Sci-Fi
                     <input type="checkbox" name="likes" id="likes" value="Thriller">Thriller
                      <input type="checkbox" name="likes" id="likes" value="War">War
                       <input type="checkbox" name="likes" id="likes" value="Western">Western
                       <br/>
                  </td>
                 </tr>  
                 
                 

                 <tr>
                   <td class="td_right">&nbsp;</td>
                   <td class="">
                     <input type="submit" name="submit" class="btn btn82 btn_save2" value="保存"> 
                    <input type="reset"  class="btn btn82 btn_res" value="重置"> 
                   </td>
                 </tr>
               </table>
               
            </div>
          </div>
        </div>
     </div>
   </div> 
   </form>
 </body>
 <script language="javascript" type="text/javascript">

function checkform()
{
	 
	 if (document.getElementById('usernameid').value=="")
	{
		alert("用户名不能为空");
		return false;
	}

	if (document.getElementById('passwordid').value=="")
	{
		alert("密码不能为空");
		return false;
	}
	if (document.getElementById('passwordid').value.length<6)
	{
		alert("密码长度必须大于6位");
		return false;
	}
	if (document.getElementById('password2id').value != document.getElementById('passwordid').value)
	{
		alert("确认密码与密码不一致");
		return false;
	}	 
	
	
	/* var phone =  document.getElementById('phoneid').value;
   if(!(/^1[34578]\d{9}$/.test(phone))){
    alert("手机号码填写错误");
    return false;
   }	
   if(document.getElementById('phoneid').value.length!=11){
    alert("电话必须为11位 ");
    return false;
   } */
  
	/* if(document.getElementById('addressid').value==""){
    alert("地址不能为空 ");
    return false;
   }	
 */
  
   if(document.getElementById("emailid").value==""){
		
		alert('email不能为空');
		return false;
	}
	
	var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
	
	if(!reg.test(document.getElementById("emailid").value)){
		
		alert('请输入正确的邮箱地址');
		return false;
	}
	
	return true;
}
 

</script>
 </html>
  