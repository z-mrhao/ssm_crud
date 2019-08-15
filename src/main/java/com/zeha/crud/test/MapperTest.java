package com.zeha.crud.test;

import com.zeha.crud.bean.Emplovee;
import com.zeha.crud.dao.EmploveeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;
/*1.导入springTest模块
* 2.@ContextConfiguration指定spring配置文件的位置*/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
//    @Autowired
//    DepartmentMapper departmentMapper;
    @Autowired
    EmploveeMapper emploveeMapper;
    @Autowired
    SqlSession sqlSession;
   @Test
    public  void testCRUD(){
        //创建SpringIOC容器
     //  ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
       //从容器中获取mapper
      //DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
//       System.out.println(departmentMapper);
       //1.插入部门
//       Department department = new Department(11,"开发部");
//       Department department1 = departmentMapper.selectByPrimaryKey(1);
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//       System.out.println("department = " + department1);

//        emploveeMapper.insertSelective(new Emplovee(null,"jerry","M","je@qq.com",1));
        /*批量插入员工 ， 使用可以执行批量操作的sqlsession*/
        EmploveeMapper mapper = sqlSession.getMapper(EmploveeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Emplovee(null,uid,"M",uid+"@qq.com",1));
       }
       System.out.println("批量完成");

   }
}
