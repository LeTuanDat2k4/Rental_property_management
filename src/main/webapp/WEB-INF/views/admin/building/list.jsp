<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Danh Sách Tòa Nhà</title>
</head>
<body>
<div class="main-content" id="main-container">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Home</a>
                </li>
                <li class="active">Dashboard</li>
            </ul><!-- /.breadcrumb -->

        </div>

        <div class="page-content">

            <div class="page-header">
                <h1>
                    Danh sách tòa nhà
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="widget-box" style="font-family: 'Times New Roman', Times, serif;">
                    <div class="widget-header">
                        <h4 class="widget-title">Tìm kiếm</h4>

                        <span class="widget-toolbar">

									<a href="#" data-action="reload">
										<i class="ace-icon fa fa-refresh"></i>
									</a>

									<a href="#" data-action="collapse">
										<i class="ace-icon fa fa-chevron-up"></i>
									</a>

									<a href="#" data-action="close">
										<i class="ace-icon fa fa-times"></i>
									</a>
								</span>
                    </div>

                    <div class="widget-body" style="display: block;">
                        <div class="widget-main">
                            <form:form id="listForm" action="/admin/building-list" method="get"
                                       modelAttribute="modelSearch">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <label>Tên tòa nhà</label>
                                        <form:input path="name" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-6">
                                        <label>Diện tích sàn</label>
                                        <form:input path="floorArea" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-2">
                                        <label>Quận</label>
                                        <form:select path="district" cssClass="form-control">
                                            <option value="">---Chon Quan---</option>
                                            <form:options items="${district}"></form:options>
                                        </form:select>
                                    </div>

                                    <div class="col-xs-5">
                                        <label>Phường</label>
                                        <form:input path="ward" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-5">
                                        <label>Đường</label>
                                        <form:input path="street" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-4">
                                        <label>Số Tầng Hầm</label>
                                        <form:input path="numberOfBasement" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-4">
                                        <label>Hướng</label>
                                        <form:input path="direction" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-4">
                                        <label>Hạng</label>
                                        <form:input path="level" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-3">
                                        <label>Diện tích từ</label>
                                        <form:input path="areaFrom" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-3">
                                        <label>Diện tích đến</label>
                                        <form:input path="areaTo" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-3">
                                        <label>Giá thuê từ</label>
                                        <form:input path="rentPriceFrom" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-3">
                                        <label>Giá thuê đến</label>
                                        <form:input path="rentPriceTo" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-5">
                                        <label>Tên quản lý</label>
                                        <form:input path="managerName" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-5">
                                        <label>SĐT quản lý</label>
                                        <form:input path="managerPhone" cssClass="form-control"/>
                                    </div>

                                    <security:authorize access="hasRole('MANAGER')">
                                        <div class="col-xs-2">
                                            <label>Nhân viên</label>
                                            <form:select path="staffId" cssClass="form-control">
                                                <option value="">---Chon Nhan Vien---</option>
                                                <form:options items="${staffs}"/>
                                            </form:select>
                                        </div>
                                    </security:authorize>

                                    <div class="col-xs-12">
                                        <form:checkboxes path="typeCode" items="${typeCode}"/>
                                    </div>

                                    <div class="col-xs-12">
                                        <button class="btn btn-primary" id="btnSearch" type="submit">
                                            <i class="ace-icon glyphicon glyphicon-search"></i>
                                            Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>

                <div class="pull-right">
                    <a href="/admin/building-edit">
                        <button class="btn btn-app btn-primary btn-sm" title="thêm tòa nhà">
                            <i class="ace-icon fa fa-home bigger-160"></i>
                        </button>
                    </a>

                    <security:authorize access="hasRole('MANAGER')">
                        <button class="btn btn-app btn-danger btn-sm" title="xóa tòa nhà" id="btnDeleteBuilding">
                            <i class="ace-icon fa fa-trash-o bigger-160"></i>
                        </button>
                    </security:authorize>
                </div>

            </div>

            <div class="hr hr-18 dotted hr-double"></div>

            <div class="row">
                <div class="col-xs-12">
                    <display:table name="buildingList.listResult" cellspacing="0" cellpadding="0"
                                   requestURI="/admin/building-list" partialList="true" sort="external"
                                   size="${buildingList.totalItems}" defaultsort="2" defaultorder="ascending"
                                   id="tableList" pagesize="${buildingList.maxPageItems}"
                                   export="false"
                                   class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"
                                   style="margin: 3em 0 1.5em;">
                        <display:column title="<fieldset class='form-group'>
												        <input type='checkbox' id='checkAll' class='check-box-element'>
												        </fieldset>" class="center select-cell"
                                        headerClass="center select-cell">
                            <fieldset>
                                <input type="checkbox" name="checkList" value="${tableList.id}"
                                       id="checkbox_${tableList.id}" class="check-box-element"/>
                            </fieldset>
                        </display:column>
                        <display:column title="Tên tòa nhà" property="name"/>
                        <display:column title="Địa chỉ" property="address"/>
                        <display:column title="Số tầng hầm" property="numberOfBasement"/>
                        <display:column title="Tên quản lý" property="managerName"/>
                        <display:column title="SĐT quản lý" property="managerPhone"/>
                        <display:column title="Diện tích sàn" property="floorArea"/>
                        <display:column title="Diện tích thuê" property="rentArea"/>
                        <display:column title="Diện tích trống" property="emptyArea"/>
                        <display:column title="Giá thuê" property="rentPrice"/>
                        <display:column title="Phí dịch vụ" property="serviceFee"/>
                        <display:column title="Phí môi giới" property="brokerageFee"/>
                        <display:column title="Thao tác">
                            <div class="hidden-sm hidden-xs btn-group">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="btn btn-xs btn-success" onclick="assingmentBuilding(${tableList.id})"
                                            title="Giao tòa nhà">
                                        <i class="ace-icon fa fa-check bigger-120"></i>
                                    </button>
                                </security:authorize>

                                <security:authorize access="hasAnyRole('MANAGER','STAFF')">
                                    <a class="btn btn-xs btn-info" title="Sửa tòa nhà"
                                       href="/admin/building-edit-${tableList.id}">
                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                    </a>
                                </security:authorize>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="btn btn-xs btn-danger" title="Xóa tòa nhà"
                                            onclick="deleteOneBuilding(${tableList.id})">
                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                    </button>
                                </security:authorize>

                            </div>
                        </display:column>
                    </display:table>
                </div>
            </div>
        </div><!-- /.page-content -->
    </div>


    <div class="modal" id="assingmentBuildingModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Danh sách nhân viên</h5>
                </div>
                <div class="modal-body">
                    <table id="staffList" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="center">
                                <label class="pos-rel">
                                    <p class="center">Chon</p>
                                    <span class="lbl"></span>
                                </label>
                            </th>
                            <th class="center">Tên nhân viên</th>

                        </tr>
                        </thead>

                        <tbody>

                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="btnAssingmentBuilding">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <span type="hidden" id="buildingId" value=""></span>
</div><!-- /.main-container -->

<!--[if !IE]> -->
<script src="assets/js/jquery.2.1.1.min.js"></script>

<script>
    $('#btnSearch').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    })

    function assingmentBuilding(id) {
        $('#buildingId').val(id);
        loadStaff(id);
        $("#assingmentBuildingModal").modal();
    }

    function loadStaff(id) {
        $.ajax({
            url: "/admin/buildings/" + id,
            type: "GET",
            dataType: "JSON",
            success: function (respond) {
                alert(respond.message);
                var row = "";
                $.each(respond.data, function (index, item) {
                    row += '<tr>';
                    row += '<td class="center"> <label class="pos-rel"> <input type="checkbox" class="ace" value=' + item.staffId + ' ' + item.checked + '> <span class="lbl"></span> </label> </td>'
                    row += '<td class="center">' + item.fullName + '</td>'
                    row += '</tr>';
                });

                $("#staffList tbody").html(row);
            },
            error: function (respond) {
                alert("failed" + respond.responseJSON.message);
            }
        });
    }

    $('#btnAssingmentBuilding').click(function (e) {
        e.preventDefault();
        var json = {};
        json['buildingId'] = $('#buildingId').val();
        var staffIds = $('#staffList').find('tbody input[type = checkbox]:checked').map(function () {
            return $(this).val();
        }).toArray();

        json['staffIds'] = staffIds;
        if (json['buildingId'] !== "" && json['buildingId'] !== null) {
            updateAssignment(json);
        } else {
            alert("BuildingId cannot be null or empty");
        }


    })

    $('#btnDeleteBuilding').click(function (e) {
        e.preventDefault();
        var data = {};
        var ids = $('#tableList').find('tbody input[type = checkbox]:checked').map(function () {
            return $(this).val();
        }).toArray();

        data['ids'] = ids;
        if (data['ids'] !== null && data['ids'].length > 0) {
            deleteBuilding(data['ids']);
        } else {
            alert("there is not any building chosen!");
        }

    })

    function deleteOneBuilding(id) {
        deleteBuilding(id);
    }


    // AJAX
    function updateAssignment(data) {
        $.ajax({
            url: "/admin/assignment-buildings",
            type: "POST",
            data: JSON.stringify(data),
            dataType: "JSON",
            contentType: "application/json",
            success: function (respond) {
                alert(respond.message);
            },
            error: function (respond) {
                alert(respond.responseJSON.message);
            }
        });
    }


    function deleteBuilding(data) {
        $.ajax({
            url: "/admin/buildings/" + data,
            type: "DELETE",
            dataType: "JSON",
            success: function (respond) {
                alert(respond.message);
                window.location.href = "<c:url value='/admin/building-list'/>";
            },
            error: function (respond) {
                alert(respond.responseJSON.message);
            }
        });

        console.log("http://localhost:8081/admin/assignments/" + data);
    }

    // END AJAX
</script>

<!-- <![endif]-->

</body>
</html>
