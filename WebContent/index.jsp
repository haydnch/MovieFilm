<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();

%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/common.css">
    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/jquery.SuperSlide.2.1.js"></script>
    <script src="js/common.js"></script>



</head>

   <%
   	org.springframework.web.context.WebApplicationContext app = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
      dao.MovieDao movieDao = (dao.MovieDao)app.getBean("movieDao");
      List<model.Movie> list = movieDao.selectBeanList(0,8," where movielock=0  order by createtime desc");

   %>

<body>
    <div class="wrapper">
         <jsp:include page="top.jsp"></jsp:include>
        
        <div class="contenter clearfix">
            <jsp:include page="left.jsp"></jsp:include>
            
            <div class="contenter-main">
                <div class="column-one-wrap">
                    <div class="index-banner">
                        <div class="banner-pics">
                            <ul class="banner-pics-list clearfix">
                                <li><a ><img src="images/pic_banner_1.jpg"></a></li>
                                <li><a ><img src="images/pic_banner_2.jpg"></a></li>
                                <li><a ><img src="images/pic_banner_3.jpg"></a></li>
                            </ul>
                        </div>
                        <div class="banner-tit clearfix">
                        </div>
                    </div>
                    <script type="text/javascript">
                        jQuery(".index-banner").slide({ mainCell: ".banner-pics-list", titCell: ".banner-tit", autoPlay: true, effect: "fold", autoPage: true })
				</script>
                </div>
                 
                <div class="column-one-wrap">
                    <div class="common-col-tit">
                        <h3 class="title"> 最新电影</h3>
                    </div>
                    <div class="common-col-cont">
                        <div class="pros-loop">
                            <div class="pros-loop-pics">
                                <ul class="pros-loop-pics-list clearfix">
                                 <%
                                 	for(model.Movie bean:list){
                                 %>
                                    <li><a href="indexmethod!xq_movie?id=<%=bean.getId() %>"> <img src="<%=basePath %>/temp/<%=bean.getImgpath() %>"></a></li>
                                 <% 
                                   }
                                  %>    
                                    
                                   
                                </ul>
                            </div>
                            <div class="pros-loop-turn">
                                <a href="javascript:void(0);" class="turn-btn turn-prev"></a><a href="javascript:void(0);"
                                    class="turn-btn turn-next"></a>
                            </div>
                        </div>
                        <script type="text/javascript">
                            jQuery(".pros-loop").slide({ mainCell: ".pros-loop-pics-list", prevCell: ".turn-prev", nextCell: ".turn-next", effect: "left", vis: 4, scroll: 1, autoPlay: true, autoPage: true })
                        </script>
                    </div>
                </div>
            </div>
            
            
            
              <jsp:include page="right.jsp"></jsp:include>
            
            
            
        </div>
        
        <jsp:include page="down.jsp"></jsp:include>
     
    </div>
</body>
</html>
