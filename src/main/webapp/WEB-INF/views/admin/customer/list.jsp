<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Danh Sách Khách Hàng</title>
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
                <li class="active">Quản lý khách hàng</li>
            </ul><!-- /.breadcrumb -->

        </div>

        <div class="page-content">

            <div class="page-header">
                <h1>
                    Danh sách Khách Hàng
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="widget-box" style="font-family: 'Times New Roman', Times, serif;">
                    <div class="widget-header">
                        <h4 class="widget-title">Tìm kiếm Khách Hàng</h4>

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
                            <form:form id="listForm" action="/admin/customer-list" method="get"
                                       modelAttribute="modelSearch">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <label>Tên khách hàng</label>
                                        <form:input path="fullName" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-6">
                                        <label>Số di động</label>
                                        <form:input path="phone" cssClass="form-control"/>
                                    </div>

                                    <div class="col-xs-6">
                                        <label>Tình trạng</label>
                                        <form:select path="status" cssClass="form-control">
                                            <option value="">---Chon Quan---</option>
                                            <form:options items="${status}"></form:options>
                                        </form:select>
                                    </div>

                                    <div class="col-xs-6">
                                        <label>Email</label>
                                        <form:input path="email" cssClass="form-control"/>
                                    </div>

                                    <security:authorize access="hasRole('MANAGER')">
                                        <div class="col-xs-2">
                                            <label>Nhân viên quản lý</label>
                                            <form:select path="staffId" cssClass="form-control">
                                                <option value="">---Chon Nhan Vien---</option>
                                                <form:options items="${staffs}"/>
                                            </form:select>
                                        </div>
                                    </security:authorize>

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
                    <security:authorize access="hasAnyRole('MANAGER','STAFF')">
                        <a href="${pageContext.request.contextPath}/admin/customer-edit">
                            <button class="btn btn-app btn-primary btn-sm" title="thêm khách hàng">
                                <i class="ace-icon fa fa-home bigger-160"></i>
                            </button>
                        </a>
                    </security:authorize>

                    <security:authorize access="hasRole('MANAGER')">
                        <button class="btn btn-app btn-danger btn-sm" title="xóa khách hàng" id="btnDeleteCustomer">
                            <i class="ace-icon fa fa-trash-o bigger-160"></i>
                        </button>
                    </security:authorize>
                </div>

            </div>

            <div class="hr hr-18 dotted hr-double"></div>

            <div class="row">
                <div class="col-xs-12">
                    <display:table name="customerList.listResult" cellspacing="0" cellpadding="0"
                                   requestURI="/admin/customer-list" partialList="true" sort="external"
                                   size="${customerList.totalItems}" defaultsort="2" defaultorder="ascending"
                                   id="tableList" pagesize="${customerList.maxPageItems}"
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
                        <display:column title="Tên khách hàng" property="fullName"/>
                        <display:column title="Di động" property="phoneNumber"/>
                        <display:column title="Email" property="email"/>
                        <display:column title="Nhu cầu" property="demand"/>
                        <display:column title="Người thêm" property="createdby"/>
                        <display:column title="Ngày thêm" property="createddate"/>
                        <display:column title="Tình trạng" property="status"/>
                        <display:column title="Thao tác">
                            <div class="hidden-sm hidden-xs btn-group">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="btn btn-xs btn-success" onclick="assingmentCustomer(${tableList.id})"
                                            title="Giao khách hàng">
                                        <i class="ace-icon fa fa-check bigger-120"></i>
                                    </button>
                                </security:authorize>

                                <security:authorize access="hasAnyRole('MANAGER','STAFF')">
                                    <a class="btn btn-xs btn-info" title="Sửa khách hàng"
                                       href="/admin/customer-edit-${tableList.id}">
                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                    </a>
                                </security:authorize>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="btn btn-xs btn-danger" title="Xóa khách hàng"
                                            onclick="deleteOneCustomer(${tableList.id})">
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


    <div class="modal" id="assingmentCustomerModal">
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
                    <button type="button" class="btn btn-primary" id="btnAssingmentCustomer">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <span type="hidden" id="customerId" value=""></span>
</div><!-- /.main-container -->

<!--[if !IE]> -->
<script src="assets/js/jquery.2.1.1.min.js"></script>

<script>
    $('#btnSearch').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    })

    function assingmentCustomer(id) {
        $('#customerId').val(id);
        loadStaff(id);
        $("#assingmentCustomerModal").modal();
    }

    function loadStaff(id) {
        $.ajax({
            url: "/api/customers/" + id,
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

    $('#btnAssingmentCustomer').click(function (e) {
        e.preventDefault();
        var json = {};
        json['customerId'] = $('#customerId').val();
        var staffIds = $('#staffList').find('tbody input[type = checkbox]:checked').map(function () {
            return $(this).val();
        }).toArray();

        json['staffIds'] = staffIds;
        if (json['customerId'] !== "" && json['customerId'] !== null) {
            updateAssignment(json);
        } else {
            alert("customerId cannot be null or empty");
        }


    })

    $('#btnDeleteCustomer').click(function (e) {
        e.preventDefault();
        var data = {};
        var ids = $('#tableList').find('tbody input[type = checkbox]:checked').map(function () {
            return $(this).val();
        }).toArray();

        data['ids'] = ids;
        if (data['ids'] !== null && data['ids'].length > 0) {
            deleteCustomer(data['ids']);
        } else {
            alert("there is not any customer chosen!");
        }

    })

    function deleteOneCustomer(id) {
        deleteCustomer(id);
    }


    // AJAX
    function updateAssignment(data) {
        $.ajax({
            url: "/admin/assignment-customers",
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


    function deleteCustomer(data) {
        $.ajax({
            url: "/api/customers/" + data,
            type: "DELETE",
            dataType: "JSON",
            success: function (respond) {
                alert(respond.message);
                window.location.href = "<c:url value='/admin/customer-list'/>";
            },
            error: function (respond) {
                alert(respond.responseJSON.message);
            }
        });
    }

    // END AJAX
</script>

<!-- <![endif]-->

</body>
</html>
