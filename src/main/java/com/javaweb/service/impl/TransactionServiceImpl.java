package com.javaweb.service.impl;

import com.javaweb.converter.TransactionConvertor;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.service.TransactionService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    ModelMapper modelMapper;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private TransactionConvertor transactionConvertor;

    @Override
    public List<TransactionDTO> findAllByCodeAndCustomer(String code, CustomerEntity customer) {
        List<TransactionDTO> list = new ArrayList<>();
        List<TransactionEntity> listEntity = transactionRepository.findAllByCodeAndCustomer(code,customer);

        for (TransactionEntity transactionEntity : listEntity) {
            TransactionDTO transactionDTO = transactionConvertor.toTransactionDTO(transactionEntity);
            list.add(transactionDTO);
        }
        return list;
    }

    @Override
    public Boolean createOrUpdateTransaction(TransactionDTO transactionDTO) {
        CustomerEntity customerEntity = customerRepository.findById(transactionDTO.getCustomerId()).orElseThrow(
                () -> new RuntimeException("Customer Not Found")
        );
        TransactionEntity transactionEntity = modelMapper.map(transactionDTO, TransactionEntity.class);
        if (transactionDTO.getId() != null) {
            TransactionEntity foundEntity = transactionRepository.findById(transactionDTO.getId()).orElseThrow(
                    () -> new RuntimeException("Transaction Not Found")
            );
            transactionEntity.setCreatedBy(foundEntity.getCreatedBy());
            transactionEntity.setCreatedDate(foundEntity.getCreatedDate());
        }

        transactionEntity.setCustomer(customerEntity);
        transactionRepository.save(transactionEntity);
        return true;
    }

    @Override
    public TransactionDTO findTransactionById(Long id) {
        TransactionEntity transactionEntity = transactionRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Transaction Not Found")
        );
        return transactionConvertor.toTransactionDTO(transactionEntity);
    }
}
