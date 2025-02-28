<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Thêm tào nhà</title>
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
                    Thông tin tòa nhà
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="col-xs-12">
                    <form:form action="" cssClass="form-horizontal" role="form" id="formEdit" modelAttribute="building">
                        <form:hidden path="id"/>
                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Tên tòa nhà</label>
                            <div class="col-xs-11">
                                <form:input path="name" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Quận</label>
                            <div class="col-xs-11">
                                <form:select path="district">
                                    <option value="">---Chon Quan---</option>
                                    <form:options items="${district}"/>
                                </form:select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Phường</label>
                            <div class="col-xs-11">
                                <form:input path="ward" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Đường</label>
                            <div class="col-xs-11">
                                <form:input path="street" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Kết cấu</label>
                            <div class="col-xs-11">
                                <form:input path="structure" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Số tầng hầm</label>
                            <div class="col-xs-11">
                                <form:input path="numberOfBasement" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Diện tích sàn</label>
                            <div class="col-xs-11">
                                <form:input path="floorArea" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Hướng</label>
                            <div class="col-xs-11">
                                <form:input path="direction" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Hạng</label>
                            <div class="col-xs-11">
                                <form:input path="level" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Diện tích thuê</label>
                            <div class="col-xs-11">
                                <form:input path="rentArea" class="col-xs-8" placeholder="100,200"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Giá thuê</label>
                            <div class="col-xs-11">
                                <form:input path="rentPrice" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Mô tả giá</label>
                            <div class="col-xs-11">
                                <form:input path="rentPriceDescription" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Phí dịch vụ</label>
                            <div class="col-xs-11">
                                <form:input path="serviceFee" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Phí ô tô</label>
                            <div class="col-xs-11">
                                <form:input path="carFee" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Phí mô tô</label>
                            <div class="col-xs-11">
                                <form:input path="motoFee" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Phí ngoài giờ</label>
                            <div class="col-xs-11">
                                <form:input path="overtimeFee" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Tiền điện</label>
                            <div class="col-xs-11">
                                <form:input path="electricityFee" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Tiền nước</label>
                            <div class="col-xs-11">
                                <form:input path="waterFee" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Đặt cọc</label>
                            <div class="col-xs-11">
                                <form:input path="deposit" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Thanh toán</label>
                            <div class="col-xs-11">
                                <form:input path="payment" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Thời hạn thuê</label>
                            <div class="col-xs-11">
                                <form:input path="rentTime" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Thời gian trang trí</label>
                            <div class="col-xs-11">
                                <form:input path="decorationTime" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Tên quản lý</label>
                            <div class="col-xs-11">
                                <form:input path="managerName" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">SĐT quản lý</label>
                            <div class="col-xs-11">
                                <form:input path="managerPhone" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Loại tòa nhà</label>
                            <div class="col-xs-11">
                                <form:checkboxes path="typeCode" items="${typeCode}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Phí môi giới</label>
                            <div class="col-xs-11">
                                <form:input path="brokerageFee" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right">Ghi chú</label>
                            <div class="col-xs-11">
                                <form:input path="note" class="col-xs-8"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 no-padding-right">Hình đại diện</label>
                            <form:input path="image" class="col-xs-1 no-padding-right" type="file" id="uploadImage"/>
                            <div class="col-xs-11">
                                <c:if test="${not empty building.image}">
                                    <c:set var="imagePath" value="/repository${building.image}"/>
                                    <img src="${imagePath}" id="viewImage" width="300px" height="300px"
                                         style="margin-top: 50px">
                                </c:if>
                                <c:if test="${empty building.image}">
                                    <img src="/admin/image/default.png" id="viewImage" width="300px" height="300px">
                                </c:if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-1 control-label no-padding-right"></label>
                            <div class="col-xs-11">
                                <c:if test="${not empty building.id}">
                                    <button class="btn btn-primary" id="btnAddOrUpdateBuilding"> Sửa tòa nhà</button>
                                    <button class="btn btn-warning" id="cancelBtn" type="button"> Hủy thao tác</button>
                                </c:if>

                                <c:if test="${empty building.id}">
                                    <button class="btn btn-primary" id="btnAddOrUpdateBuilding"> Thêm tòa nhà</button>
                                    <button class="btn btn-warning" id="cancelBtn" type="button"> Hủy thao tác</button>
                                </c:if>

                            </div>
                        </div>

                    </form:form>
                </div>
            </div>

        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->

<!--[if !IE]> -->
<script src="assets/js/jquery.2.1.1.min.js"></script>

<!-- <![endif]-->

<script>
    var imageBase64 = '';
    var imageName = '';

    $("#btnAddOrUpdateBuilding").click(function (e) {
        e.preventDefault();
        var formData = $("#formEdit").serializeArray();
        var json = {};
        var typeCode = [];
        $.each(formData, function (index, it) {
            if (it.name !== "typeCode") json[it.name] = it.value;
            else typeCode.push(it.value);
            if ('' !== imageBase64) {
                json['imageBase64'] = imageBase64;
                json['imageName'] = imageName;
            }

        })
        json['typeCode'] = typeCode;

        if (json['name'] !== '' && typeCode.length !== 0 && json['rentPrice'] !== "" && json['district'] !== "") {
            addBuilding(json);
        } else {
            alert("Tên, loại tòa nhà, Quan va Gia thue không được thiếu");
        }
    })

    $('#uploadImage').change(function (event) {
        var reader = new FileReader();
        var file = $(this)[0].files[0];
        reader.onload = function (e) {
            imageBase64 = e.target.result;
            imageName = file.name; // ten hinh khong dau, khoang cach. Dat theo format sau: a-b-c
        };
        reader.readAsDataURL(file);
        openImage(this, "viewImage");
    });

    function openImage(input, imageView) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageView).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    function addBuilding(data) {
        $.ajax({
            url: "/admin/buildings",
            type: "POST",
            data: JSON.stringify(data),
            // dataType: "JSON",
            contentType: "application/json",
            success: function (respond) {
                alert(respond.message);
                window.location.href = "<c:url value='/admin/building-list'/>";
            },
            error: function (respond) {
                alert(respond.responseJSON.message);
            }
        });
    }

    $("#cancelBtn").click(function () {
        window.location.href = "<c:url value='/admin/building-list'/>";
    });
</script>

</body>
</html>
