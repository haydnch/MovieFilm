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
	 a:link{color:blue;}
	 a:visited {color: blue}	/* 已访问的链接 */
	 a:hover{color:red;}
</style>
</head>

   <%
   	org.springframework.web.context.WebApplicationContext app = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
      dao.MovieDao movieDao = (dao.MovieDao)app.getBean("movieDao");
      List<model.Movie> list = movieDao.selectBeanList(0,10," where zong>=3 and ratedNum>=100 and movielock=0  order by zong desc ");
   %>

<body>
    <div class="wrapper">
        
       
            
           
            <div class="sidebar-service">
                <div class="column-one-wrap">
                    <div class="common-col-tit">
                        <h3 class="title"> 用户登录</h3>
                    </div>
                    <div class="sidebar-contact-mess">
                        <div class="contact-way">
                     <!-- 登录模块 -->    
                           <c:if test="${user==null}">
       <form action="indexmethod!login" method="post" onsubmit="return checkform()" > 
          <h3> 用户名：<input type="text" name="username" size="15" id="usernameid" /> </h3><br/>
         <h3>  密&nbsp;&nbsp;&nbsp;码：<input type="password" name="password" size="15" id="passwordid" /> </h3><br/>
         
          <input style="width:80px; height:25px;" type="submit" name="submit"  value="登陆"  />  
          <input style="width:80px; height:25px;" type="reset" name="reset"  value="重置"  />  <br/>
          
             <a href="javascript:;" onClick="javascript:window.open('register.jsp','','width=500,height=400,left=590, top=350,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;">新用户注册</a>
         </form> 
         </c:if>
         
         
          <!-- 已登录模块 -->
            <br/>
        <c:if test="${user!=null  }">
            <form action="indexmethod!loginout" method="post"  >
          <h4> 当前用户：${user.username }  </h4>
          <br/>
         <h4> 当前状态：<font color="green">登录中</font></h4>
          <br/>
         <input style="width:190px; height:25px;" type="submit" name="submit"  value="退出"  />
          <a href="javascript:;" onClick="javascript:window.open('indexmethod!userupdate?id=${user.id }','','width=460,height=460,left=550, top=350,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;">个人信息修改</a> 
           </form>   
           </c:if>
         
         
                        </div>
                        
                       
                    </div>
                </div>
                <div class="column-one-wrap">
                    <div class="common-col-tit">
                        <h3 class="title">热门电影</h3>
                        <a href="indexmethod!gf_movielist" class="see-more">更多&gt;&gt;</a>
                    </div>
                    <div class="news-list ellipsis-list">
                    <%
                    	for(model.Movie bean:list){
                    %>
                       <li><a href="indexmethod!xq_movie?id=<%=bean.getId() %>"><%=bean.getBiaoti() %></a><span class="time"><%=bean.getZong() %></span></li>
                       <% 
                          }
                      %> 
                    </div>
                </div>
            </div>
        </div>
        
        
        
       
   
</body>
</html>
