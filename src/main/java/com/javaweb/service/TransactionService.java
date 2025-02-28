package com.javaweb.service;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.dto.TransactionDTO;

import java.util.List;

public interface TransactionService {
    public List<TransactionDTO> findAllByCodeAndCustomer(String code, CustomerEntity customer);

    public Boolean createOrUpdateTransaction(TransactionDTO transactionDTO);

    public TransactionDTO findTransactionById(Long id);
}
