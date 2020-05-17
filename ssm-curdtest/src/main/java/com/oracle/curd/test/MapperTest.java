package com.oracle.curd.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.oracle.curd.bean.Department;
import com.oracle.curd.dao.DepartmentMapper;

/**
 * 编写SpringTest测试类，我们使用SpringJunit
 * 1,导入springTest的jar包
 * 2.使用@ContextConfiguration指定Spring的配置文件的位置
 * 3，使用@RunWith设置采用Spring的junit进行测试
 * 4，直接使用@AutoWired自动装配我们需要使用的类
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Test
	public void test(){
		Department department=new Department();
		department.setDeptName("财务部");
		departmentMapper.insertSelective(department);
		department=new Department();
		department.setDeptName("管理部");
		departmentMapper.insertSelective(department);
	}

}
