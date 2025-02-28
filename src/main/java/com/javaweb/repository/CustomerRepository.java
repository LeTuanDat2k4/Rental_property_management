package com.javaweb.repository;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CustomerRepository extends JpaRepository<CustomerEntity, Long>, CustomerRepositoryCustom {
    public void deleteByIdIn(List<Long> ids);
    public CustomerEntity findByIdAndIsActive(Long id, Integer isActive);
}
