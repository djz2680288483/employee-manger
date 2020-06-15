 <%@page import="com.oracle.mapper.UserMapper"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.io.Resources"%>
<%@page import="java.io.InputStream"%>
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
    
    <title>My JSP 'login.jsp' starting page</title>
    
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
  		//设置请求参数以及响应对象的字符集
  		request.setCharacterEncoding("UTF-8");
  		response.setCharacterEncoding("UTF-8");
  		//从request属性范围中将error属性取出
  		String error = (String) request.getAttribute("error");
  		//判断error是否为null
  		if(error==null){
  			error = "";
  		}
  		
  		//获取从浏览器中请求的Cookie对象
  		Cookie[] cookies = request.getCookies();
  		//判断取得Cookie的数組是否为null
  		if(cookies!=null){//判断Cookie的数组不为null的時候，我們查询是否存在用户名以及密码
  			//定义一个变量代表用户名
  			String userid = "";
  			//定义一个变量代表密码
  			String password = "";
  			//从Cookie数组中找到用户名以及密码
  			for(int i=0;i<cookies.length;i++){
  				if(cookies[i].getName().equals("userid")){
  					userid = cookies[i].getValue();
  				}else if(cookies[i].getName().equals("password")){
  					password = cookies[i].getValue();
  				}
  				
  			}
  			//判断userid和password是否为空
  			if(!userid.trim().equals("")&&!password.trim().equals("")){
  				//从Cookie中找到userid以及password,需要创建一个User对象
  				User user = new User();
  				//对user设置userid属性
  				user.setUserid(userid);
  				//定义一个输入流对象
    			InputStream in = Resources.getResourceAsStream("SqlMapConfig.xml");
    			//创建SqlSessionFactory
    			SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
    			//创建SqlSession对象
    			SqlSession s1 = factory.openSession();
    			//获取UserMapper的代理对象
    			UserMapper mapper = s1.getMapper(UserMapper.class);
    			//到数据库中验证輸入的userid和password是否正确
    			//到数据库中查找user对象
    			user = mapper.selectUserById(user);
    			//关闭SqlSession对象
    			s1.close();
  				//判断从数据库中查询的用户是否存在
  				if(user!=null){//如果查询的用户存在
  					//判断密码是否正确
  					if(password.equals(user.getPassword())){
  						//需要将查询的用户存储在session范围中
  						session.setAttribute("user", user);
  						%>
  						<jsp:forward page="selectEmp.jsp"></jsp:forward>
  						
  						<%
  						
  					}
  				
  				}
  				
  			}
  		}
  	 %>
  
   <form action="check.jsp" method="post">
   		<table align="center">
   			<tr>
   				<td>userid：</td>
   				<td><input type="text" name="userid"/></td>
   				<td><font color="red"><%=error %></font></td>
   			</tr>
   			<tr>
   				<td>password：</td>
   				<td><input type="password" name="password"/></td>
   			</tr>
   			<tr>
   				<td><input type="checkbox" name="remPass" value="remPass"/>记住密码</td>
   				<td>
   					<select name="remTime">
   						<option value="">请选择</option>
   						<option value="day">一天</option>
   						<option value="month">一个月</option>
   						<option value="year">一年</option>
   					</select>
   				</td>
   			</tr>
   			<tr>
   				<td colspan="2"><input type="submit" value="登录"/></td>
   			</tr>
   		</table>
   </form>
  </body>
</html>
