<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Thêm khách hàng</title>
</head>
<body>
<div class="main-content">
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
                    Thông tin khách hàng
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="col-xs-12">
                    <form:form action="" cssClass="form-horizontal" role="form" id="formEdit" modelAttribute="customer">
                        <form:hidden path="id"/>
                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Tên khách hàng</label>
                            <div class="col-xs-11">
                                <form:input path="name" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Số điện thoại</label>
                            <div class="col-xs-11">
                                <form:input path="customerPhone" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Email</label>
                            <div class="col-xs-11">
                                <form:input path="email" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Tên công ty</label>
                            <div class="col-xs-11">
                                <form:input path="companyName" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Nhu cầu</label>
                            <div class="col-xs-11">
                                <form:input path="demand" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Trang thai</label>
                            <div class="col-xs-11">
                                <form:select path="status">
                                    <form:options items="${status}"/>
                                </form:select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right"></label>
                            <div class="col-xs-11">
                                <c:if test="${not empty customer.id}">
                                    <button class="btn btn-primary" id="btnAddOrUpdateCustomer"> Sửa khách hàng</button>
                                    <button class="btn btn-warning" id="cancelBtn" type="button"> Hủy thao tác</button>
                                </c:if>

                                <c:if test="${empty customer.id}">
                                    <button class="btn btn-primary" id="btnAddOrUpdateCustomer"> Thêm khách hàng
                                    </button>
                                    <button class="btn btn-warning" id="cancelBtn" type="button"> Hủy thao tác</button>
                                </c:if>

                            </div>
                        </div>

                    </form:form>
                </div>
            </div>

            <c:if test="${not empty customer.id}">
                <c:forEach var="item" items="${transactionType}">
                    <div class="col-xl-12">
                        <h2>
                                ${item.value}
                            <button class="btn btn-md btn-success pull-right" title="Them giao dich"
                                    onclick="addTransaction('${item.key}', ${customer.id})">
                                <i class="ace-icon glyphicon glyphicon-plus smaller-80"></i>Thêm giao dịch
                            </button>
                        </h2>
                        <div class="hr hr-16 dotted hr-dotted"></div>
                    </div>

                    <c:if test="${item.key == 'CSKH'}">
                        <div class="col-xl-12" style="margin-bottom: 24px">
                            <table id="tableList-CSKH" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr class="center">
                                    <th class="center">Ngày tao</th>
                                    <th class="center">Người tao</th>
                                    <th class="center">Ngày sửa</th>
                                    <th class="center">Người sửa</th>
                                    <th class="center">Chi tiết giao dịch</th>
                                    <th class="center">Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="transaction" items="${CSKH}">
                                    <tr class="center">
                                        <td>${transaction.createdDate}</td>
                                        <td>${transaction.createdBy}</td>
                                        <td>${transaction.modifiedDate}</td>
                                        <td>${transaction.modifiedBy}</td>
                                        <td>${transaction.note}</td>
                                        <td class="center">
                                            <div class="hidden-sm hidden-xs center">
                                                <button class="btn btn-sm btn-info"
                                                        title="Chỉnh sủa giao dịch" type="button"
                                                        onclick="updateTransaction('CSKH', ${customer.id}, ${transaction.id})">
                                                    <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                </button>

<%--                                                <security:authorize access="hasRole('MANAGER')">--%>
<%--                                                    <button class="btn btn-sm btn-danger"--%>
<%--                                                            type="button" title="xóa giao dịch"--%>
<%--                                                            onclick="deleteTransaction('CSKH', ${customer.id}, ${transaction.id})"--%>
<%--                                                    >--%>
<%--                                                        <i class="ace-icon glyphicon glyphicon-trash"></i>--%>
<%--                                                    </button>--%>
<%--                                                </security:authorize>--%>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                    <c:if test="${item.key == 'DDX'}">
                        <div class="col-xl-12" style="margin-bottom: 24px">
                            <table id="tableList-DDX" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr class="center">
                                    <th class="center">Ngày tao</th>
                                    <th class="center">Người tao</th>
                                    <th class="center">Ngày sửa</th>
                                    <th class="center">Người sửa</th>
                                    <th class="center">Chi tiết giao dịch</th>
                                    <th class="center">Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="transaction" items="${DDX}">
                                    <tr class="center">
                                        <td>${transaction.createdDate}</td>
                                        <td>${transaction.createdBy}</td>
                                        <td>${transaction.modifiedDate}</td>
                                        <td>${transaction.modifiedBy}</td>
                                        <td>${transaction.note}</td>
                                        <td class="center">
                                            <div class="hidden-sm hidden-xs center">
                                                <button class="btn btn-sm btn-info"
                                                        title="Chỉnh sủa giao dịch" type="button"
                                                        onclick="updateTransaction('DDX', ${customer.id}, ${transaction.id})">
                                                    <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                </button>

<%--                                                <security:authorize access="hasRole('MANAGER')">--%>
<%--                                                    <button class="btn btn-sm btn-danger"--%>
<%--                                                            type="button" title="xóa giao dịch"--%>
<%--                                                            onclick="deleteTransaction('DDX', ${customer.id}, ${transaction.id})"--%>
<%--                                                    >--%>
<%--                                                        <i class="ace-icon glyphicon glyphicon-trash"></i>--%>
<%--                                                    </button>--%>
<%--                                                </security:authorize>--%>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>

        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->

<div class="modal fade" id="transanctionModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title bolder blue" id="exampleModalLabel">Nhập thông tin giao dịch</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right">Chi tiết giao dịch</label>
                    <div class="col-sm-9">
                        <input id="note" value=""/>
                    </div>
                </div>
                <input type="hidden" id="customerId" value="">
                <input type="hidden" id="code" value="">
                <input type="hidden" id="transactionId" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnAddOrUpdateTransaction">Xác nhận</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!--[if !IE]> -->
<script src="assets/js/jquery.2.1.1.min.js"></script>

<!-- <![endif]-->

<script>
    function addTransaction(code, customerId) {
        $('#transanctionModal').modal();
        $('#note').val('');
        $('#customerId').val(customerId);
        $('#code').val(code);
    }

    function updateTransaction(code, customerId, transactionId) {
        $('#transanctionModal').modal();
        loadTransaction(transactionId);
        $('#customerId').val(customerId);
        $('#code').val(code);
        $('#transactionId').val(transactionId);
    }

    function loadTransaction(transactionId) {
        $.ajax({
            url: "/api/transactions/" + transactionId,
            type: "GET",
            dataType: "JSON",
            success: function (respond) {
                $('#note').val(respond.data);
            },
            error: function (respond) {
                alert("failed" + respond.responseJSON.message);
            }
        });
    }

    $('#btnAddOrUpdateTransaction').click(function (e) {
        e.preventDefault();
        var data={};
        data['id'] = $('#transactionId').val();
        data['code'] = $('#code').val();
        data['note'] = $('#note').val();
        data['customerId'] = $('#customerId').val();
        if(data['note'] !== ''){
            handleAddOrUpdateTransaction(data);
        } else {
            $('#note').attr('placeholder', 'Vui lòng diền thông tin chi tiết giao dịch');
        }
    })

    $("#btnAddOrUpdateCustomer").click(function (e) {
        e.preventDefault();
        var formData = $("#formEdit").serializeArray();
        var json = {};
        $.each(formData, function (index, it) {
            json[it.name] = it.value;
        })

        if (json['name'] !== '' && json['customerPhone'] !== "" && json['status'] !== "") {
            addCustomer(json);
        } else {
            alert("Tên, số điện thoại, va trạng thái không được thiếu");
        }
    })

    function addCustomer(data) {
        $.ajax({
            url: "/api/customers",
            type: "POST",
            data: JSON.stringify(data),
            // dataType: "JSON",
            contentType: "application/json",
            success: function (respond) {
                alert(respond.message);
                window.location.href = "<c:url value='/admin/customer-list'/>";
            },
            error: function (respond) {
                alert(respond.responseJSON.message);
            }
        });
    }

    function handleAddOrUpdateTransaction(data) {
        $.ajax({
            url: "/api/transactions",
            type: "POST",
            data: JSON.stringify(data),
            // dataType: "JSON",
            contentType: "application/json",
            success: function (respond) {
                alert(respond.message);
                window.location.href = "<c:url value='/admin/customer-edit-${customer.id}'/>";
            },
            error: function (respond) {
                alert(respond.responseJSON.message);
            }
        })
    }

    $("#cancelBtn").click(function () {
        window.location.href = "<c:url value='/admin/customer-list'/>";
    });

</script>

</body>
</html>
