package com.javaweb.service.impl;

import com.javaweb.converter.BuildingConvertor;
import com.javaweb.converter.RentAreaConvertor;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.RentAreaRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.BuildingService;
import com.javaweb.utils.UploadFileUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BuildingServiceImpl implements BuildingService {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private BuildingConvertor buildingConvertor;

    @Autowired
    private RentAreaConvertor rentAreaConvertor;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RentAreaRepository rentAreaRepository;

    @Autowired
    private UploadFileUtils uploadFileUtils;

    @Override
    public List<BuildingSearchResponse> findBuildings(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        List<BuildingEntity> buildingEntities = buildingRepository.findBuildings(buildingSearchRequest, pageable);

        List<BuildingSearchResponse> result = new ArrayList<>();

        for (BuildingEntity buildingEntity : buildingEntities) {
            BuildingSearchResponse buildingSearchResponse = buildingConvertor.toBuildingSearchResponse(buildingEntity);
            result.add(buildingSearchResponse);
        }
        return result;
    }

    @Override
    public List<StaffResponseDTO> loadStaffs(Long buildingId) {
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> assignedStaffs = userRepository.findDistinctByRoles_CodeAndBuildings_Id("STAFF", buildingId);
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
    public Boolean createOrUpdateBuildings(BuildingDTO building) {
        try {
            BuildingEntity buildingEntity = modelMapper.map(building, BuildingEntity.class);
            String type = String.join(",", building.getTypeCode());
            buildingEntity.setType(type);

            if (building.getId() != null) { // update
                BuildingEntity foundBuilding = buildingRepository.findById(building.getId())
                        .orElseThrow(() -> new NotFoundException("Building not found!"));
                buildingEntity.setImage(foundBuilding.getImage());
                buildingEntity.setCreatedBy(foundBuilding.getCreatedBy());
                buildingEntity.setCreatedDate(foundBuilding.getCreatedDate());
            }
            saveThumbnail(building,buildingEntity);

            List<RentAreaEntity> rentAreasEntity = rentAreaConvertor.toListRentAreaEntity(building, buildingEntity);
            buildingEntity.setRentAreas(rentAreasEntity);

            buildingRepository.save(buildingEntity);

            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Boolean deleteBuildings(List<Long> buildingIds) {
        try {
            buildingRepository.deleteByIdIn(buildingIds);
            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Boolean assignBuildings(AssignmentBuildingDTO assignmentBuildingDTO) {
        try {
            // Find the building by ID
            BuildingEntity building = buildingRepository.findById(assignmentBuildingDTO.getBuildingId())
                    .orElseThrow(() -> new RuntimeException("Building not found"));

            // Clear existing staff assignments for the building
            building.getStaffs().clear();
            buildingRepository.save(building);

            // Assign new staff members if provided
            if (assignmentBuildingDTO.getStaffs() != null && !assignmentBuildingDTO.getStaffs().isEmpty()) {
                List<UserEntity> staffMembers = userRepository.findAllById(assignmentBuildingDTO.getStaffs());
                building.getStaffs().addAll(staffMembers);
                buildingRepository.save(building);
            }

            return true;
        } catch (Exception e) {
            throw new RuntimeException("Error assigning buildings", e);
        }
    }

    @Override
    public int countTotalItems(BuildingSearchRequest buildingSearchRequest) {
        return buildingRepository.countTotalItem(buildingSearchRequest);
    }

    @Override
    public Boolean isStaffOfBuilding(Long buildingId, Long staffId) {
        BuildingEntity buildingEntity = buildingRepository.findById(buildingId).get();
        UserEntity staff = userRepository.findById(staffId).get();
        return buildingEntity.getStaffs().contains(staff);
    }

    private void saveThumbnail(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        String path = "/building/" + buildingDTO.getImageName();
        if (null != buildingDTO.getImageBase64()) {
            if (null != buildingEntity.getImage()) {
                if (!path.equals(buildingEntity.getImage())) {
                    File file = new File("C://home/office" + buildingEntity.getImage());
                    file.delete();
                }
            }
            byte[] bytes = Base64.decodeBase64(buildingDTO.getImageBase64().getBytes());
            uploadFileUtils.writeOrUpdate(path, bytes);
            buildingEntity.setImage(path);
        }
    }
}
