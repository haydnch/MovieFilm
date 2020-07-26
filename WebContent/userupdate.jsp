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

   <title></title>
 </head>
 <body>
   <form action="indexmethod!userupdate2" method="post" onsubmit="return checkform()">
   <input type="hidden" name="id" value="${bean.id }"/>
  <div class="container">
    
     <div id="forms" class="mt10">
        <div class="box">
          <div class="box_border">
            <div class="box_top"><b class="pl15">用户信息修改</b></div>
            <div class="box_center">
             
               <table class="form_table pt15 pb15" width="100%" border="0" cellpadding="0" cellspacing="0">

                  <tr>
                  <td class="td_right">用户名:</td>
                  <td class="">
                  <input type="text" name="username" id="usernameid" readonly value="${bean.username }" class="input-text lh30" size="40">
                  </td>
                 </tr>
                 
                 
                 <tr>
                  <td class="td_right">密码:</td>
                  <td class="">
                  <input type="password" name="password" id="passwordid" value="${bean.password }" class="input-text lh30" size="40">
                  </td>
                 </tr>
                 
                  
                 
                
               
                 
                
                 
                   <tr>
                  <td class="td_right">性别:</td>
                  <td class="">
                  <span class="fl">
                  <select  name="sex" id="sexid"> 
                    <option value="男" <c:if test="${bean.sex=='男' }">selected</c:if>>男</option>
                    <option value="女" <c:if test="${bean.sex=='女' }">selected</c:if>>女</option>
                   </select>
                    </span> 
                  </td>
                 </tr>
                 
                
                   
                     <tr>
                  <td class="td_right">邮箱:</td>
                  <td class="">
                  <input type="text" name="email" id="emailid" value="${bean.email }" class="input-text lh30" size="40">
                  </td>
                 </tr>  
                 
                 <%--  <tr>
                  <td class="td_right">喜好:</td>
                  <td class="">
                  <input type="text" readonly value="${bean.likes}" class="input-text lh30" size="40">
                  </td>
                 </tr>   --%>

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
	
	

	var phone =  document.getElementById('phoneid').value;
	   if(!(/^1[34578]\d{9}$/.test(phone))){
	    alert("手机号码填写错误");
	    return false;
	   }	
	   if(document.getElementById('phoneid').value.length!=11){
	    alert("电话必须为11位 ");
	    return false;
	   }
  
	if(document.getElementById('addressid').value==""){
    alert("地址不能为空 ");
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
  