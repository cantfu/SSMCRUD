package com.cantfu.crud.service;

import com.cantfu.crud.bean.Department;
import com.cantfu.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * DepartMentService
 *
 * @author cantfu
 * @date 2019/3/27
 */
@Service
public class DepartMentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
