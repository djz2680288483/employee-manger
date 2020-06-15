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
  		//設置請求參數以及響應對象的字符集
  		request.setCharacterEncoding("UTF-8");
  		response.setCharacterEncoding("UTF-8");
  		//從request屬性範圍中將error屬性取出
  		String error = (String) request.getAttribute("error");
  		//判斷error是否為null
  		if(error==null){
  			error = "";
  		}
  		
  		//獲取從瀏覽器中讀取的Cookie對象
  		Cookie[] cookies = request.getCookies();
  		//判斷取得Cookie的數組是否為null
  		if(cookies!=null){//判斷Cookie的數組不為null的時候，我們查詢是否存在用戶名以及密碼
  			//定義一個變量代表用戶名
  			String userid = "";
  			//定義一個變量代表密碼
  			String password = "";
  			//從Cookie數組中找打用戶名以及密碼
  			for(int i=0;i<cookies.length;i++){
  				if(cookies[i].getName().equals("userid")){
  					userid = cookies[i].getValue();
  				}else if(cookies[i].getName().equals("password")){
  					password = cookies[i].getValue();
  				}
  				
  			}
  			//判斷userid和password是否為空
  			if(!userid.trim().equals("")&&!password.trim().equals("")){
  				//從Cookie中找到userid以及password,需要創建一個User對象
  				User user = new User();
  				//對user設置userid屬性
  				user.setUserid(userid);
  				//定義一個輸入流對象
    			InputStream in = Resources.getResourceAsStream("SqlMapConfig.xml");
    			//創建SqlSessionFactory
    			SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
    			//創建SqlSession對象
    			SqlSession s1 = factory.openSession();
    			//獲取UserMapper的代理對象
    			UserMapper mapper = s1.getMapper(UserMapper.class);
    			//到數據庫中驗證輸入的userid和password是否正確
    			//到數據庫總查找user對象
    			user = mapper.selectUserById(user);
    			//關閉SqlSession對象
    			s1.close();
  				//判斷從數據庫中查詢的用戶是否存在
  				if(user!=null){//如果查詢的用戶存在
  					//判斷密碼是否正確
  					if(password.equals(user.getPassword())){
  						//需要將查詢的用戶存儲在session範圍中
  						session.setAttribute("user", user);
  						//將頁面跳轉到welcome.jsp
  						response.sendRedirect("selectEmp");
  					}
  				
  				}
  				
  			}
  		}
  	 %>
  
   <form action="check" method="post">
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
   				<td><input type="checkbox" name="remPass" value="remPass"/>記住密碼</td>
   				<td>
   					<select name="remTime">
   						<option value="">請選擇</option>
   						<option value="day">一天</option>
   						<option value="month">一個月</option>
   						<option value="year">一年</option>
   					</select>
   				</td>
   			</tr>
   			<tr>
   				<td colspan="2"><input type="submit" value="登錄"/></td>
   			</tr>
   		</table>
   </form>
  </body>
</html>
