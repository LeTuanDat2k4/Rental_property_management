package com.javaweb.entity;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "customer")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CustomerEntity extends BaseEntity {
    @Column(name = "fullname")
    private String fullName;
    @Column(name = "email")
    private String email;
    @Column(name = "phone")
    private String phoneNumber;
    @Column(name = "companyname")
    private String companyName;
    @Column(name = "demand")
    private String demand;
    @Column(name = "status")
    private String status;
    @Column(name = "is_active")
    private Integer isActive;

    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE}, orphanRemoval = true)
    private List<TransactionEntity> transactions = new ArrayList<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "assignmentcustomer",
        joinColumns = @JoinColumn(name = "customerid", nullable = false),
        inverseJoinColumns = @JoinColumn(name = "staffid", nullable = false))
    private List<UserEntity> staffList = new ArrayList<>();
}
