<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
</head>

<body>
<div class="page-wrapper">
    <div class="">
        <!-- HEADER -->
        <%--<header>--%>
            <%--<!-- Begin menu  -->--%>
            <%--<div class="p-4">--%>
                <%--<div class="row navbar">--%>
                    <%--<div class="col-12 col-md-3">--%>
                        <%--<div class="logo">--%>
                            <%--<a href="">--%>
                                <%--<img src="https://bizweb.dktcdn.net/100/328/362/themes/894751/assets/logo.png?1676257083798"--%>
                                     <%--alt="">--%>
                            <%--</a>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="col-12 col-md-6">--%>
                        <%--<div class="item-menu">--%>
                            <%--<div class="nav nav1">--%>
                                <%--<div class="nav-item p-2">--%>
                                    <%--<a class="nav-item-link" href="">--%>
                                        <%--<span style="color: var(--primary-color);">Trang chủ</span>--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                                <%--<div class="nav-item p-2">--%>
                                    <%--<a href='<c:url value='/gioi-thieu'/>'>--%>
                                        <%--<span>Giới thiệu</span>--%>
                                        <%--&lt;%&ndash;<span style="color: var(--primary-color);">Giới thiệu</span>&ndash;%&gt;--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                                <%--<div class="nav-item p-2">--%>
                                    <%--&lt;%&ndash;<a class="nav-item-link" href="./Duan.html">&ndash;%&gt;--%>
                                        <%--<a href='<c:url value='/san-pham'/>'>--%>
                                        <%--<span>Sản phẩm</span>--%>
                                        <%--&lt;%&ndash;<span style="color: var(--primary-color);">Sản phẩm</span>&ndash;%&gt;--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                                <%--<div class="nav-item p-2">--%>
                                    <%--&lt;%&ndash;<a class="nav-item-link" href="./TinTuc.html">&ndash;%&gt;--%>
                                        <%--<a href='<c:url value='/tin-tuc'/>'>--%>
                                        <%--<span>Tin tức</span>--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                                <%--<div class="nav-item p-2">--%>
                                    <%--<a href='<c:url value='/lien-he'/>'>--%>
                                        <%--<span>Liên hệ</span>--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="nav-login col-12 col-md-3">--%>
                        <%--<button class="btn btn-primary px-4">--%>
                            <%--<a style="color:#fff;" href="/login">Đăng nhập</a>--%>
                        <%--</button>--%>
                        <%--<button class="btn btn-primary px-4">--%>
                            <%--Đăng ký--%>
                        <%--</button>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<!-- End menu  -->--%>
        <%--</header>--%>
        <!-- SLIDESHOW -->
        <div class="container-fluid">
            <div class="p-0">
                <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0"
                                class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                                aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                                aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div><img src="https://bizweb.dktcdn.net/100/328/362/themes/894751/assets/slider_1.png?1676257083798" alt="">
                            </div>
                            <div class="carousel-caption d-none d-md-block">
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="img-slideshow"><img src="https://media.tapchitaichinh.vn/images/upload/hoangthuviet/04202019/bat-dong-san.jpg"
                                                            alt=""></div>
                            <div class="carousel-caption d-none d-md-block">
                                <!-- <h5>Cho thuê căn hộ chung cư Saigon Mia</h5>
                                <p>. Dự án cho thuê căn hộ chung cư Saigon Mia là dự án được sử dụng dành cho các
                                    khách hàng thành đạt với sở thích và mong muốn được sống trong môi trường có
                                    nguồn không khí trong lành</p> -->
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="https://richnguyen.vn/wp-content/uploads/2020/08/buc-anh-bat-dong-san-dep-2.jpg" alt="...">
                            <div class="carousel-caption d-none d-md-block">
                                <!-- <h5>Dự án Chung cư Hòa Khánh Liên Chiểu Đà Nẵng</h5>
                                <p>Dự án xây dựng nhằm đáp ứng nhu cầu về nhà ở cho cán bộ, công nhân viên chức, các
                                    đối tượng chính sách xã hội có thu nhập thấp</p> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- SEARCH -->
        <div class="search">
            <div class="container">
                <div class="row">
                    <div class="col-12 col-md-3">
                        <div class="search-item">
                            <p class="search-text">Chọn tỉnh/thành phố</p>
                            <select class="search-option" name="search-option" id="search-option">
                                <option value>- Tỉnh/thành phố</option>
                                <option value="">TP.Hà Nội</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12 col-md-3">
                        <div class="search-item">
                            <p class="search-text">Chọn quận/huyện</p>
                            <select class="search-option" name="search-option" id="search-option">
                                <option value>--Chọn quận--</option>
                                <c:forEach var="item" items="${districts}">
                                    <option value="">${item.value}</option>>
                                        <%--<td>${item.value}</td>--%>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-12 col-md-3">
                        <div class="search-item">
                            <p class="search-text">Chọn loại bất động sản</p>
                            <select class="search-option" name="search-option" id="search-option">
                                <option value>- Loại bất động sản</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12 col-md-3 ">
                        <div class="search-btn">
                            <button class="search-btn-text">
                                <i class="fa-solid fa-magnifying-glass search-btn-icon"></i>
                                <span>Tìm kiếm nhanh</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <footer class="footer">
            <div class="container-fluid">
                <div class="top-footer text-center mt-0">
                    <div class="logo logo-footer pt-5">
                        <a href="./ViewHome.html"><img src="https://bizweb.dktcdn.net/100/328/362/themes/894751/assets/logo_footer.png?1676257083798"
                                                       alt="logo-footer"></a>
                        <p class="desc-logo-footer mt-3">Với hơn 10 năm kinh nghiệm, SkyLand tự hào là sàn
                            mua
                            bán, giao dịch và quảng cáo
                            bất động sản hàng đầu tại Việt Nam</p>
                        <div class="item-footer mt-5">
                            <div class="row">
                                <div class="col-12 col-md-4 text-center">
                                    <div class="icon-footer">
                                        <img src="https://bizweb.dktcdn.net/100/328/362/themes/894751/assets/place_maps.png?1676257083798" alt="">
                                    </div>
                                    <div class="content-center-footer">
                                        <p class="mb-1 mt-3">Trụ sở chính</p>
                                        <p class="desc-footer">Số 46 Man Thiện, TP Thủ Đức, TP HCM</p>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4 text-center">
                                    <div class="icon-footer">
                                        <img src="https://bizweb.dktcdn.net/100/328/362/themes/894751/assets/place_phone.png?1676257083798" alt="">
                                    </div>
                                    <div class="content-center-footer">
                                        <p class="mb-1 mt-3">Hotline</p>
                                        <p class="desc-footer"><a class="a-text" href="#">098828</a></p>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4 text-center">
                                    <div class="icon-footer">
                                        <img src="https://bizweb.dktcdn.net/100/328/362/themes/894751/assets/place_email.png?1676257083798" alt="">
                                    </div>
                                    <div class="content-center-footer">
                                        <p class="mb-1 mt-3">Email</p>
                                        <p class="desc-footer"><a class="a-text" href="#">vsh@gmail.com</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <div class="border-bottom mb-5 mt-4"></div>
                    </div>
                </div>
                <div class="bottom-footer container">
                    <div class="row">
                        <div class="col-12 col-md-3">
                            <h4 class="title-item-bottom-footer">Thông tin công ty</h4>
                            <p class="desc-item-bottom-footer desc-1"><a class="a-text" href="">Trang
                                chủ</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Giới thiệu</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Dự án bất động
                                sản</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Tin tức</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Liên hệ</a></p>
                        </div>
                        <div class="col-12 col-md-3">
                            <h4 class="title-item-bottom-footer">Chính sách hoạt động</h4>
                            <p class="desc-item-bottom-footer desc-1"><a class="a-text" href="">Trang
                                chủ</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Giới thiệu</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Dự án bất động
                                sản</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Tin tức</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Liên hệ</a></p>
                        </div>
                        <div class="col-12 col-md-3">
                            <h4 class="title-item-bottom-footer">Hỗ trợ khách hàng</h4>
                            <p class="desc-item-bottom-footer desc-1"><a class="a-text" href="">Trang
                                chủ</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Giới thiệu</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Dự án bất động
                                sản</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Tin tức</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Liên hệ</a></p>
                        </div>
                        <div class="col-12 col-md-3">
                            <h4 class="title-item-bottom-footer">Kết nối với chúng tôi</h4>
                            <p class="desc-item-bottom-footer desc-1"><a class="a-text" href="">Trang
                                chủ</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Giới thiệu</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Dự án bất động
                                sản</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Tin tức</a></p>
                            <p class="desc-item-bottom-footer"><a class="a-text" href="">Liên hệ</a></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bottom-footer-2">
                <div class="text-center desc-bottom-footer-2">@ Bản quyền thuộc về Happy Team |
                    Cung cấp bởi <a class="a-text group-name" href="#">HappyTeam</a></div>
            </div>
        </footer>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</body>

</html>