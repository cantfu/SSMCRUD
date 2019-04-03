package com.cantfu.crud.controller;

import com.cantfu.crud.bean.Employee;
import com.cantfu.crud.bean.ResultMsg;
import com.cantfu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

/**
 * EmployeeController
 *
 * @author cantfu
 * @date 2019/3/26
 */
@Controller
@CrossOrigin(origins = "*",maxAge = 3600L)
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 根据 id 删除员工,返回受影响的行数
     * @param id 多个id则以' - '隔开，eg: 1-2-3
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public ResultMsg deleteEmp(@PathVariable("ids") String ids){
        // 单个删除
        if(!ids.contains("-")){
            // TODO 异常处理
            Integer deleteRow = employeeService.deleteEmp(Integer.parseInt(ids));
            return ResultMsg.success().add("deleteRow", deleteRow);
        }

        // 批量删除
        String[] delete_ids = ids.split("-");
        HashSet<Integer> idSet = new HashSet<>(8);
        for (String id : delete_ids) {

            idSet.add(Integer.parseInt(id));
        }
        List<Integer> idList = new ArrayList<Integer>(idSet);
        Integer deleteRow = employeeService.deleteBatchEmp(idList);
        return ResultMsg.success().add("deleteRow",deleteRow);
    }


    /**
     * 根据id修改员工数据，返回受影响的行数
     * @param e
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public ResultMsg updateEmp(Employee e){
        System.out.println("待更新的员工信息:"+e);
        Integer updateRow = employeeService.updateEmp(e);
        return ResultMsg.success().add("updateRow",updateRow);
    }

    /**
     * 根据 id 查询员工信息
     * @param id
     * @return 返回该员工信息，封装在ResultMsg中
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public ResultMsg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return ResultMsg.success().add("emp",employee);
    }

    /**
     * 按页码查询员工，返回封装的带分页的员工信息
     * @param pageNo 要查询的页码
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public ResultMsg getEmpsWithJson(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo) {
        // 使用PageHelper
        PageHelper.startPage(pageNo,8);
        // 查询
        List<Employee> employeeList = employeeService.getAll();
        // 返回PageInfo即可
        PageInfo info = new PageInfo(employeeList,5);
        ResultMsg msg = ResultMsg.success().add("pageInfo",info);

        return msg;
    }

    /**
     * 新增员工信息,进行合法性校验
     * @param e
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public ResultMsg saveEmp(@Valid Employee e, BindingResult result){
        if (!employeeService.checkUser(e.getEmpName())) {
            return ResultMsg.error().add("error","名称不可用！");
        }
        if (result.hasErrors()) {
            HashMap<String, Object> resultMap = new HashMap<>(6);
            System.out.println(result);
            for (ObjectError error : result.getAllErrors()) {
                resultMap.put(error.getObjectName(),error);
            }
            return ResultMsg.error().add("error",resultMap);
        }
        employeeService.saveEmp(e);
        return ResultMsg.success();
    }

    /**
     * 查询 empName 姓名是否可用,返回值查看状态码即可
     * @param empName 待查询姓名
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/checkuser")
    public ResultMsg checkuser(String empName){
        // 先检查名字是否合格
        String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(reg)) {
            return ResultMsg.error();
        }
        boolean f = employeeService.checkUser(empName);
        if(f){
            return ResultMsg.success();
        }
        return ResultMsg.error();
    }








    /**
     * 查询所有员工数据（分页查询）
     * @return
     */
    @RequestMapping(value = "/emps2")
    public String getEmps(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo, Model model){
        // 使用PageHelper
        PageHelper.startPage(pageNo,8);
        // 查询
        List<Employee> employeeList = employeeService.getAll();
        // 返回PageInfo即可
        PageInfo info = new PageInfo(employeeList,5);

        model.addAttribute("page",info);
        return "list2";
    }
}
