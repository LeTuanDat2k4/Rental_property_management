package com.javaweb.controller.admin;




import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.enums.District;
import com.javaweb.enums.TypeCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.BuildingService;
import com.javaweb.service.impl.UserService;
import com.javaweb.utils.DisplayTagUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController(value="buildingControllerOfAdmin")
public class BuildingController {

    @Autowired
    private UserService userService;

    @Autowired
    private BuildingService buildingService;

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private ModelMapper modelMapper;

    @GetMapping("/admin/building-list")
    public ModelAndView getBuildings(@ModelAttribute("modelSearch") BuildingSearchRequest params, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/list");
        DisplayTagUtils.of(request, params);
        mav.addObject("staffs",userService.getListStaff());
        mav.addObject("district", District.getDistrict());
        mav.addObject("typeCode", TypeCode.getTypes());

        if(SecurityUtils.getAuthorities().contains(SystemConstant.STAFF_ROLE)) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            params.setStaffId(staffId);
        }
        List<BuildingSearchResponse> results = buildingService.findBuildings(params, PageRequest.of(params.getPage() - 1, params.getMaxPageItems()));
        params.setListResult(results);
        params.setTotalItems(buildingService.countTotalItems(params));

        mav.addObject("buildingList", params);
        return mav;
    }

    @GetMapping("/admin/building-edit")
    public ModelAndView addBuildings(@ModelAttribute ("building") BuildingDTO buildingDTO) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("district", District.getDistrict());
        mav.addObject("typeCode", TypeCode.getTypes());
        return mav;
    }

    @GetMapping("/admin/building-edit-{id}")
    public ModelAndView addBuildings(@PathVariable Long id) {
        ModelAndView mav = new ModelAndView("admin/building/edit");

        // Staff chi xem duoc toa nha duoc giao
        if(SecurityUtils.getAuthorities().contains(SystemConstant.STAFF_ROLE)) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            if(!buildingService.isStaffOfBuilding(id, staffId)) {
                mav.setViewName("error/404");
                return mav;
            }
        }

        mav.addObject("district", District.getDistrict());
        mav.addObject("typeCode", TypeCode.getTypes());
        //Find building by id => buildingEntity => buildingDTO
        BuildingEntity buildingEntity = buildingRepository.findById(id).get();
        BuildingDTO editedbuilding = modelMapper.map(buildingEntity, BuildingDTO.class);

        // convert rentArea from BuildingEntity to BuildingDTO
        String rentArea = buildingEntity.getRentAreas().stream().map(ele -> ele.getValue().toString())
                                                                .collect(Collectors.joining(","));
        editedbuilding.setRentArea(rentArea);

        // convert type of BuildingEntity into typeCode of BuildingDTO
        List<String> typeCode = (buildingEntity.getType() != null)
                ? Arrays.asList(buildingEntity.getType().split(","))
                : new ArrayList<>();
        editedbuilding.setTypeCode(typeCode);

        mav.addObject("building", editedbuilding);
        return mav;
    }
}
