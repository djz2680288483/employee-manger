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
    
    <title>My JSP 'addEmp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script>
		window.onload = function(){
			var btn_cancel = document.getElementById("btn_cancel");
			btn_cancel.onclick = function(){
				var f1 = document.getElementById("f1");
				f1.submit();
			}
			var btn_save = document.getElementById("btn_save");
			btn_save.onclick = function(){
				var ename = document.getElementById("ename").value;
				var job = document.getElementById("job").value;
				var sal = document.getElementById("sal").value;
				var comm = document.getElementById("comm").value;
				var flag = true;
				if(ename==''||job==''||sal==''||comm==''){
					alert("数据不能为空");
					flag=false;
				}else{
					var regx = /\d+\.\d{1,2}/g;
					if(!regx.test(sal)){
						alert("薪资的格式不正确");
						flag=false;
					}
					regx = /\d+\.\d{1,2}/g;
					if(!regx.test(comm)){
						alert("奖金的格式不正确");
						flag=false;
					}
				}
				
				if(flag==true){
					var f2 = document.getElementById("f2");
					f2.submit();
				}
				
			}
		}
	</script>
  </head>
  
  <body>
    <%
    	
    	
    		%>
    			<form action="operatorEmp" method="post" id="f2">
    			<table>
    				<input type="hidden" name="operator" value="add"/>
    				<tr>
    					<td>ename:</td>
    					<td><input type="text" name="ename" id="ename"/></td>
    				</tr>
    				<tr>
    					<td>job:</td>
    					<td><input type="text" name="job" id="job"/></td>
    				</tr>
    				<tr>
    					<td>sal:</td>
    					<td><input type="text" name="sal" id="sal"/></td>
    				</tr>
    				<tr>
    					<td>comm:</td>
    					<td><input type="text" name="comm" id="comm"/></td>
    				</tr>
    				<tr>
    					<td><input type="button" value="保存" id="btn_save"/></td>
    					<td>
    					
    					<input type="button" value="取消" id="btn_cancel"/>
    					
    					</td>
    				</tr>
    			
    			</table>
    		</form>
    		<form action="selectEmp" method="post" id="f1">
    		</form>
    		
  </body>
</html>
