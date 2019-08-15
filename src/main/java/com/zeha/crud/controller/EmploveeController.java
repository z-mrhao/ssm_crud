package com.zeha.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zeha.crud.bean.Emplovee;
import com.zeha.crud.bean.Msg;
import com.zeha.crud.service.EmploveeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmploveeController {
    @Autowired
    EmploveeService emploveeService;

    /*员工删除
    * 单个 批量
    * */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for(String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            emploveeService.deleteBatch(del_ids);
        }else {
            Integer id = Integer.parseInt(ids);
            emploveeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /*问题
    * 请求中有数据；
    * 但是Emplovee对象封装不上
    * Update tbl_emp where emp_id = 1014；
    *
    * 原因：
    * Tomcat：
    *   1.将请求体重的数据，封装成一个map。
    *   2.request.getParameter("empName")就会从这个map中取值。
    *   3.SpringMVC封装pojo对象的时候。
    *       会把pojo中的每个属性的值：request.getParameter("email");
    * ajax发送put请求引发的血案
    *   put请求，请求体中的数据，request.getParameter("email")拿不到。
    *   Tomcat--看到是PUT请求不会封装请求体中的数据为map，只有POST形式的请求才会封装为map。
    *   org.apache.catalina.connector.request---parseParameter()方法   3111行
    *   //默认只有POST请求
    *   protected String parseBodyMethods = "POST";
    *   //判断通过connector获取用户设置的请求是否为post,不是则直接返回，是则继续执行后续代码。
    *   if(!getConnnector().isParseBodyMethod(getMethod())){
    *       success = true;
    *       return;
    *   }
    *   解决：
    *   我们要能支持直接发送PUT之类的请求还要封装请求中的数据
    *   web.xml上配置上HttpPutFormContentFilter
    *   他的作用：将请求体中的数据解析包装成有个map。
    *   request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据。
    * */
    /*员工更新*/
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Emplovee emplovee){
        System.out.println(emplovee.toString());
        emploveeService.updateEmp(emplovee);
        return Msg.success();
    }

    @RequestMapping(value = "emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public  Msg getEmp(@PathVariable("id") Integer id){
        Emplovee emplovee = emploveeService.getEmp(id);
        return Msg.success().add("emp",emplovee);
    }

    /*导入Jackson包*/
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入pageHelper分页插件
        //查询之前只需要调用,传入页码以及每页大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Emplovee> emps = emploveeService.getAll();
        //使用pageinfo包装查询后的结果，只需要将pageinfo交给页面就行了
        //封装了详细的分页详细以及我们查询出来的数据,传入连续显示的页数。
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Emplovee emplovee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，因该返回失败，在模态框中消失校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors){
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("fieldErrors",map);
        }else {
            emploveeService.saveEmp(emplovee);
            return Msg.success();
        }
    }


    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName")String empName){
        boolean b = emploveeService.checkuser(empName);
        String regx = "(^[a-zA-Z0-9]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        System.out.println(empName);
        System.out.println(regx);
        System.out.println(regx.matches(empName));
        if(!empName.matches(regx)){
            return Msg.fail().add("va_sm","用户名为6-16位英文或数字or2-5位中文组成");
        }
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_sm","用户名不可用co");
        }
    }


    /*查询所有员工*/
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model){
        //引入pageHelper分页插件
        //查询之前只需要调用,传入页码以及每页大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Emplovee> emps = emploveeService.getAll();
        //使用pageinfo包装查询后的结果，只需要将pageinfo交给页面就行了
        //封装了详细的分页详细以及我们查询出来的数据,传入连续显示的页数。
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }


}
