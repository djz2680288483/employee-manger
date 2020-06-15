 <%@page import="com.oracle.po.User"%>
<%@page import="com.oracle.mapper.UserMapper"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.io.Resources"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'check.jsp' starting page</title>
    
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
    	//获取提交的请求参数
    	String userid = request.getParameter("userid");
    	String password = request.getParameter("password");
    	String remPass = request.getParameter("remPass");
    	
    	
    	//判断输入的userid和password是否为null
    	if(userid==null||password==null){
    		//向request属性范围中存在一个属性，属性名叫做error，属性值叫做请登录
    		request.setAttribute("error", "请登录");
    		//由于是使用的request属性范围，那么我们就必须使用服务器跳转
    		request.getRequestDispatcher("login.jsp").forward(request, response);
    	}else if(userid.trim().equals("")||password.trim().equals("")){//判断userid或者password是否是空字符串
    		//向request属性范围中存在一个属性，属性名叫做error，属性值叫做请登录
    		request.setAttribute("error", "用户名或密码不能为空");
    		//由于是使用的request属性范围，那么我们就必须使用服务器跳转
    		request.getRequestDispatcher("login.jsp").forward(request, response);
    	}else{//用户名或密码都不为空
    		//定义一个输入流对象
    		InputStream in = Resources.getResourceAsStream("SqlMapConfig.xml");
    		//创建SqlSessionFactory
    		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
    		//创建SqlSession对象
    		SqlSession s1 = factory.openSession();
    		//获取UserMapper的代理对象
    		UserMapper mapper = s1.getMapper(UserMapper.class);
    		//到数据库中验证输入的userid和password是否正确
    		//创建一个User对象
    		User user = new User();
    		//只需要设置userid即可，我们只需要通过userid就能找到User，判断userid是否存在
    		user.setUserid(userid);
    		//到数据库中查找user对象
    		user = mapper.selectUserById(user);
    		//关闭SqlSession对象
    		s1.close();
    		//判断查找的user对象是否为空
    		if(user==null){//如果查询到的user是null，则证明输入的userid不存在
    			//向request属性范围中存在一个属性，属性名叫做error，属性值叫做请登录
    			request.setAttribute("error", "用户名不存在");
    			//由于是使用的request属性范围，那么我们就必须使用服务器跳转
    			request.getRequestDispatcher("login.jsp").forward(request, response);
    		}else{//如果user不为null,则证明Userid存在的，接下來我們需要判断密码
    			if(password.equals(user.getPassword())){//输入的password与查询到用户的密码一致
    				//需要判断用户是否选择了记住密码
    				if(remPass!=null&&remPass.equals("remPass")){//用户选择了记住密码
    					//获取用户选择的记住密码的时间
    					String remTime = request.getParameter("remTime");
    					//定义一个变量代表用户选择的记住密码的时间,记住密码的时间需要转换成描述
    					int time = 0;
    					//判断用户是否选择了时间
    					if(remTime!=null&&!remTime.equals("")){
    						if(remTime.equals("day")){//判断如果用户选择的是一天的时间，一天的秒数就是86400
    							time=86400;
    						}else if(remTime.equals("month")){//判断如果用户选择的是一个月的时间，一天的秒数就是86400*30
    							time = 86400*30;
    						}else if(remTime.equals("year")){//判断如果用户选择的是一年的时间，一天的秒数就是86400*365
    							time = 86400*365;
    						}
    					}
    					//向浏览器中保存Cookie
    					Cookie cookie1 = new Cookie("userid",userid);
    					Cookie cookie2 = new Cookie("password",password);
    					cookie1.setMaxAge(time);
    					cookie2.setMaxAge(time);
    					response.addCookie(cookie1);
    					response.addCookie(cookie2);
    				}
    				//需要將用户的登录信息，存储在session范围，方便其他的页面进行登录的验证
    				session.setAttribute("user", user);
    				//跳转到数据页面
    				response.sendRedirect("selectEmp.jsp");
    				
    				
    			}else{//输入的password与查询到用户的密码不一致
    				//向request属性范围中存在一个属性，属性名叫做error，属性值叫做请登录
    		request.setAttribute("error", "密码不正确");
    		//由于是使用的request属性范围，那么我们就必须使用服务器跳转
    		request.getRequestDispatcher("login.jsp").forward(request, response);
    			}
    		}
    	}
     %>
  </body>
</html>
