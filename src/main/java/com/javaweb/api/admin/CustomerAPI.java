package com.javaweb.api.admin;

import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/customers")
public class CustomerAPI {
    @Autowired
    private CustomerService customerService;

    @PostMapping
    private ResponseEntity<?> createOrUpdateCustomer(@Valid @RequestBody CustomerDTO customerDTO, BindingResult bindingResult) {
        try {
            if (bindingResult.hasErrors()) {
                List<String> errors = bindingResult.getFieldErrors().stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage(errors.stream().collect(Collectors.joining(", ")));
                return ResponseEntity.badRequest().body(responseDTO);
            }
            Boolean result = customerService.addOrUpdateCustomer(customerDTO);
            if (result) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Submit Success");
                return ResponseEntity.ok().body(responseDTO);
            } else {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Submit Failed");
                return ResponseEntity.status(500).body(responseDTO);
            }

        } catch (Exception e) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage(e.getMessage());
            return ResponseEntity.status(500).body(responseDTO);
        }
    }

    @DeleteMapping({"{ids}"})
    public ResponseEntity<?> deleteCustomers(@PathVariable("ids") List<Long> ids) {
        try {
            if (ids.isEmpty()) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Ids can't be empty");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            Boolean rs = customerService.deleteCustomers(ids);

            if (rs) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Delete Success");
                return ResponseEntity.ok().body(responseDTO);
            } else {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Delete Failed");
                return ResponseEntity.status(500).body(responseDTO);
            }

        } catch (Exception e) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage("Can't delete and have error: " + e.getMessage());
            return ResponseEntity.status(500).body(responseDTO);
        }
    }

    @GetMapping("/{customerId}")
    public ResponseEntity<?> getBuildingStaffs(@PathVariable("customerId") Long buildingId) {
        try {
            List<StaffResponseDTO> staffList = customerService.loadStaffs(buildingId);
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
