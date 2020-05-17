package com.oracle.curd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.curd.bean.Employee;
import com.oracle.curd.bean.EmployeeExample;
import com.oracle.curd.bean.EmployeeExample.Criteria;
import com.oracle.curd.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	private EmployeeMapper employeeMapper;
	public List<Employee> getAll(){
		
		return employeeMapper.selectByExampleWithDepartment(null) ;
	}
	public void saveEmp(Employee emp){
		employeeMapper.insertSelective(emp);
	}
	public boolean checkEmp(String email){
		//编写EmployeeExample
		EmployeeExample example=new EmployeeExample();
		//Criteria条件
		Criteria criteria=example.createCriteria();
		criteria.andEmailEqualTo(email);
		long count=employeeMapper.countByExample(example);
		
		return count==0;
	}
	
	public Employee getEmp(Integer empid){
		Employee employee=employeeMapper.selectByPrimaryKey(empid);
		return employee;
	}
	
	public void updateEmp(Employee employee){
		 
		employeeMapper.updateByPrimaryKeySelective(employee);
       //employeeMapper.updateByPrimaryKey(employee);
		
		
	}
	public void deleteEmp(Integer empid ){
		employeeMapper.deleteByPrimaryKey(empid);
		
	}
	public void  deleteEmpBatch(List<Integer> list){
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpIdIn(list);
		employeeMapper.deleteByExample(example);
		
	}

}
