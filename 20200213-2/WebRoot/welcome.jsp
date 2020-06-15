<%@page import="com.oracle.po.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'welcome.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <%
    	//设置请求与响应对象的字符集
    	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
    	//先从session中取得user的属性
    	User user = (User)session.getAttribute("user");
    	//判断从session范围中取出的user属性是否为null
    	if(user==null){//如果user为null则证明用户沒有进行过登录，需要跳转回登录页面
    		request.setAttribute("error", "请登录");
    		request.getRequestDispatcher("login.jsp").forward(request, response);
    	}else{
    		%>
    			欢迎<%=user.getName() %><a href="logout.jsp">退出</a>
    		<% 
    	}
     %>
  </body>
</html>
