package com.javaweb.model.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
public class BuildingDTO extends AbstractDTO{
    private Long id;
    @NotBlank(message = "name cannot be blank")
    private String name;
    private String street;
    private String ward;
    @NotBlank(message = "district cannot be blank")
    private String district;
    private Long numberOfBasement;
    private Long floorArea;
    private String level;
    @Size(min = 1)
    private List<String> typeCode;
    private String overtimeFee;
    private String electricityFee;
    private String deposit;
    private String payment;
    private String waterFee;
    private String rentTime;
    private String decorationTime;
    private String rentPriceDescription;
    private String carFee;
    private String motoFee;
    private String structure;
    private String direction;
    private String note;
    private String rentArea;
    private String managerName;
    private String managerPhone;
    @NotNull(message = "rentPrice is required")
    private Long rentPrice;
    private String serviceFee;
    private double brokerageFee;
    private String image;
    private String imageBase64;
    private String imageName;

    public String getImageBase64() {
        if (imageBase64 != null) {
            return imageBase64.split(",")[1];
        }
        return null;
    }

    private Map<String,String> buildingDTOs = new HashMap<>();


}