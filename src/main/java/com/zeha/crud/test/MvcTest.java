package com.zeha.crud.test;

import com.github.pagehelper.PageInfo;
import com.zeha.crud.bean.Emplovee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;
    @Before
    public void  initMockMvc(){
        mockMvc  = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();
        //请求成功后会有pageinfo，我们可以取出pageinfo来验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码："+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());
        System.out.println("页面需要显示的连续页码");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums){
            System.out.println(" "+i);
        }
        //获取员工数据
        List<Emplovee> list = pi.getList();
        for(Emplovee emplovee:list){
            System.out.println("ID:"+emplovee.getEmpId()+"==>name:"+emplovee.getEmpName());
        }
    }
}
