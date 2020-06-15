<%@page import="com.oracle.po.EmpPage"%>
<%@page import="com.oracle.po.Emp"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="com.oracle.mapper.EmpMapper"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
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
    
    <title>My JSP 'selectEmpBykey.jsp' starting page</title>
    
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
  		String selectkey=request.getParameter("selectkey");
        String key=request.getParameter("key");
     if(selectkey==null||key==null||selectkey.trim().equals("")||key.trim().equals("")){
   %>
   <jsp:forward page="selectEmp.jsp"></jsp:forward>
   <%
       }else{
       
       InputStream inputstream=Resources.getResourceAsStream("SqlMapConfig.xml");
       SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(inputstream);
       SqlSession sess1=factory.openSession();
       EmpMapper
        mapper=sess1.getMapper(EmpMapper.class);
        List<Emp> emps=null;
        
         EmpPage ename=new EmpPage();
        
       if(selectkey.trim().equals("namekey")){
        ename.setEname("%"+key+"%");
       }else if(selectkey.trim().equals("jobkey")){
        ename.setJob("%"+key+"%");
       }
        String pn=request.getParameter("pageNum");
         int pageNum=1;
         int count=5;
         int totalPage=1;
         int total=0;
          if(selectkey.trim().equals("namekey")){
        total=mapper.selectnameCount(ename);
       }else if(selectkey.trim().equals("jobkey")){
        total=mapper.selectjobCount(ename);
       }
        
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
      }else if(pageNum>=totalPage){
      pageNum=totalPage;
      }
      ename.setPageNum((pageNum-1)*count);
      ename.setCount(count);
       if(selectkey.trim().equals("namekey")){
        emps=mapper.selectEmpByEname(ename);
       }else if(selectkey.trim().equals("jobkey")){
         emps=mapper.selectEmpByJob(ename);
       
       }
          request.setAttribute("emps",emps);
         request.setAttribute("pageNum",pageNum);
         request.setAttribute("totalPage",totalPage);
         request.setAttribute("selectkey",selectkey);
        request.setAttribute("key",key);
       sess1.close();
       }
   %><jsp:forward page="welcome11.jsp"></jsp:forward>
  </body>
</html>
