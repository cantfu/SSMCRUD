package com.cantfu.crud.test;

import com.cantfu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * MvcTest
 * 测试 WEB 请求
 * @author cantfu
 * @date 2019/3/26
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class MvcTest {

    /**
     * 虚拟 MVC 请求,获取处理结果
     */
    MockMvc mockMvc;

    @Autowired
    WebApplicationContext webApplicationContext;

    @Before
    public void init(){
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void pageTest() throws Exception{
        // 拿到请求结果
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo", "1")).andReturn();
        // 用page信息校验
        PageInfo page = (PageInfo) result.getRequest().getAttribute("page");
        System.out.println("当前页码：" + page.getPageNum());
        System.out.println("总页码：" + page.getPages());
        System.out.println("总记录数：" + page.getTotal());
        System.out.println("页面需要显示的导航页码号：");
        int[] navigatePages = page.getNavigatepageNums();
        for (int i : navigatePages) {
            System.out.print(" " + i);
        }

        // 获取员工信息
        List<Employee> emps = page.getList();
        for (Employee emp : emps) {
            System.out.println("ID:" + emp.getEmpId() + "--------NAME:" + emp.getEmpName());
        }

    }
}
