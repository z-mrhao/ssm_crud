package com.zeha.crud.service;

import com.zeha.crud.bean.Emplovee;
import com.zeha.crud.bean.EmploveeExample;
import com.zeha.crud.dao.EmploveeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmploveeService {
    @Autowired
    EmploveeMapper emploveeMapper;

    public List<Emplovee> getAll() {
        return emploveeMapper.selectByExampleWithDept(null);
    }

    public void  saveEmp(Emplovee emplovee) {
        emploveeMapper.insertSelective(emplovee);
    }

    public boolean checkuser(String empName) {
        EmploveeExample example = new EmploveeExample();
        EmploveeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = emploveeMapper.countByExample(example);
        return count==0;
    }

    public Emplovee getEmp(Integer id) {
        Emplovee emplovee = emploveeMapper.selectByPrimaryKey(id);
        return emplovee;
    }

    public void updateEmp(Emplovee emplovee) {
        emploveeMapper.updateByPrimaryKeySelective(emplovee);
    }

    public void deleteEmp(Integer id) {
        emploveeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmploveeExample example = new EmploveeExample();
        EmploveeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        emploveeMapper.deleteByExample(example);
    }
}
