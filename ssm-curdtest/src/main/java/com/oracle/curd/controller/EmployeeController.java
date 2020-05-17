package com.oracle.curd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.validation.FieldError;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oracle.curd.bean.Employee;
import com.oracle.curd.bean.Msg;
import com.oracle.curd.service.EmployeeService;

@Controller
public class EmployeeController {
   @Autowired
   private EmployeeService employeeService;
   
   @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE) 
   @ResponseBody
   public Msg deleteEmp(@PathVariable("ids") String ids){
	   if(ids.contains(",")){
		   String []str_ids=ids.split(",");
		   List<Integer> list=new ArrayList<Integer>();
		   for(String s:str_ids){
			   list.add(Integer.parseInt(s));
		   }
		   employeeService.deleteEmpBatch(list);
		   return Msg.success();
	   }else{
		   employeeService.deleteEmp(Integer.parseInt(ids));
		   return Msg.success();
	   }
	  
   }
   
   @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT) 
   @ResponseBody
   public Msg updateEmp(Employee employee){
	
	   employeeService.updateEmp(employee);
	   return Msg.success();
   }
   
   @RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
   @ResponseBody
   public Msg getEmp(@PathVariable("id")  Integer id){
	   Employee employee=employeeService.getEmp(id);
	   return Msg.success().add("emp",employee);
   }
   
   @RequestMapping(value="/checkempName" ,method=RequestMethod.POST)
   @ResponseBody
   public Msg checkEmpName(@RequestParam(value="empName") String empName){
	   //定义正则表达式
	   String regName="^[\u4e00-\u9fa5]{2,10}|^[a-zA-Z]{4,20}$";
	   if(!empName.matches(regName)){
		   
		   return Msg.fail().add("va_msg","员工的姓名格式不正确");
	   }else{
	       return Msg.success().add("va_msg","员工的姓名可用");
	       
	   }
   }
   
   
   @RequestMapping(value="/checkemp" ,method=RequestMethod.POST)
   @ResponseBody
   public Msg checkEmpEmail(@RequestParam(value="email") String email){
	   //定义正则表达式
	   String regEmail="^\\w{4,16}@[a-zA-Z0-9]{2,6}\\.(cn|com|net)$";
	   if(!email.matches(regEmail)){
		   
		   return Msg.fail().add("va_msg","员工的邮箱格式不正确");
	   }
	   boolean varite=employeeService.checkEmp(email);
	   if(varite){
		   return Msg.success();
	   }else{
		   
		   return Msg.fail().add("va_msg","该邮箱不可用");
	   }
   }
   
   @RequestMapping(value="/emp", method=RequestMethod.POST)
   @ResponseBody
   public Msg saveEmp(Employee employee,BindingResult result){
	   if(result.hasErrors()){
		   //定义一个Map集合，用来保存错误信息
		   Map <String,Object> map=new HashMap<String, Object>();
		   List <FieldError> errors=result.getFieldErrors();
		   for(FieldError err:errors){
			   map.put(err.getField(),err.getDefaultMessage());
		   }
		   return Msg.fail().add("errorsFields",map);
		   
	   }else{
		   employeeService.saveEmp(employee);
		   return Msg.success();
		   
	   }
	   
	   
   }
   
   @RequestMapping(value="/emps")
   @ResponseBody
   public Msg getEmpsWithJason(@RequestParam(value="pn",defaultValue="1") Integer pn){
	   //在查询之前引入pageHelper分页插件，只需要指定当前的页码，以及每一页需要查询的数量
	   PageHelper.startPage(pn, 5);
	   //在startPage方法后面紧跟的方法就是分页查询的方法,默认的自动的就是分页查询
	List<Employee> emps=   employeeService.getAll();
	//使用pageinfo包装查询之后的结果，pageinfo中包含我们需要的所有的信息，例如，
	//当前的页码是否是第一页，是否是最后一页等
	   PageInfo page=new PageInfo(emps,5);
	 //测试PageInfo全部属性
	 //PageInfo包含了非常全面的分页属性
//	 System.out.println( page.getPageNum());
//	 System.out.println( page.getPageSize());
//	 System.out.println( page.getStartRow());
//	 System.out.println(page.getEndRow());
//	 System.out.println( page.getTotal());
//	 System.out.println(page.getPages());
//	 System.out.println(page.isIsFirstPage());
//	 System.out.println(page.isIsLastPage());
//	 System.out.println(page.isHasPreviousPage());
//	 System.out.println( page.isHasNextPage());
	   //将pageInfo设置到request范围中
	   return Msg.success().add("pageinfo", page);
   }
   
   
   
}
