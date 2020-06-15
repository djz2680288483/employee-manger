package com.oracle.servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.oracle.mapper.UserMapper;
import com.oracle.po.User;

public class CheckServlet extends HttpServlet {

	/**
		 * The doGet method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to get.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	/**
		 * The doPost method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to post.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//獲取提交的請求參數
    	String userid = request.getParameter("userid");
    	String password = request.getParameter("password");
    	String remPass = request.getParameter("remPass");
    	
    	
    	//判斷輸入的userid和password是否為null
    	if(userid==null||password==null){
    		//向request屬性範圍中存在一個屬性，屬性名叫做error，屬性值叫做請登錄
    		request.setAttribute("error", "请登录");
    		//由於是使用的request屬性範圍，那麼我們就必須使用服務器跳轉
    		request.getRequestDispatcher("login.jsp").forward(request, response);
    	}else if(userid.trim().equals("")||password.trim().equals("")){//判斷userid或者password是否是空字符串
    		//向request屬性範圍中存在一個屬性，屬性名叫做error，屬性值叫做請登錄
    		request.setAttribute("error", "用戶名或密碼不能為空");
    		//由於是使用的request屬性範圍，那麼我們就必須使用服務器跳轉
    		request.getRequestDispatcher("login.jsp").forward(request, response);
    	}else{//用戶名或密碼都不為空
    		//定義一個輸入流對象
    		InputStream in = Resources.getResourceAsStream("SqlMapConfig.xml");
    		//創建SqlSessionFactory
    		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
    		//創建SqlSession對象
    		SqlSession s1 = factory.openSession();
    		//獲取UserMapper的代理對象
    		UserMapper mapper = s1.getMapper(UserMapper.class);
    		//到數據庫中驗證輸入的userid和password是否正確
    		//創建一個User對象
    		User user = new User();
    		//只需要設置userid即可，我們只需要通過userid就能找到User，判斷userid是否存在
    		user.setUserid(userid);
    		//到數據庫總查找user對象
    		user = mapper.selectUserById(user);
    		//關閉SqlSession對象
    		s1.close();
    		//判斷查找的user對象是否為空
    		if(user==null){//如果查詢到的user是null，則證明輸入的userid不存在
    			//向request屬性範圍中存在一個屬性，屬性名叫做error，屬性值叫做請登錄
    			request.setAttribute("error", "用戶名不存在");
    			//由於是使用的request屬性範圍，那麼我們就必須使用服務器跳轉
    			request.getRequestDispatcher("login.jsp").forward(request, response);
    		}else{//如果user不為null,則證明Userid存在的，接下來我們需要判斷密碼
    			if(password.equals(user.getPassword())){//輸入的password與查詢到用戶的密碼一致
    				//获取HTTPSession对象
    				HttpSession session = request.getSession();
    				//需要判斷用戶是否選擇了記住密碼
    				if(remPass!=null&&remPass.equals("remPass")){//用戶選擇了記住密碼
    					//獲取用戶選擇的記住密碼的時間
    					String remTime = request.getParameter("remTime");
    					//定義一個變量代表用戶選擇的記住密碼的時間,記住密碼的時間需要轉換成描述
    					int time = 0;
    					//判斷用戶是否選擇了時間
    					if(remTime!=null&&!remTime.equals("")){
    						if(remTime.equals("day")){//判斷如果用戶選擇的是一天的時間，一天的秒數就是86400
    							time=86400;
    						}else if(remTime.equals("month")){//判斷如果用戶選擇的是一個月的時間，一天的秒數就是86400*30
    							time = 86400*30;
    						}else if(remTime.equals("year")){//判斷如果用戶選擇的是一年的時間，一天的秒數就是86400*365
    							time = 86400*365;
    						}
    					}
    					//向瀏覽器中保存Cookie
    					Cookie cookie1 = new Cookie("userid",userid);
    					Cookie cookie2 = new Cookie("password",password);
    					cookie1.setMaxAge(time);
    					cookie2.setMaxAge(time);
    					response.addCookie(cookie1);
    					response.addCookie(cookie2);
    				}
    				//需要將用戶的登錄信息，存儲在session範圍，方便其他的頁面進行登錄的驗證
    				session.setAttribute("user", user);
    				//跳轉到查询数据的JSP
    				response.sendRedirect("selectEmp");
    				
    				
    			}else{//輸入的password與查詢到用戶的密碼不一致
    				//向request屬性範圍中存在一個屬性，屬性名叫做error，屬性值叫做請登錄
    		request.setAttribute("error", "密码不正确");
    		//由於是使用的request屬性範圍，那麼我們就必須使用服務器跳轉
    		request.getRequestDispatcher("login.jsp").forward(request, response);
    			}
    		}
    		
    		
    		
    	}
	}

}
