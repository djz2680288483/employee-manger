<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>员工列表</title>
    <!-- 关于web路径的问题
    不一/开始的路径，是以当前资源路径做为基准，经常出现问题
    以/开始的路径，是以服务器的路径作为基准的，就是以http://localhost:8080为基准
    我们使用的路径的时候需要添加项目名/资源名
     -->
   <!-- 引入JQuery的文件 -->
   <%
String path = request.getContextPath();
pageContext.setAttribute("app_path",path);
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script src="${app_path}/static/js/jquery.js"></script>
	<!-- 引入BootStrap的CSS文件 -->
	<link rel="stylesheet" href="${app_path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
	<!-- 引入BootStrap的JS文件 -->
	<script src="${app_path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>
  
  <body>
   <div class=".container">
   <!-- 标题 -->
   <div class="row">
  <div class="col-md-12">
  <h1>SSS-CURD</h1>
  </div></div>
   <!-- 新建与删除的按钮 -->
   <div class="row">
  <div class="col-md-4 col-md-offset-8">
  <button type="button" class="btn btn-primary">新建</button>
  <button type="button" class="btn btn-danger">删除</button>
  </div></div>
   <!-- 显示员工的数据-->
    <div class="row">
  <div class="col-md-12 ">
  <table class="table">
  <tr>
  <th>员工的编号 </th>
   <th> 员工的姓名</th>
   <th>员工的性别 </th>
   <th>员工的邮箱 </th>
     <th> 员工的部门</th>
     <th> 操作</th>
  </tr>
  <!-- 遍历传递过来的员工的数据-->
  <c:forEach items="${pageinfo.list}" var="emp">
       <tr>
    <th>${emp.empId} </th>
    <th> ${emp.empName}</th>
    <th>${emp.gender=="M"?"男":"女"} </th>
    <th>${emp.email} </th>
    <th> ${emp.department.deptName}</th>
    <th> 
   <button type="button" class="btn btn-primary">
    <span class="glyphicon glyphicon-pencil" aria-hidden="true">编辑</span></button>
   <button type="button" class="btn btn-primary">
   <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span></button>
    </th>
  </tr>
  </c:forEach>
</table>
  </div></div>
   <!-- 显示分页的数据 -->
   <div class="row">
   <!-- 分页的文字信息 -->
  <div class="col-md-6">
    当前第：${pageinfo.pageNum } 页，总共有${pageinfo.pages } 页,总记录数：${pageinfo.total}
  </div>
  <!-- 分页条 -->
  <div class="col-md-6">
   <nav aria-label="Page navigation">
  <ul class="pagination">
  <c:if test="${pageinfo.pageNum==1 }">
    <li class="disabled"><a href="#" >首页</a></li>
  
  </c:if>
  <c:if test="${pageinfo.pageNum!=1 }">
    <li ><a href="${app_path}/emps?pn=1" >首页</a></li>
  
  </c:if>
  
   <c:if test="${pageinfo.hasPreviousPage }">
    <li ><a href="${app_path }/emps?pn=${pageinfo.pageNum-1}" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
   </c:if>
   <c:forEach items="${pageinfo.navigatepageNums }" var="pageNum">
   <c:if test="${pageNum==pageinfo.pageNum }">
    <li class="active"><a href="#">${pageinfo.pageNum } </a></li>
   </c:if>
   <c:if test="${pageNum!=pageinfo.pageNum }">
   <li ><a href="${app_path}/emps?pn=${pageNum}">${pageNum} </a></li>
   </c:if>
   </c:forEach>
   <c:if test="${pageinfo.hasNextPage }">
   <li ><a href="${app_path }/emps?pn=${pageinfo.pageNum+1}" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
   </c:if>
   <c:if test="${pageinfo.pageNum==pageinfo.pages }">
   <li class="disabled" ><a href="#" aria-label="Next"><span aria-hidden="true">尾页</span></a></li>
   </c:if>
   
    <c:if test="${pageinfo.pageNum!=pageinfo.pages }">
   <li ><a href="${app_path }/emps?pn=${pageinfo.pages}" aria-label="Next"><span aria-hidden="true">尾页</span></a></li>
   </c:if>
  </ul>
</nav> 
  </div>
  </div>
   
   
   </div>
  </body>
</html>
