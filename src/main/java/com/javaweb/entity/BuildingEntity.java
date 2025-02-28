package com.javaweb.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "building")
@Getter
@Setter
public class BuildingEntity extends BaseEntity {
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "floorarea")
    private Integer floorArea;

    @Column(name = "district")
    private String district;

    @Column(name = "ward")
    private String ward;

    @Column(name = "street")
    private String street;

    @Column(name = "structure")
    private String structure;

    @Column(name = "direction")
    private String direction;

    @Column(name = "level")
    private String level;

    @Column(name = "servicefee")
    private String serviceFee;

    @Column(name = "carfee")
    private String carFee;

    @Column(name = "motofee")
    private String motoFee;

    @Column(name = "overtimefee")
    private String overtimeFee;

    @Column(name = "waterfee")
    private String waterfee;

    @Column(name = "electricityfee")
    private String electricityfee;

    @Column(name = "deposit")
    private String deposit;

    @Column(name = "payment")
    private String payment;

    @Column(name = "renttime")
    private String renttime;

    @Column(name = "decorationtime")
    private String decorationtime;

    @Column(name = "brokeragefee")
    private Double brokeragefee;

    @Column(name = "type")
    private String type;

    @Column(name = "note")
    private String note;

    @Column(name = "avatar")
    private String image;

    @Column(name = "linkofbuilding")
    private String linkofbuilding;

    @Column(name = "rentpricedescription")
    private String rentPriceDescription;

    @Column(name = "numberofbasement")
    private Integer numberOfBasement;

    @Column(name = "rentprice", nullable = false)
    private Integer rentPrice;

    @Column(name = "managername")
    private String managerName;

    @Column(name = "managerphone")
    private String managerPhone;

    @OneToMany(mappedBy = "buildingEntity", fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE}, orphanRemoval = true)
    private List<RentAreaEntity> rentAreas = new ArrayList<RentAreaEntity>();

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
            name = "assignmentbuilding",
            joinColumns = @JoinColumn(name = "buildingid"),
            inverseJoinColumns = @JoinColumn(name = "staffid")
    )
    private List<UserEntity> staffs = new ArrayList<>();

}
