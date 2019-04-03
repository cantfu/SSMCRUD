package com.cantfu.crud.controller;

import com.cantfu.crud.bean.Department;
import com.cantfu.crud.bean.ResultMsg;
import com.cantfu.crud.service.DepartMentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * DepartMentController
 *
 * @author cantfu
 * @date 2019/3/27
 */
@Controller
@CrossOrigin(origins = "*",maxAge = 3600L)
public class DepartMentController {

    @Autowired
    DepartMentService departMentService;

    /**
     * 获取所有部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/depts",method = RequestMethod.GET)
    public ResultMsg depts(){
        List<Department> depts = departMentService.getDepts();
        return ResultMsg.success().add("depts",depts);
    }
}
