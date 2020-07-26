<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
    <meta >
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/common.css">
    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/jquery.SuperSlide.2.1.js"></script>
    <script src="js/common.js"></script>
</head>
<body>
    
        <div class="header">
            <span style="font-size:50px;font-weight: bold;font-family:KaiTi;color: #2B6FD5; margin-left:36%;">
       MovieFans影吧
    </span>
            <div class="header-nav">
                <ul class="header-nav-list clearfix">
                    <li class="nav-one"><a href="indexmethod!index" class="nav-tit">首页</a> </li>
                    <li class="nav-one"><a href="indexmethod!dy_movielist" class="nav-tit">电影库</a></li>
                    <li class="nav-one"><a href="indexmethod!gf_movielist" class="nav-tit">高分电影</a></li>
                    <c:if test="${user!=null}">
                     <li class="nav-one"><a href="indexmethod!recommend" class="nav-tit">为你推荐</a> </li>
                     <li class="nav-one"><a href="indexmethod!recordslist" class="nav-tit">观影记录</a> </li>
                     <li class="nav-one"><a href="indexmethod!evaluatelist" class="nav-tit">我的影评</a> </li>
                    </c:if>
                   
                     
                    <li class="nav-one"><a href="indexmethod!sy_gonggaolist" class="nav-tit">系统公告</a> </li>
                    <li class="nav-one"></li>
                </ul>
            </div>
            <div class="header-search">
                <div class="header-search-input clearfix">
                 <form action="indexmethod!movielist" method="post" name='reqForm' >
                    <input name="biaoti" type="text"  value="${biaoti}" class="form-text-search"  placeholder="请输入电影名称" >
                    <input name="dao" type="text"  value="${dao }" class="form-text-search"  placeholder="请输入导演名" >
                    <a href="javascript:document.reqForm.submit();" class="search-submit"  id="search-submit"></a>
                    </form>
                </div>
                <div class="header-search-words">
                
                </div>
            </div>
        </div>
        
    
</body>
</html>
