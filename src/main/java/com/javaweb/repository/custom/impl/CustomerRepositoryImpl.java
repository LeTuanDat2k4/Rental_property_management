package com.javaweb.repository.custom.impl;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import com.javaweb.utils.DataUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.springframework.data.domain.Pageable;
import java.lang.reflect.Field;
import java.util.Collections;
import java.util.List;

@Repository
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    private void processJoinStatements(StringBuilder sql, CustomerSearchRequest customerSearchRequest) {
        Long staffId = customerSearchRequest.getStaffId();
        if (DataUtils.check(staffId)) {
            sql.append("JOIN assignmentcustomer ON assignmentcustomer.customerid = customer.id\n");
        }
    }



    private void processWhereNormal(StringBuilder sql, CustomerSearchRequest customerSearchRequest) {
        try {
            Field[] fields = CustomerSearchRequest.class.getDeclaredFields();
            for(Field it : fields) {
                it.setAccessible(true);
                String fieldName = it.getName();
                if (!fieldName.equals("staffId")) {
                    Object value = it.get(customerSearchRequest);
                    if(value != null) {
                        if (it.getType().equals(String.class) && value != "") {
                            sql.append(" AND customer." + fieldName + " LIKE '%" + value + "%'");
                        }
                        // for type field
                        if (it.getType().equals(List.class)) {
                            List<?> values = (List<?>) value;
                            if (!values.isEmpty()) {
                                sql.append(" AND (");
                                for (int i = 0; i < values.size(); i++) {
                                    String type = values.get(i).toString();
                                    if (i > 0) sql.append(" OR ");
                                    sql.append("customer.")
                                            .append(fieldName)
                                            .append(" LIKE '%")
                                            .append(type)
                                            .append("%'");
                                }
                                sql.append(")");
                            }

                        }

                        if (it.getType().equals(Long.class)) {
                            sql.append(" AND customer.").append(fieldName).append(" = ").append(value);
                        }
                    }
                }
            }
        } catch (Exception e) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private void processWhereSpecial(CustomerSearchRequest customerSearchRequest, StringBuilder where) {
        Long staffId = customerSearchRequest.getStaffId();
        if (DataUtils.check(staffId)) {
            where.append(" AND assignmentcustomer.staffId = ").append(staffId);
        }

    }

    private void processWhereConditions(StringBuilder sql, CustomerSearchRequest customerSearchRequest) {
        sql.append("WHERE 1=1 AND customer.is_active = 1\n");
        processWhereNormal(sql, customerSearchRequest);
        processWhereSpecial(customerSearchRequest, sql);
    }

    public StringBuilder buildQueryFilter(CustomerSearchRequest customerSearchRequest) {
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT customer.* "
                        + "FROM estateadvance.customer \n");

        processJoinStatements(sql, customerSearchRequest);
        processWhereConditions(sql, customerSearchRequest);
        return sql;
    }

    @Override
    public List<CustomerEntity> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable) {
        StringBuilder sql = buildQueryFilter(customerSearchRequest);

        sql.append(" LIMIT ").append(pageable.getPageSize())
                .append(" OFFSET ").append(pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalCustomers(CustomerSearchRequest customerSearchRequest) {
        String sql = buildQueryFilter(customerSearchRequest).toString();
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList().size();
    }
}
