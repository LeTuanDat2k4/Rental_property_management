package com.javaweb.service;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.CustomerSearchResponse;

import com.javaweb.model.response.StaffResponseDTO;
import org.springframework.data.domain.Pageable;
import java.util.List;

public interface CustomerService {
    public Boolean addOrUpdateCustomer(CustomerDTO customer) throws MyException;

    public List<CustomerSearchResponse> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable);

    public int countTotalItems (CustomerSearchRequest customerSearchRequest);

    public Boolean assignCustomer(AssignmentCustomerDTO assignmentCustomerDTO);

    public Boolean deleteCustomers(List<Long> customerIds);

    public List<StaffResponseDTO> loadStaffs(Long customerId);

    public CustomerDTO findByCustomerIdAndIsActive(Long customerId, Integer isActive);

    public CustomerEntity findByCustomerId(Long customerId);

    public Boolean isStaffOfCustomer(Long customerId, Long staffId);
}
