package com.javaweb.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
public class AssignmentBuildingDTO extends AbstractDTO{
    @NotNull(message = "buildingId cannot be null")
    private Long buildingId;
    @JsonProperty("staffIds")
    private List<Long> staffs;

}
