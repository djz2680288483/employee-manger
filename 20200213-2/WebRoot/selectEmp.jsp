<%@page import="com.oracle.po.User"%>
<%@page import="com.oracle.po.Emp"%>
<%@page import="com.oracle.po.EmpPage"%>
<%@page import="com.oracle.mapper.EmpMapper"%>
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
    
    <title>My JSP 'selectEmp.jsp' starting page</title>
    
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
          request.setCharacterEncoding("UTF-8");
  		  response.setCharacterEncoding("UTF-8");
  		  String pn=request.getParameter("pageNum");
  		  User user=(User)session.getAttribute("user");
  		  if(user==null){
  		  request.setAttribute("error","请登录");
  		  
  		  request.getRequestDispatcher("login.jsp").forward(request,response);
  		  
  		  }else{
         int pageNum=1;
         int count=5;
         InputStream inputstream=Resources.getResourceAsStream("SqlMapConfig.xml");
       SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(inputstream);
       SqlSession sess1=factory.openSession();
       EmpMapper mapper=sess1.getMapper(EmpMapper.class);
       int total=mapper.selectTotal();
       int totalPage=1;
       if(total%count==0){
       totalPage=total/count;
       }else{
       totalPage=total/count+1;
       }
       if(pn!=null){
        if(pn.matches("\\d+")){
       pageNum=Integer.parseInt(pn);
       
       }
       }
      if(pageNum<1){
      pageNum=1;
      }else if(pageNum>totalPage){
      pageNum=totalPage;
      }
      
       EmpPage user1=new EmpPage();
          user1.setCount(count);
          user1.setPageNum((pageNum-1)*count);
          List<Emp> lists=mapper.selectEmpByPage(user1);
        sess1.close();
         request.setAttribute("emps", lists);
         request.setAttribute("pageNum", pageNum);
         request.setAttribute("totalPage",totalPage);}
    %>
    	<jsp:forward page="welcome1.jsp"/>
  </body>
</html>
