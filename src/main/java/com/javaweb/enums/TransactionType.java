package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum TransactionType {
    CSKH("Chăm sóc khách hàng"),
    DDX("Dân đi xem nhà");

    private final String name;

    TransactionType(String name) {
        this.name = name;
    }

    public static Map<String, String> getTransactionType() {
        Map<String, String> transactionList = new LinkedHashMap<>();
        for (TransactionType i : TransactionType.values()) {
            transactionList.put(i.toString(), i.name);
        }
        return transactionList;
    }
}
