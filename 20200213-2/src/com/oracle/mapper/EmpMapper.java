package com.oracle.mapper;

import java.util.List;

import com.oracle.po.Emp;
import com.oracle.po.EmpPage;

public interface EmpMapper {
	public abstract List<Emp> selectEmpByPage(EmpPage emppage);
	public abstract Integer selectTotal();
	public abstract  List<Emp> selectEmpByEname(EmpPage ename);
	public abstract Integer selectnameCount( EmpPage ep);
	public abstract  List<Emp> selectEmpByJob(EmpPage job);
	public abstract Integer selectjobCount( EmpPage ep);
	
	public abstract void insertEmp(Emp emp);
	public abstract void updateEmp(Emp emp);
	public abstract void  deleteEmp(Emp emp);
	public abstract Emp  selectEmpByEmpno(Emp emp);
	public abstract Integer selectEmpCount();

}
