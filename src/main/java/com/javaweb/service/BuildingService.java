package com.javaweb.service;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.StaffResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface BuildingService {
    public List<BuildingSearchResponse> findBuildings(BuildingSearchRequest buildingSearchRequest, Pageable pageable);

    public List<StaffResponseDTO> loadStaffs(Long buildingId);

    public Boolean createOrUpdateBuildings(BuildingDTO building);

    public Boolean deleteBuildings(List<Long> buildingIds);

    public Boolean assignBuildings(AssignmentBuildingDTO assignmentBuildingDTO);

    public int countTotalItems(BuildingSearchRequest buildingSearchRequest);

    public Boolean isStaffOfBuilding(Long buildingId, Long userId);
}
