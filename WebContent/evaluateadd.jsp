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
 <script language="javascript" type="text/javascript">

function checkform()
{
	 
	 if (document.getElementById('contentid').value=="")
	{
		alert("服务评价不能为空");
		return false;
	}

	return true;
}

</script>
</head>

<body>
<div class="wrapper">
	 <jsp:include page="top.jsp"></jsp:include>
	
	
	
	
	<div class="contenter clearfix">
		 <jsp:include page="left.jsp"></jsp:include>
		
		
		
		<div class="contenter-main">
			<div class="cur-pos-wrap">
				<p class="cur-pos">您当前所在的位置：<a>首页</a> &gt; <strong>评价</strong></p>
			</div>
			<div class="inside-contenter">
				<div class="contact-content">
					
				
						<form id="form-feedback" action="indexmethod!evaluateadd2" method="post" onsubmit="return checkform()" >
							<input type="hidden" name=id value="${bean.id }"/>
							
							<ul class="feedback-form-list">
								
								<li>
									<label class="title" for="fback-content">评分：</label>
									 <select style="width:100px;height:25px;" name="fen" id="fenid">
                                         <option value="5">5</option>
                                         <option value="4">4</option>
                                         <option value="3">3</option>
                                         <option value="2">2</option>
                                         <option value="1">1</option>
                                     </select>
								</li>
								
								<li>
									<label class="title" for="fback-content">评价：</label>
									<textarea name="content" id="contentid" class="form-textarea-normal" ></textarea>
								</li>
								
							</ul>
							
							<ul class="feedback-form-list">
							<li>
									<label class="title"></label><input style="width:80px; height:20px;" type="submit" name="submit"  value="提交"  />
								</li>
								</ul>
						</form>
				
				</div>
				
			</div>
		</div>
		
		
		
		 <jsp:include page="right.jsp"></jsp:include>
		
		
		
		
	</div>
	 <jsp:include page="down.jsp"></jsp:include>
</div>
</body>
</html>
