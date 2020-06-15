package com.oracle.mapper;

import java.util.List;

import com.oracle.po.Emp;
import com.oracle.po.EmpPage;

public interface EmpMapper {

	public abstract List<Emp> selectEmpByPage(EmpPage ep);
	public abstract Integer selectEmpCount();
	public abstract void insertEmp(Emp e);
	public abstract Emp selectEmpByEmpno(Emp e);
	public abstract void updateEmp(Emp e);
	public abstract void deleteEmp(Emp e);
}
