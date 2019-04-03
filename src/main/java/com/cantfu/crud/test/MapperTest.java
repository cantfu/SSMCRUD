package com.cantfu.crud.test;

import com.cantfu.crud.bean.Department;
import com.cantfu.crud.bean.Employee;
import com.cantfu.crud.dao.DepartmentMapper;
import com.cantfu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * MapperTest
 * dao层测试
 * @author cantfu
 * @date 2019/3/25
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){

        System.out.println(departmentMapper.toString());
        System.out.println(departmentMapper.getClass().getSimpleName());

        // 插入几个部门
        // departmentMapper.insertSelective(new Department(null,"开发部"));
        // departmentMapper.insertSelective(new Department(null,"测试部"));

        // 生成员工数据
        // employeeMapper.insertSelective(new Employee(null,"marco","M","marco@gmail.com",1));

        // 查询员工信息，带上部门信息
        // Employee employee= employeeMapper.selectByPrimaryKeyWithDept(1);
        // System.out.println(employee.getDepartment());

        // 批量插入
        // for (int i = 0; i < 1000; i++) {
        //     EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        //     String gender = Math.random()> 0.5 ? "F" : "M";
        //     String name = UUID.randomUUID().toString().substring(0,5) + i;
        //     Integer deptId = Math.random() > 0.5 ? 1 :2;
        //     mapper.insertSelective(new Employee(null,name,gender,name+"@gmail.com",deptId));

        }
    }
