<%@page import="com.oracle.po.Emp"%>
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
        request.setCharacterEncoding("UTF-8");
  		response.setCharacterEncoding("UTF-8");
  		List<Emp> emps=(List<Emp>)request.getAttribute("emps");
  		int totalPage=(Integer)request.getAttribute("totalPage");
  		int pageNum=(Integer)  request.getAttribute("pageNum");
  		if(emps==null){
  		%>
  		<jsp:forward page="login.jsp">
        <jsp:param value="请登录" name="error"/>
        </jsp:forward>
  		<%
  		}else{
  		%>
  		<table border="1" align="center">
  		
  		<tr align="center">
  		<td colspan="6" align="center">
  		<form action="selectEmpBykey.jsp" method="post">
  		<select name="selectkey">
  		<option value="namekey"> 按照姓名模糊查询 </option>
  		<option value="jobkey"> 按照职位模糊查询 </option>
  		<input type="text" name="key">  </input>
  		<input type="submit" value="查询">  </input>
  		</select></form>
  		
  		</td>
  		
  		</tr>
  	     <tr>
    	<td colspan="6">
    	<a href="addEmp.jsp">添加员工</a>
    	</td>
    			</tr>
  		<tr>
  		<th>  员工的编号</th>
  		<th>  员工的姓名</th>
  		<th>  员工的职业</th>
  		<th>  员工的工资</th>
  		<th>  员工的奖金</th>
  		<th>  操作</th>
  		</tr>
  	<% 
  	for(int i=0;i<emps.size();i++){
  	Emp e=emps.get(i);
  	%>
  		<tr>
  		<td> <%=e.getEmpno() %></td>
  		<td> <%=e.getEname() %></td>
  		<td> <%=e.getJob() %></td>
  		<td> <%=e.getSal() %></td>
  		<td> <%=e.getComm() %></td>
  		<td><a href="operatorEmp?operator=update&empno=<%=e.getEmpno()%>"  value="修改">修改</a>
  		/<a href="operatorEmp?operator=delete&empno=<%=e.getEmpno()%>"  value="删除">删除</a></td>
  		</tr>
  			<%
  		}
    %><tr align="center">
    <td  colspan="6">
      <a href="selectEmp.jsp?pageNum=1">首页</a>
      <a href="selectEmp.jsp?pageNum=<%=pageNum-1 %>">上一页</a>
      <a href="selectEmp.jsp?pageNum=<%=pageNum+1 %>">下一页</a>
       <a href="selectEmp.jsp?pageNum=<%=totalPage %>">尾页</a>
    </td>
    
    </tr>
  		</table>
  		<%
  		}
  	
  		%>
  </body>
</html>
