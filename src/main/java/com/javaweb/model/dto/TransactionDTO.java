package com.javaweb.model.dto;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
public class TransactionDTO extends AbstractDTO{
    @NotBlank(message = "code cannot be blank")
    private String code;
    private String note;
    @NotNull(message = "customerId cannot be null")
    private Long customerId;
    private Long staffId;
}
