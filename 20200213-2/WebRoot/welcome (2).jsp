<%@page import="com.oracle.po.Emp"%>
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
    	//設置請求與響應對象的字符集
    	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
    	//先從session中取得user的屬性
    	User user = (User)session.getAttribute("user");
    	//获取当前页数
    	int pageNum = 1;
    	int totalPage = 1;
    	
    		%>
    			<table border="1" align=center>
    			<tr align="center">
    				<td colspan="6">歡迎<%=user.getName() %><a href="logout">登出</a></td>
    			</tr>
    			<tr>
    				<td colspan="6">
    					<a href="addEmp.jsp">添加员工</a>
    				</td>
    			</tr>
    			<tr>
    				<th>员工的编号</th>
    				<th>员工的姓名</th>
    				<th>员工的职位</th>
    				<th>员工的薪资</th>
    				<th>员工的奖金</th>
    				<th>操作</th>
    			</tr>
    			
    		<% 
    		//获取当前页数
    		pageNum = (Integer)request.getAttribute("pageNum");
    		totalPage = (Integer)request.getAttribute("totalPage");
    		//获取传递过来的员工的集合
    		List<Emp> emps = (List<Emp>)request.getAttribute("emps");
    		//判断传递过来的集合是否为null
    		if(emps!=null){//如果传递过来的集合不为null
    			for(int i=0;i<emps.size();i++){
    				Emp emp = emps.get(i);
    				%>
    					<tr>
    						<td><%=emp.getEmpno() %></td>
    						<td><%=emp.getEname() %></td>
    						<td><%=emp.getJob() %></td>
    						<td><%=emp.getSal() %></td>
    						<td><%=emp.getComm() %></td>
    						<td><a href="operatorEmp?operator=update&empno=<%=emp.getEmpno()%>">修改</a>/<a href="operatorEmp?operator=delete&empno=<%=emp.getEmpno()%>">删除</a></td>
    					</tr>
    				<% 
    			}
    		}
    	
     %>
     					<tr align="center">
     						<td colspan="6">
     							<a href="selectEmp?pageNum=1">首页</a>
     							<a href="selectEmp?pageNum=<%=pageNum-1%>">上一页</a>
     							<a href="selectEmp?pageNum=<%=pageNum+1%>">下一页</a>
     							<a href="selectEmp?pageNum=<%=totalPage%>">尾页</a>
     						</td>
     					</tr>
     </table>
  </body>
</html>
