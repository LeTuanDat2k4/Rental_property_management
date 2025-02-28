package com.javaweb.api.admin;

import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.BuildingService;
import com.javaweb.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/admin")
public class AssignmentAPI {

    @Autowired
    BuildingService buildingService;

    @Autowired
    CustomerService customerService;

    @PostMapping("/assignment-buildings")
    public ResponseEntity<?> assignBuildings(@Valid @RequestBody AssignmentBuildingDTO assignmentBuildingDTO, BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errors = result.getFieldErrors().stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage(errors.stream().collect(Collectors.joining(", ")));
                return ResponseEntity.badRequest().body(responseDTO);
            }

            Boolean rs = buildingService.assignBuildings(assignmentBuildingDTO);
            if (rs) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Buildings assigned successfully");
                return ResponseEntity.ok().body(responseDTO);
            } else {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Buildings assignment failed");
                return ResponseEntity.status(500).body(responseDTO);
            }
        } catch (Exception ex) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage("An error occurred: " + ex.getMessage());
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

    @PostMapping("/assignment-customers")
    public ResponseEntity<?> assignCustomers(@Valid @RequestBody AssignmentCustomerDTO assignmentCustomerDTO, BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> errors = result.getFieldErrors().stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage(errors.stream().collect(Collectors.joining(", ")));
                return ResponseEntity.badRequest().body(responseDTO);
            }

            Boolean rs = customerService.assignCustomer(assignmentCustomerDTO);
            if (rs) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Customers assigned successfully");
                return ResponseEntity.ok().body(responseDTO);
            } else {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Customer assignment failed");
                return ResponseEntity.status(500).body(responseDTO);
            }

        } catch (Exception ex) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage("An error occurred: " + ex.getMessage());
            return ResponseEntity.badRequest().body(responseDTO);
        }
    }

}
