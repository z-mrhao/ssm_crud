<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--web路径
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器路径为基准（http://localhost:3306）
    需要加上项目名
    --%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.0.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工修改模态框 -->
<div class="modal fade" id="empModeUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender3_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender4_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_save">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加模态框 -->
<div class="modal fade" id="empModeAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabelUpdate">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender3_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender4_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_add_save">更改</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary" id="emp_add_model_btn">
                新增
            </button>
            <button type="button" class="btn btn-danger" id="emp_delete_model_btn">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row"></div>
    <div class="col-md-12">
        <table class="table table-hover" id="emps_table">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" id="check_all">
                </th>
                <th>#</th>
                <th>empname</th>
                <th>gender</th>
                <th>email</th>
                <th>deptname</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

</div>
<script type="text/javascript">
    var totalrecond,currentPage;
    //1.页面加载完成以后，直接发送ajax请求，要到分页数据
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工信息
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条
                build_page_nav(result)
            }
        });
    }

    function build_emps_table(result) {
        //  每次开始前先清空表格数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class = 'check_item'></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个属性，对应员工id
            editBtn.attr("edit_id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("del_id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd).appendTo("#emps_table tbody");
        })
    }

    //解析显示分页数据
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
            result.extend.pageInfo.pages+"页，总"+
            result.extend.pageInfo.total+"条.")
        totalrecond = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        //添加首页和上一页
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })
            //中间数字页
            ul.append(numLi);
        });
        //添加下一页和尾页
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    function reset_form(ele) {
        $(ele)[0].reset;
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
   
    $("#emp_add_model_btn").click(function () {
        //清除表单元素
        reset_form("#empModeAdd form");
        //$("#empModeAdd form")[0].reset;
        //g发送ajax请求，查出部门信息，显示在下拉列表中
        getdepts("#empModeAdd select");
        
        //弹出模态框
       $("#empModeAdd").modal({
          backdrop:"static"
       });
    });
    function getdepts(ele) {
        //清空之前下拉列表的数据
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                // console.log(result);
                // $("#empModeAdd select").
                $.each(result.extend.depts,function () {
                   var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                   optionEle.appendTo(ele);
                });
            }
        });
    }

    function validata_add_form() {
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            show_calidata_mag("#empName_add_input","error","用户名为6-16位英文或数字or2-5位中文组成");
            // alert("用户名为6-16位英文或数字or2-5位中文组成");
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名为6-16位英文或数字or2-5位中文组成");
            return false ;
        }else {
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");
            show_calidata_mag("#empName_add_input","success","");
        }

        var email = $("#email_add_input").val();
        var regemail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regemail.test(email)){
            // alert("邮箱格式不正确");
            show_calidata_mag("#email_add_input","error","邮箱格式不正确");
            return false;
        }else{
            show_calidata_mag("#email_add_input","success","")
        }
        return true;
    }
    
    $("#empName_add_input").change(function () {
        var empName = this.value;
       $.ajax({
           url:"${APP_PATH}/checkuser",
           data:"empName="+empName,
           type:"POST",
           success:function (result) {
               if(result.code==100){
                   show_calidata_mag("#empName_add_input","success","用户名可用");
                   $("#emp_add_save").attr("ajax-va","success");
               }else{
                   show_calidata_mag("#empName_add_input","error","用户名不可用js");
                   $("#emp_add_save").attr("ajax-va","error");
               }
           }

       });
    });

    //优化校验显示效果
    function show_calidata_mag(ele,status,msg) {
        //清除元素样式
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //点击保存
    $("#emp_add_save").click(function () {
        //提交前先对数据进行校验
        if(!validata_add_form()){
            return false
        }

        if($("#emp_add_save").attr("ajax-va")=="error"){
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp",
            data:$("#empModeAdd form").serialize(),
            type:"POST",
            success:function (result) {
                //alert(result.msg);
                if (result.code == 100) {
                    //关闭模态框
                    $("#empModeAdd").modal("hide");
                    //显示最后一页
                    to_page(totalrecond);
                } else {
                    //显示失败信息
                    //console.log(result);
                    if (undefined != result.extend.fieldErrors.email) {
                        show_calidata_mag("#email_add_input", "error", result.extend.fieldErrors.email);
                    }
                    if (undefined != result.extend.fieldErrors.empName) {
                        show_calidata_mag("#empName_add_input", "error", result.extend.fieldErrors.empName);
                    }
                }
                }
            });
        });
    //.我们是按钮创建之前就绑定了click，所以绑定不了
    //1.可以在创建按钮的时候绑定   2.绑定点击.live()方法
    //jQuery新版没有live，所以可以使用on进行替代
    $("edit_btn").click(function () {
        alert("edit")
    })
    $(document).on("click",".edit_btn",function () {
        //alert("edit")
        //查出部门信息，显示部门列表
        getEmp($(this).attr("edit_id"))
        //查询员工信息，显示员工信息
        getdepts("#empModeUpdate select")
        //把员工的id传入模态框的更新按钮
        $("#emp_update_save").attr("edit_id",$(this).attr("edit_id"));
        $("#empModeUpdate").modal({
            backdrop:"static"
        });
    })
    
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empModeUpdate input[name=gender]").val([empData.gender]);
                $("#empModeUpdate select").val([empData.dId]);
            }
        })
    }
    //更新按钮
    $("#emp_update_save").click(function () {
        //数据校验
        var email = $("#email_update_input").val();
        var regemail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regemail.test(email)){
            show_calidata_mag("#email_update_input","error","邮箱格式不正确");
            return false;
        }else{
            show_calidata_mag("#email_update_input","success","")
        }
       $.ajax({
           url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
           type:"PUT",
           data:$("#empModeUpdate form").serialize(),
           success:function (result) {
               //alert(result.msg);
               //关闭模态框
               $("#empModeUpdate").modal("hide");
               //回到本页面
                to_page(currentPage);
           }
       });
    });
    
    //员工删除按钮
    $(document).on("click",".delete_btn",function () {
        //弹出是否确认删除
        //alert($(this).parents("tr").find("td:eq(1)").text());
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del_id");
        if(confirm("确认删除【"+empName+"】吗")){
            //确认，方式ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    });

    //全选 全部选功能
    $("#check_all").click(function () {
       //attr获取checked是undefined;
       //我们这些dom原生的属性，attr获取自定义属性的值；
       //prop修改和读取dom原生属性的值。
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //当选项全部勾选时 同步全选按钮
    $(document).on("click",".check_item",function () {
       //判读被选中的个数
       var flag = $(".check_item:checked").length==$(".check_item").length;
       $("#check_all").prop("checked", flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_model_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
       $.each($(".check_item:checked"),function () {
           //员工名字字符串
           empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
           //员工id字符串
           del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
       });
       //去除多余的分隔符
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
       if(confirm("确认删除【"+empNames+"】吗？")){
           //发送ajax请求
            $.ajax({
               url:"${APP_PATH}/emp/"+del_idstr,
               type:"DELETE",
               success:function (result) {
                   alert(result.msg);
                   to_page(currentPage);
               } 
            });
       }
    });
</script>
</body>
</html>
