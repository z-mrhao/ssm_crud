package com.zeha.crud.bean;

import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.Pattern;

public class Emplovee {
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z0-9]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})"
            ,message = "用户名为6-16位英文或数字or2-5位中文组成")
    private String empName;

    private String gender;

    @Email
    @Pattern(regexp = "^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$"
            ,message = "邮箱格式不正确")
    private String email;

    private Integer dId;

    private Department department;

    public Emplovee() {
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public Emplovee(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}