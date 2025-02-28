package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.enums.District;
import com.javaweb.enums.Status;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.CustomerSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class CustomerConverter {
    @Autowired
    private ModelMapper modelMapper;

    public CustomerEntity convertToEntity(CustomerDTO customerDTO) {
        CustomerEntity customerEntity = CustomerEntity.builder()
                .fullName(customerDTO.getName())
                .email(customerDTO.getEmail())
                .phoneNumber(customerDTO.getCustomerPhone())
                .companyName(customerDTO.getCompanyName())
                .demand(customerDTO.getDemand())
                .build();
        customerEntity.setId(customerDTO.getId());
        return customerEntity;
    }

    public CustomerDTO convertToDto(CustomerEntity customerEntity) {
        CustomerDTO customerDTO = CustomerDTO.builder()
                .name(customerEntity.getFullName())
                .customerPhone(customerEntity.getPhoneNumber())
                .email(customerEntity.getEmail())
                .demand(customerEntity.getDemand())
                .status(customerEntity.getStatus())
                .companyName(customerEntity.getCompanyName())
                .build();
        customerDTO.setId(customerEntity.getId());
        return customerDTO;
    }

    public CustomerSearchResponse toCustomerSearchResponse(CustomerEntity ele) {
        CustomerSearchResponse customerSearchResponse = modelMapper.map(ele, CustomerSearchResponse.class);

        String status = (ele.getStatus() != null && !ele.getStatus().isEmpty()) ? Status.valueOf(ele.getStatus()).getStatusName() : "";
        customerSearchResponse.setStatus(status);

        return customerSearchResponse;
    }
}
