<%@ page language="java" import="java.util.*,model.Manage" pageEncoding="UTF-8"%>
<% 
Manage manage = (Manage) session.getAttribute("manage");
if (manage==null){
	response.sendRedirect("login.jsp"); 
	return;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<HTML>
<HEAD>
<TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Cache-Control content=no-cache>
<META http-equiv=Expires content=-1000>
<LINK href="css/admin.css" type="text/css" rel="stylesheet">
</HEAD>
<FRAMESET border=0 frameSpacing=0 rows="60, *" frameBorder=0>
<FRAME name=header src="head.jsp" frameBorder=0 noResize scrolling=no>
<FRAMESET cols="240, *">
<FRAME name=menu src="menu.jsp" frameBorder=0 noResize>
<FRAME name=main src="main.jsp" frameBorder=0 noResize >
</FRAMESET>
</FRAMESET>
<noframes>
</noframes>
</HTML>

