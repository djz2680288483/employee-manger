package com.oracle.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.oracle.mapper.EmpMapper;
import com.oracle.po.Emp;
import com.oracle.po.EmpPage;

public class SelectEmpServlet extends HttpServlet {

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

		//接收传递过来的页面的参数
		String pn = request.getParameter("pageNum");
		
		
		//定义一个变量代表当前的页数
		int pageNum=1;
		//定义一个变量代表每一页显示的数量
		int count=3;
		
		//判断传递过来的页数的格式
		if(pn!=null){
    		if(pn.matches("\\d+")){//页数的格式是由数字组成的
    			pageNum = Integer.parseInt(pn);
    		}
		}
		
		//创建SqlSessionFactory对象
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(Resources.getResourceAsStream("SqlMapConfig.xml"));
		//创建SqlSession对象
		SqlSession s1 = factory.openSession();
		//获取EmpMapper的代理对象
		EmpMapper empMapper = s1.getMapper(EmpMapper.class);
		//定义一个变量代表总页数
		int totalPage = 0;
		//定义一个变量代表总数
		int total = 0;
		//通过查询获取数据的总数
		total = empMapper.selectEmpCount();
		//判断总数对于每一个显示的数量取余是否为0
		if(total%count==0){
			totalPage = total/count;
		}else{
			totalPage = total/count+1;
		}
		//判断当前的页数
		if(pageNum<1){
			pageNum=1;
		}else if(pageNum>totalPage){
			pageNum=totalPage;
		}
		
		//创建一个EmpPage对象
		EmpPage ep = new EmpPage();
		//设置当前的页数以及每一页显示的数量
		ep.setPageNum((pageNum-1)*count);
		ep.setCount(count);
		
		//执行查询的操作
		List<Emp> emps = empMapper.selectEmpByPage(ep);
		
		//关闭SqlSession对象
		s1.close();
		
		//将查询出来的集合数据设置到request属性范围中
		request.setAttribute("emps", emps);
		//将当前页数和总页数设置到request属性范围中
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPage", totalPage);
		
		//使用服务器跳转到welcome.jsp
		request.getRequestDispatcher("welcome.jsp").forward(request, response);
	}

}
