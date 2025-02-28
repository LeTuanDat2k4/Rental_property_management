package com.javaweb.repository.custom.impl;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import com.javaweb.utils.DataUtils;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    private void processJoinStatements(StringBuilder sql, BuildingSearchRequest buildingSearchRequest) {
        Long areaFrom = buildingSearchRequest.getAreaFrom();
        Long areaTo = buildingSearchRequest.getAreaTo();
        if (DataUtils.check(areaFrom) || DataUtils.check(areaTo)) {
            sql.append("JOIN rentarea ON rentarea.buildingid = building.id\n");
        }

        Long staffId = buildingSearchRequest.getStaffId();
        if (DataUtils.check(staffId)) {
            sql.append("JOIN assignmentbuilding ON assignmentbuilding.buildingid = building.id\n");
        }

    }

    private void processWhereConditions(StringBuilder sql, BuildingSearchRequest buildingSearchRequest) {
        sql.append("WHERE 1=1");
        processWhereNormal(buildingSearchRequest, sql);
        processWhereSpecial(buildingSearchRequest, sql);
    }

    private void processWhereNormal(BuildingSearchRequest buildingSearchRequest, StringBuilder where) {
        try {
            Field[] fields = BuildingSearchRequest.class.getDeclaredFields();
            for(Field it : fields) {
                it.setAccessible(true);
                String fieldName = !it.getName().equals("typeCode") ? it.getName() : "type";
                if (!fieldName.equals("staffId") && !fieldName.startsWith("area")
                        && !fieldName.startsWith("rentPrice")) {
                    Object value = it.get(buildingSearchRequest);
                    if(value != null) {
                        if (it.getType().equals(String.class) && value != "") {
                            where.append(" AND building." + fieldName + " LIKE '%" + value + "%'");
                        }
                        // for type field
                        if (it.getType().equals(List.class)) {
                            List<?> values = (List<?>) value;
                            if (!values.isEmpty()) {
                                where.append(" AND (");
                                for (int i = 0; i < values.size(); i++) {
                                    String type = values.get(i).toString();
                                    if (i > 0) where.append(" OR ");
                                    where.append("building.")
                                            .append(fieldName)
                                            .append(" LIKE '%")
                                            .append(type)
                                            .append("%'");
                                }
                                where.append(")");
                            }

                        }

                        if (it.getType().equals(Long.class)) {
                            where.append(" AND building.").append(fieldName).append(" = ").append(value);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private void processWhereSpecial(BuildingSearchRequest buildingSearchRequest, StringBuilder where) {
        Long staffId = buildingSearchRequest.getStaffId();
        if (DataUtils.check(staffId)) {
            where.append(" AND assignmentbuilding.staffId = ").append(staffId);
        }

        Long areaFrom = buildingSearchRequest.getAreaFrom();
        Long areaTo = buildingSearchRequest.getAreaTo();
        if (DataUtils.check(areaFrom)) {
            where.append(" AND rentarea.value >= ").append(areaFrom);
        }
        if (DataUtils.check(areaTo)) {
            where.append(" AND rentarea.value <= ").append(areaTo);
        }

        Long rentPriceFrom = buildingSearchRequest.getRentPriceFrom();
        Long rentPriceTo = buildingSearchRequest.getRentPriceTo();
        if (DataUtils.check(rentPriceFrom)) {
            where.append(" AND building.rentprice >= ").append(rentPriceFrom);
        }
        if (DataUtils.check(rentPriceTo)) {
            where.append(" AND building.rentprice <= ").append(rentPriceTo);
        }

    }

    @Override
    public List<BuildingEntity> findBuildings(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        StringBuilder sql = buildQueryFilter(buildingSearchRequest);

        sql.append(" LIMIT ").append(pageable.getPageSize())
                .append(" OFFSET ").append(pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(),BuildingEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItem(BuildingSearchRequest buildingSearchRequest) {
        String sql = buildQueryFilter(buildingSearchRequest).toString();
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList().size();
    }

    public StringBuilder buildQueryFilter(BuildingSearchRequest buildingSearchRequest) {
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT building.* "
                        + "FROM estateadvance.building \n");

        processJoinStatements(sql, buildingSearchRequest);
        processWhereConditions(sql, buildingSearchRequest);
        return sql;
    }

}
