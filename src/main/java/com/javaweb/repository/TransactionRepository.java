package com.javaweb.repository;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.repository.custom.TransactionRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionRepository extends JpaRepository<TransactionEntity, Long>, TransactionRepositoryCustom {
    List<TransactionEntity> findAllByCodeAndCustomer (String code, CustomerEntity customer);
}
