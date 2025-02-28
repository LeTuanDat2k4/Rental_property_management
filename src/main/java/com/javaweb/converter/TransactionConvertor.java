package com.javaweb.converter;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransactionConvertor {
    @Autowired
    ModelMapper modelMapper;

    public TransactionDTO toTransactionDTO(TransactionEntity transactionEntity) {
        TransactionDTO transactionDTO = modelMapper.map(transactionEntity, TransactionDTO.class);
        transactionDTO.setId(transactionEntity.getId());
        return transactionDTO;
    }
}
