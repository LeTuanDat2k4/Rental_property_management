package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CustomerSearchResponse extends AbstractDTO {
    private String fullName;
    private String phoneNumber;
    private String email;
    private String status;
    private String demand;
    private Date createddate;
    private String createdby;
}
