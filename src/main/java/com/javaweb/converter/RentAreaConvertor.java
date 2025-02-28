package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.model.dto.BuildingDTO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class RentAreaConvertor {
    public List<RentAreaEntity> toListRentAreaEntity(BuildingDTO building, BuildingEntity buildingEntity) {
        String[] rentAreas = building.getRentArea().split(",");
        List<RentAreaEntity> rentAreasEntity = new ArrayList<>();
        for (String rentArea : rentAreas) {
            RentAreaEntity rentAreaEntity = new RentAreaEntity();
            rentAreaEntity.setBuildingEntity(buildingEntity);
            rentAreaEntity.setValue(Integer.parseInt(rentArea));
            rentAreasEntity.add(rentAreaEntity);
        }
        return rentAreasEntity;
    }
}
