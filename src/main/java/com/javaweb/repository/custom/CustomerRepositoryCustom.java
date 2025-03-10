package com.javaweb.repository.custom;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.request.CustomerSearchRequest;

import org.springframework.data.domain.Pageable;
import java.util.List;

public interface CustomerRepositoryCustom {
    public List<CustomerEntity> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable);

    public int countTotalCustomers(CustomerSearchRequest customerSearchRequest);
}
