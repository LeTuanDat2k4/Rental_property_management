package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.converter.CustomerConverter;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.enums.Status;
import com.javaweb.enums.TransactionType;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.CustomerService;
import com.javaweb.service.TransactionService;
import com.javaweb.service.impl.UserService;
import com.javaweb.utils.DisplayTagUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller(value = "customerControllerOfAdmin")
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @Autowired
    private TransactionService transactionService;

    @RequestMapping(value = "/admin/customer-list", method = RequestMethod.GET)
    public ModelAndView showCustomer(@ModelAttribute("modelSearch") CustomerSearchRequest params, HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/customer/list");
        DisplayTagUtils.of(request, params);
        mav.addObject("status", Status.getStatus());
        mav.addObject("staffs",userService.getListStaff());

        if(SecurityUtils.getAuthorities().contains(SystemConstant.STAFF_ROLE)) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            params.setStaffId(staffId);
        }

        List<CustomerSearchResponse> results = customerService.findCustomers(params, PageRequest.of(params.getPage() - 1, params.getMaxPageItems()));
        CustomerSearchResponse customerList = new CustomerSearchResponse();
        customerList.setListResult(results);
        customerList.setTotalItems(customerService.countTotalItems(params));

        mav.addObject("customerList", customerList);

        return mav;
    }

    @GetMapping("/admin/customer-edit")
    public ModelAndView showCustomer(@ModelAttribute("customer") CustomerDTO customerDTO){
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        mav.addObject("status", Status.getStatus());
        return mav;
    }

    @GetMapping("/admin/customer-edit-{id}")
    public ModelAndView addBuildings(@PathVariable Long id) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");

        CustomerDTO customerDTO = customerService.findByCustomerIdAndIsActive(id,1);
        if(customerDTO == null) {
            mav.setViewName("error/404");
            return mav;
        }

//         Staff chi xem duoc Khach hang duoc giao
        if(SecurityUtils.getAuthorities().contains(SystemConstant.STAFF_ROLE)) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            if(!customerService.isStaffOfCustomer(id, staffId)) {
                mav.setViewName("error/404");
                return mav;
            }
        }

        List<TransactionDTO> CSKH_Transactions = transactionService.findAllByCodeAndCustomer("CSKH", customerService.findByCustomerId(id));
        List<TransactionDTO> DDX_Transactions = transactionService.findAllByCodeAndCustomer("DDX", customerService.findByCustomerId(id));

        mav.addObject("status", Status.getStatus());
        mav.addObject("transactionType", TransactionType.getTransactionType());
        mav.addObject("CSKH", CSKH_Transactions);
        mav.addObject("DDX", DDX_Transactions);
        mav.addObject("customer", customerDTO);
        return mav;
    }
}
