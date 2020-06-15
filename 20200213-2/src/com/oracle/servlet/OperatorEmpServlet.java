package com.oracle.servlet;

import java.io.IOException;

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

public class OperatorEmpServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//接收传递过来的参数
		String operator = request.getParameter("operator");
		//创建SqlSessionFactory
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(Resources.getResourceAsStream("SqlMapConfig.xml"));
		//创建Sqlsession
		SqlSession s1 = factory.openSession();
		//获取EmpMapper
		EmpMapper empMapper = s1.getMapper(EmpMapper.class);
		//判断operator的值
		if(operator.equals("add")){
			//获取传递过来的参数
			String ename = request.getParameter("ename");
			String job = request.getParameter("job");
			String s = request.getParameter("sal");
			String c = request.getParameter("comm");
			//定义一个变量代表员工的工资
			double sal = Double.parseDouble(s);
			double comm = Double.parseDouble(c);
			//创建员工对象
			Emp emp = new Emp();
			emp.setEname(ename);
			emp.setComm(comm);
			emp.setJob(job);
			emp.setSal(sal);
			//向数据库添加数据
			empMapper.insertEmp(emp);
			s1.commit();
			s1.close();
			response.sendRedirect("selectEmp");
		}else if(operator.equals("update")){
			//接受请求参数
			String eno = request.getParameter("empno");
			int empno = Integer.parseInt(eno);
			Emp emp = new Emp();
			emp.setEmpno(empno);
			emp = empMapper.selectEmpByEmpno(emp);
			s1.close();
			//将查询出来的emp对象设置到request属性范围中
			request.setAttribute("emp", emp);
			request.getRequestDispatcher("updateEmp.jsp").forward(request, response);
		}else if(operator.equals("updateEmp")){
			//获取传递过来的参数
			String eno = request.getParameter("empno");
			String ename = request.getParameter("ename");
			String job = request.getParameter("job");
			String s = request.getParameter("sal");
			String c = request.getParameter("comm");
			//定义一个变量代表员工的工资
			int empno = Integer.parseInt(eno);
			double sal = Double.parseDouble(s);
			double comm = Double.parseDouble(c);
			Emp emp = new Emp();
			emp.setEmpno(empno);
			emp.setEname(ename);
			emp.setComm(comm);
			emp.setJob(job);
			emp.setSal(sal);
			empMapper.updateEmp(emp);
			s1.commit();
			s1.close();
			response.sendRedirect("selectEmp");
			
		}else if(operator.equals("delete")){
			String eno = request.getParameter("empno");
			int empno = Integer.parseInt(eno);
			Emp emp = new Emp();
			emp.setEmpno(empno);
			empMapper.deleteEmp(emp);
			s1.commit();
			s1.close();
			response.sendRedirect("selectEmp");
		}
	}

}
