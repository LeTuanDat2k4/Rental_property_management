package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.enums.District;
import com.javaweb.model.response.BuildingSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class BuildingConvertor {

    @Autowired
    private ModelMapper modelMapper;

    public BuildingSearchResponse toBuildingSearchResponse(BuildingEntity ele) {
        BuildingSearchResponse buildingSearchResponse = modelMapper.map(ele, BuildingSearchResponse.class);

        String districtName = (ele.getDistrict() != null && !ele.getDistrict().isEmpty()) ? District.valueOf(ele.getDistrict()).getDistrictName() : "";
        buildingSearchResponse.setAddress(
                (ele.getStreet() != null && !ele.getStreet().isEmpty() ? ele.getStreet() + ", " : "") +
                        (ele.getWard() != null && !ele.getWard().isEmpty() ? ele.getWard() + ", " : "") +
                        districtName
        );

        List<RentAreaEntity> rentAreasEntities = ele.getRentAreas();
        String rentArea = (rentAreasEntities != null && !rentAreasEntities.isEmpty())
                ? rentAreasEntities.stream()
                .map(rae -> rae.getValue() != null ? rae.getValue().toString() : "")
                .collect(Collectors.joining(","))
                : "";

        buildingSearchResponse.setRentArea(rentArea);

        return buildingSearchResponse;
    }
}
