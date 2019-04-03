package com.cantfu.crud.service;

import com.cantfu.crud.bean.Employee;
import com.cantfu.crud.bean.EmployeeExample;
import com.cantfu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * EmployeeService
 *
 * @author cantfu
 * @date 2019/3/26
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工数据
     * @param e
     */
    public void saveEmp(Employee e){
        employeeMapper.insertSelective(e);
    }

    /**
     * 检查 empName 是否可用
     * @param empName
     * @return
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 根据 id 查询员工信息
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新员工信息
     * @param e
     */
    public Integer updateEmp(Employee e) {
        return employeeMapper.updateByPrimaryKeySelective(e);
    }

    /**
     * 删除单个员工
     * @param id
     * @return
     */
    public Integer deleteEmp(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }
    /**
     * 删除多个员工
     * @param idList
     */
    public Integer deleteBatchEmp(List<Integer> idList) {
        // TODO 事务？？
        EmployeeExample e = new EmployeeExample();
        EmployeeExample.Criteria criteria = e.createCriteria();
        criteria.andEmpIdIn(idList);
        return employeeMapper.deleteByExample(e);
    }
}
