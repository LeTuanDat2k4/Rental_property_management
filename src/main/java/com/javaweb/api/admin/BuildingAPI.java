package com.javaweb.api.admin;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.service.BuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/admin/buildings")
public class BuildingAPI {

    @Autowired
    private BuildingService buildingService;

    @PostMapping
    public ResponseEntity<?> creatOrUpdateBuilding(@Valid @RequestBody BuildingDTO dto, BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errors = result.getFieldErrors().stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage(errors.stream().collect(Collectors.joining(", ")));
                return ResponseEntity.badRequest().body(responseDTO);
            }

            Boolean rs = buildingService.createOrUpdateBuildings(dto);
            if (rs) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage(dto.getId() != null ? "Update building success " + dto.getName() : "Create building success");
                return ResponseEntity.ok(responseDTO);
            } else {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage(dto.getId() != null ? "Update building failure " + dto.getName() : "Create building failure");
                return ResponseEntity.badRequest().body(responseDTO);
            }

        } catch (Exception ex) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage("An error occurred: " + ex.getMessage());
            ex.printStackTrace();
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    @DeleteMapping("/{ids}")
    public ResponseEntity<?> deleteBuildings(@PathVariable("ids") List<Long> ids) {
        try {
            if (ids.isEmpty()) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Ids can't be empty");
                return ResponseEntity.badRequest().body(responseDTO);
            }
            Boolean rs = buildingService.deleteBuildings(ids);

            if (rs) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Buildings deleted successfully");
                return ResponseEntity.ok().body(responseDTO);
            } else {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Delete buildings failed");
                return ResponseEntity.badRequest().body(responseDTO);
            }

        } catch (Exception e) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage("Can't delete and have error: " + e.getMessage());
            return ResponseEntity.status(500).body(responseDTO);
        }
    }

    @GetMapping("/{buildingId}")
    public ResponseEntity<?> getBuildingStaffs(@PathVariable("buildingId") Long buildingId) {
        try {
            List<StaffResponseDTO> staffList = buildingService.loadStaffs(buildingId);
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage("Staffs loaded successfully");
            responseDTO.setData(staffList);
            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception ex) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage("Staffs loaded failure: " + ex.getMessage());
            return ResponseEntity.status(500).body(responseDTO);
        }

    }

}
