package com.javaweb.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
public class AssignmentCustomerDTO extends AbstractDTO{
    @NotNull(message = "customerId cannot be null")
    private Long customerId;
    @JsonProperty("staffIds")
    private List<Long> staffs;
}
