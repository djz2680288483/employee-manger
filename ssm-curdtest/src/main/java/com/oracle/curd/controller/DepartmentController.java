package com.oracle.curd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.curd.bean.Department;
import com.oracle.curd.bean.Msg;
import com.oracle.curd.service.DepartmentService;
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	 @RequestMapping(value = "/depts" ,method=RequestMethod.GET)
	   @ResponseBody
	   public Msg getDeptsWithJason( ){
		  List<Department> list= departmentService.getDepts();
		   return Msg.success().add("depts",list);
	   }

}
