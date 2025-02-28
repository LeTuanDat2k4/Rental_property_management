package com.javaweb.service.impl;

import com.javaweb.converter.CustomerConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.enums.Status;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CustomerConverter customerConverter;

    @Autowired
    private UserRepository userRepository;


    @Override
    public Boolean addOrUpdateCustomer(CustomerDTO customer) throws MyException {
        try {
            CustomerEntity customerEntity = customerConverter.convertToEntity(customer);
            customerEntity.setIsActive(1);
            if (customer.getId() == null) {
                customerEntity.setStatus(Status.CHUA_XU_LY.toString());
            } else {
                customerEntity.setStatus(customer.getStatus());
                CustomerEntity foundCustomer = customerRepository.findById(customer.getId()).orElseThrow(
                        () -> new RuntimeException("Customer Not Found")
                );
                customerEntity.setTransactions(foundCustomer.getTransactions());
                customerEntity.setCreatedBy(foundCustomer.getCreatedBy());
                customerEntity.setCreatedDate(foundCustomer.getCreatedDate());
            }
            customerRepository.save(customerEntity);
            return true;
        } catch (Exception e) {
            throw new MyException(e.getMessage());
        }
    }

    @Override
    public List<CustomerSearchResponse> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable){
        List<CustomerEntity> customerEntities = customerRepository.findCustomers(customerSearchRequest, pageable);

        List<CustomerSearchResponse> result = new ArrayList<>();

        for (CustomerEntity customerEntity : customerEntities) {
            CustomerSearchResponse customerSearchResponse = customerConverter.toCustomerSearchResponse(customerEntity);
            result.add(customerSearchResponse);
        }
        return result;
    }

    @Override
    public int countTotalItems(CustomerSearchRequest customerSearchRequest) {
        return customerRepository.countTotalCustomers(customerSearchRequest);
    }

    @Override
    public Boolean assignCustomer(AssignmentCustomerDTO assignmentCustomerDTO) {
        try {
            CustomerEntity customerEntity = customerRepository.findById(assignmentCustomerDTO.getCustomerId())
                    .orElseThrow(() -> new RuntimeException("Customer Not Found"));

            // Clear existing staff assignments for the customer
            customerEntity.getStaffList().clear();
            customerRepository.save(customerEntity);

            // Assign new staff members if provided
            if (assignmentCustomerDTO.getStaffs() != null && !assignmentCustomerDTO.getStaffs().isEmpty()) {
                List<UserEntity> staffMembers = userRepository.findAllById(assignmentCustomerDTO.getStaffs());
                customerEntity.getStaffList().addAll(staffMembers);
                customerRepository.save(customerEntity);
            }
            return true;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }

    }

    @Override
    public Boolean deleteCustomers(List<Long> customerIds) {
        try {
            List<CustomerEntity> customerEntities = customerRepository.findAllById(customerIds);
            for (CustomerEntity customerEntity : customerEntities) {
                customerEntity.setIsActive(0);
                customerRepository.save(customerEntity);
            }
            return true;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @Override
    public List<StaffResponseDTO> loadStaffs(Long customerId) {
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> assignedStaffs = userRepository.findDistinctByRoles_CodeAndCustomers_Id("STAFF", customerId);
        List<StaffResponseDTO> result = new ArrayList<>();

        for (UserEntity staff : staffs) {
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setStaffId(staff.getId());
            staffResponseDTO.setFullName(staff.getFullName());
            if (assignedStaffs.contains(staff)) {
                staffResponseDTO.setChecked("checked");
            } else {
                staffResponseDTO.setChecked("");
            }
            result.add(staffResponseDTO);
        }

        return result;
    }

    @Override
    public CustomerDTO findByCustomerIdAndIsActive(Long customerId, Integer isActive) {
        if (customerRepository.findByIdAndIsActive(customerId,1) == null) {
            return null;
        }
        return customerConverter.convertToDto(customerRepository.findByIdAndIsActive(customerId,1));
    }

    @Override
    public CustomerEntity findByCustomerId(Long customerId) {
        return customerRepository.findByIdAndIsActive(customerId,1);
    }

    @Override
    public Boolean isStaffOfCustomer(Long customerId, Long staffId) {
        CustomerEntity customerEntity = customerRepository.findByIdAndIsActive(customerId,1);
        UserEntity userEntity = userRepository.findById(staffId).orElseThrow(() -> new RuntimeException("Staff Not Found"));
        return customerEntity.getStaffList().contains(userEntity);
    }

}
