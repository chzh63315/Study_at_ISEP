package com.isep.testjpa.controller;

import com.isep.testjpa.model.Emp;
import com.isep.testjpa.repository.EmpRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/emps") // 该URL根据需要进行调整
public class EmpController {

    private final EmpRepository empRepository;

    @Autowired
    public EmpController(EmpRepository empRepository) {
        this.empRepository = empRepository;
    }

    // 获取所有员工
    @GetMapping
    public List<Emp> getAllEmps() {
        return empRepository.findAll();
    }

    // 根据ID获取单个员工
    @GetMapping("/{empno}")
    public ResponseEntity<Emp> getEmpById(@PathVariable Long empno) {
        return empRepository.findById(empno)
                .map(emp -> ResponseEntity.ok().body(emp))
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // 更新员工信息
    @PutMapping("/{empno}")
    public ResponseEntity<Emp> updateEmp(@PathVariable Long empno, @RequestBody Emp empDetails) {
        return empRepository.findById(empno)
                .map(existingEmp -> {
                    existingEmp.setEname(empDetails.getEname());
                    existingEmp.setEfirst(empDetails.getEfirst());
                    existingEmp.setJob(empDetails.getJob());
                    existingEmp.setMgr(empDetails.getMgr());
                    existingEmp.setSal(empDetails.getSal());
                    empRepository.save(existingEmp);
                    return ResponseEntity.ok().body(existingEmp);
                })
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // 删除员工
    @DeleteMapping("/{empno}")
    public ResponseEntity<Void> deleteEmp(@PathVariable Long empno) {
        return empRepository.findById(empno)
                .map(emp -> {
                    empRepository.delete(emp);
                    return ResponseEntity.ok().<Void>build();
                })
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // 添加新员工
    @PostMapping
    public Emp createEmp(@RequestBody Emp newEmp) {
        return empRepository.save(newEmp);
    }
}
