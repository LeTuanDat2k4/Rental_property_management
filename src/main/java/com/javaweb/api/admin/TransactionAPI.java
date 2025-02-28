package com.javaweb.api.admin;

import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/transactions")
public class TransactionAPI {
    @Autowired
    private TransactionService transactionService;

    @PostMapping
    private ResponseEntity<?> createOrUpdateTransaction(@Valid @RequestBody TransactionDTO transactionDTO, BindingResult bindingResult) {
        try {
            if (bindingResult.hasErrors()) {
                List<String> errors = bindingResult.getFieldErrors().stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage(errors.stream().collect(Collectors.joining(", ")));
                return ResponseEntity.badRequest().body(responseDTO);
            }
            Long staffId = SecurityUtils.getPrincipal().getId();
            transactionDTO.setStaffId(staffId);
            Boolean rs = transactionService.createOrUpdateTransaction(transactionDTO);
            if (rs) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Success");
                return ResponseEntity.ok().body(responseDTO);
            } else {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Error");
                return ResponseEntity.badRequest().body(responseDTO);
            }
        } catch (Exception e) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage(e.getMessage());
            return ResponseEntity.status(500).body(responseDTO);
        }
    }

    @GetMapping("{transactionId}")
    private ResponseEntity<?> getTransactionNotes(@PathVariable("transactionId") Long transactionId) {
        try {
            if (transactionId == null) {
                ResponseDTO responseDTO = new ResponseDTO();
                responseDTO.setMessage("Invalid transactionId");
                return ResponseEntity.badRequest().body(responseDTO);
            }
            TransactionDTO rs = transactionService.findTransactionById(transactionId);
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setData(rs.getNote());
            return ResponseEntity.ok().body(responseDTO);
        } catch (Exception e) {
            ResponseDTO responseDTO = new ResponseDTO();
            responseDTO.setMessage(e.getMessage());
            return ResponseEntity.status(500).body(responseDTO);
        }
    }
}
