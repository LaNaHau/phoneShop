<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <base href="${pageContext.servletContext.contextPath}/">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sản Phẩmdddddd</title>

        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <link rel="stylesheet" href='<c:url value="/assets/css/product.css"/>' />

        <link href="assets/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href='<c:url value="/assets/css/font-awesome.css"/>' />
        <!-- Bootstrap -->
        <link rel="stylesheet" href='<c:url value="/assets/css/bootstrap.css"/>' />
        <!-- SmartMenus jQuery Bootstrap Addon CSS -->
        <link rel="stylesheet" href='<c:url value="/assets/css/jquery.smartmenus.bootstrap.css"/>' />
        <!-- Product view slider -->
        <link rel="stylesheet" href='<c:url value="/assets/css/jquery.simpleLens.css"/>' />
        <!-- slick slider -->
        <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/slick.css"/>' />
        <!-- price picker slider -->
        <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/nouislider.css"/>' />
        <!-- Theme color -->
        <link id="switcher" rel="stylesheet" href='<c:url value="/assets/css/theme-color/default-theme1.css"/>' />
        <!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
        <!-- Top Slider CSS -->
        <link media="all" rel="stylesheet" href='<c:url value="/assets/css/sequence-theme.modern-slide-in.css"/>' />

        <!-- Main style sheet -->
        <link rel="stylesheet" href='<c:url value="/assets/css/style.css"/>' />

        <!-- Google Font -->
        <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>


        <script>
            const contextPath = "${pageContext.servletContext.contextPath}"; // Context path của ứng dụng
            const tenSanPham = "${sanPham.tenSanPham}"; // Tên sản phẩm
            const soLuongSanPham = "${sanPham.soLuong}"; // Số lượng sản phẩm
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


        <script src="<c:url value='assets/js/sanPham.js'/>"></script>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>

    <body>
        <!-- SCROLL TOP BUTTON -->
        <a class="scrollToTop" href="#"><i class="fa fa-chevron-up"></i></a>
        <!-- END SCROLL TOP BUTTON -->
        <!-- HEADER -->

        <%@ include file="../include/header.jsp"%>


        <section id="aa-product-details">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="aa-product-details-area">
                            <div class="aa-product-details-content">
                                <div class="row">

                                    <!-- Tieu de -->
                                    <div class="container">
                                        <div>
                                            <ol class="breadcrumb">
                                                <li><a href="${pageContext.servletContext.contextPath}/">Trang
                                                        chủ</a></li>
                                                <li><a href="${pageContext.servletContext.contextPath}/shop.htm">Sản
                                                        phẩm</a></li>
                                                <li class="active"><a href="shop/${sanPham.maKieu.loai.maLoai}.htm">${sanPham.maKieu.loai.tenLoai}</a></li>
                                                <li class="active"><a href="shop/${sanPham.maKieu.loai.maLoai}/${sanPham.maKieu.maKieu}.htm">${sanPham.maKieu.tenKieu}</a></li>
                                            </ol>
                                        </div>
                                    </div>

                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                        <div class="aa-product-view-slider">
                                            <div id="demo-1" class="simpleLens-gallery-container">
                                                <div class="simpleLens-container">
                                                    <div class="simpleLens-big-image-container">
                                                        <a id="mainImageLink" data-lens-image="${sanPham.hinhAnh.link}" class="simpleLens-lens-image"> <img id="mainImage" style="width: 350px; height: 420px;" src="${sanPham.hinhAnh.link}" class="simpleLens-big-image">
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- Modal view content -->
                                    <div class="col-md-7 col-sm-7 col-xs-12">
                                        <div class="aa-product-view-content">
                                            <h1 class="mt-3" style="font-size: 2rem; font-weight: bold; color: #333;">${sanPham.tenSanPham}</h1>
                                            <div class="product-rating-stars">
                                                <c:if test="${sanPham.soSaoTB == 0}">
                                                    <span class="soSaotb" id="soSaoTB"><i>Chưa có
                                                            đánh giá</i></span>
                                                </c:if>
                                                <c:if test="${sanPham.soSaoTB > 0}">
                                                    <span class="soSaotb" id="soSaoTB"><i>Đánh giá:
                                                            ${sanPham.soSaoTB}/5 <i class="fas fa-star"></i>
                                                        </i></span>
                                                </c:if>
                                                <c:if test="${sanPham.giamGia != null && sanPham.giamGia > 0}">
                                                    <br>
                                                    <!-- Add a line break before the "Ưu đãi" -->
                                                    <span class="soSaotb" id="giamGia"><i>Ưu đãi:
                                                            ${sanPham.giamGia} %</i></span>
                                                </c:if>
                                            </div>


                                            <c:if test="${sanPham.trangThai==true }">

                                                <h5 id="soLuongOnProduct" style="padding-top: 3px;">
                                                    Còn lại: <i>${sanPham.soLuong}</i>
                                                </h5>


                                                <c:if test="${sanPham.giamGia != null && sanPham.giamGia > 0}">
                                                    <div class="fs-5 my-3 gia">
                                                        <!-- Giá khuyến mãi -->
                                                        <span id="giaKhuyenMai" style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal;">
                                                            <fmt:formatNumber value="${sanPham.donGia * (1 - sanPham.giamGia / 100.0)}" pattern="#,##0" />đ
                                                        </span>
                                                        <!-- Giá gốc -->
                                                        <span id="giaGoc" style="font-size: 1.125rem; text-decoration: line-through; color: #999; margin-left: 10px;">
                                                            <fmt:formatNumber value="${sanPham.donGia}" pattern="#,##0" />đ
                                                        </span>
                                                        <span id="giaChuan1" style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal;display: none;">
                                                            <fmt:formatNumber value="${sanPham.donGia}" pattern="#,##0" />đ
                                                        </span>

                                                    </div>
                                                </c:if>

                                                <c:if test="${sanPham.giamGia == null || sanPham.giamGia == 0}">
                                                    <div class="fs-5 my-3 gia">
                                                        <!-- Hiển thị chỉ giá gốc nếu không giảm giá -->
                                                        <span id="giaChuan1" style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal;display: none;">
                                                            <fmt:formatNumber value="${sanPham.donGia}" pattern="#,##0" />đ
                                                        </span>
                                                        <span id="giaKhuyenMai" style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal;display: none;">
                                                            <fmt:formatNumber value="${sanPham.donGia * (1 - sanPham.giamGia / 100.0)}" pattern="#,##0" />đ
                                                        </span>
                                                        <!-- Giá gốc -->
                                                        <span id="giaGoc" style="font-size: 1.125rem; text-decoration: line-through; color: #999; margin-left: 10px;">
                                                            <fmt:formatNumber value="${sanPham.donGia}" pattern="#,##0" />đ
                                                        </span>
                                                    </div>
                                                </c:if>
                                                <f:form action="themVaoGio/${sanPham.maSP}.htm" method="post">

                                                    <!-- Input ẩn cho mã sản phẩm -->
                                                    <input type="hidden" name="maSP" id="themFormMaSP" value="${sanPham.maSP}" />

                                                    <!-- Tùy chọn Số lượng -->
                                                    <div class="d-flex align-items-center">
                                                        <h4>Số lượng</h4>
                                                        <input class="form-control text-center me-3" id="inputQuantity" type="number" name="soLuong" value="1" min="1" inputmode="numeric" autocomplete="off" max="${sanPham.soLuong}" style="width: 90px" />
                                                    </div>

                                                    <!-- Tùy chọn Bộ nhớ -->
                                                    <div class="mt-3">
                                                        <h5>Chọn bộ nhớ</h5>
                                                        <div id="boNhoOptions">
                                                            <c:forEach items="${boNhoList}" var="boNho">
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" name="boNho" id="boNho-${boNho}" value="${boNho}">
                                                                    <label class="form-check-label" for="boNho-${boNho}">
                                                                        ${boNho} </label>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>



                                                    <!-- Tùy chọn Màu sắc -->
                                                    <div class="mt-3">
                                                        <h5>Chọn màu sắc</h5>
                                                        <div id="mauSacOptions">
                                                            <c:forEach items="${mauSacList}" var="mauSac">
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" name="mauSac" id="mauSac-${mauSac}" value="${mauSac}" onchange="updateProductImage('${sanPham.tenSanPham}', this.value)">
                                                                    <label class="form-check-label" for="mauSac-${mauSac}">
                                                                        ${mauSac} </label>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>



                                                    <script>
                                                        $(document)
                                                            .ready(
                                                                function() {
                                                                    // Khi người dùng thay đổi lựa chọn màu sắc
                                                                    $(
                                                                            'input[name="mauSac"]')
                                                                        .change(
                                                                            function() {
                                                                                // Nếu có ít nhất 1 màu sắc được chọn, bỏ chọn tất cả các tùy chọn khác
                                                                                $(
                                                                                        'input[name="mauSac"]')
                                                                                    .not(
                                                                                        this)
                                                                                    .prop(
                                                                                        'checked',
                                                                                        false);

                                                                                var selectedColors = $(
                                                                                        'input[name="mauSac"]:checked')
                                                                                    .map(
                                                                                        function() {
                                                                                            return $(
                                                                                                    this)
                                                                                                .val();
                                                                                        })
                                                                                    .get(); // Lấy danh sách màu sắc đã chọn

                                                                                if (selectedColors.length > 0) {
                                                                                    var tenSanPham = '${sanPham.tenSanPham}';
                                                                                    $
                                                                                        .ajax({
                                                                                            url: contextPath +
                                                                                                '/product/getBoNho',
                                                                                            type: 'GET',
                                                                                            data: {
                                                                                                tenSanPham: tenSanPham,
                                                                                                mauSac: selectedColors
                                                                                                    .join(',')
                                                                                                // Gửi danh sách màu sắc đã chọn
                                                                                            },
                                                                                            success: function(
                                                                                                response) {
                                                                                                var boNhoOptions = $('#boNhoOptions .form-check');
                                                                                                var validMemories = response; // Danh sách bộ nhớ hợp lệ cho màu sắc đã chọn
                                                                                                console
                                                                                                    .log(
                                                                                                        "Response:",
                                                                                                        response);
                                                                                                boNhoOptions
                                                                                                    .each(function() {
                                                                                                        var currentOption = $(this);
                                                                                                        var currentMemory = currentOption
                                                                                                            .find(
                                                                                                                'input')
                                                                                                            .val();

                                                                                                        if (validMemories
                                                                                                            .indexOf(currentMemory) === -1) {
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'label')
                                                                                                                .css(
                                                                                                                    'color',
                                                                                                                    '#ccc'); // Đổi màu chữ
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'input')
                                                                                                                .prop(
                                                                                                                    'disabled',
                                                                                                                    true);
                                                                                                        } else {
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'label')
                                                                                                                .css(
                                                                                                                    'color',
                                                                                                                    ''); // Reset màu chữ
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'input')
                                                                                                                .prop(
                                                                                                                    'disabled',
                                                                                                                    false);
                                                                                                        }
                                                                                                    });
                                                                                            }
                                                                                        });
                                                                                } else {
                                                                                    var boNhoOptions = $('#boNhoOptions .form-check');
                                                                                    boNhoOptions
                                                                                        .each(function() {
                                                                                            var currentOption = $(this);
                                                                                            currentOption
                                                                                                .find(
                                                                                                    'label')
                                                                                                .css(
                                                                                                    'color',
                                                                                                    ''); // Reset màu chữ
                                                                                            currentOption
                                                                                                .find(
                                                                                                    'input')
                                                                                                .prop(
                                                                                                    'disabled',
                                                                                                    false);
                                                                                        });
                                                                                }
                                                                            });

                                                                    // Khi người dùng thay đổi lựa chọn bộ nhớ
                                                                    $(
                                                                            'input[name="boNho"]')
                                                                        .change(
                                                                            function() {
                                                                                // Nếu có ít nhất 1 bộ nhớ được chọn, bỏ chọn tất cả các tùy chọn khác
                                                                                $(
                                                                                        'input[name="boNho"]')
                                                                                    .not(
                                                                                        this)
                                                                                    .prop(
                                                                                        'checked',
                                                                                        false);

                                                                                var selectedMemories = $(
                                                                                        'input[name="boNho"]:checked')
                                                                                    .map(
                                                                                        function() {
                                                                                            return $(
                                                                                                    this)
                                                                                                .val();
                                                                                        })
                                                                                    .get(); // Lấy danh sách bộ nhớ đã chọn

                                                                                if (selectedMemories.length > 0) {
                                                                                    var tenSanPham = '${sanPham.tenSanPham}';
                                                                                    $
                                                                                        .ajax({
                                                                                            url: contextPath +
                                                                                                '/product/getMauSac',
                                                                                            type: 'GET',
                                                                                            data: {
                                                                                                tenSanPham: tenSanPham,
                                                                                                boNho: selectedMemories
                                                                                                    .join(',')
                                                                                                // Gửi danh sách bộ nhớ đã chọn
                                                                                            },
                                                                                            success: function(
                                                                                                response) {
                                                                                                var mauSacOptions = $('#mauSacOptions .form-check');
                                                                                                var validColors = response; // Danh sách màu sắc hợp lệ cho bộ nhớ đã chọn
                                                                                                console
                                                                                                    .log(
                                                                                                        "Response:",
                                                                                                        response);
                                                                                                mauSacOptions
                                                                                                    .each(function() {
                                                                                                        var currentOption = $(this);
                                                                                                        var currentColor = currentOption
                                                                                                            .find(
                                                                                                                'input')
                                                                                                            .val();

                                                                                                        if (validColors
                                                                                                            .indexOf(currentColor) === -1) {
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'label')
                                                                                                                .css(
                                                                                                                    'color',
                                                                                                                    '#ccc'); // Đổi màu chữ
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'input')
                                                                                                                .prop(
                                                                                                                    'disabled',
                                                                                                                    true);
                                                                                                        } else {
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'label')
                                                                                                                .css(
                                                                                                                    'color',
                                                                                                                    ''); // Reset màu chữ
                                                                                                            currentOption
                                                                                                                .find(
                                                                                                                    'input')
                                                                                                                .prop(
                                                                                                                    'disabled',
                                                                                                                    false);
                                                                                                            /*                                                                                    // Cập nhật giá trị khuyến mãi
                                                                                                                                                                                               if (giamGia != null && giamGia > 0) {
                                                                                                                                                                                                   // Cập nhật giá khuyến mãi
                                                                                                                                                                                                   var giaKhuyenMai = donGia * (1 - giamGia / 100.0);
                                                                                                                                                                                                   $('#giaKhuyenMai').html('<span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d;">' +
                                                                                                                                                                                                       giaKhuyenMai.toLocaleString() + 'đ</span>');
                                                                                                                                                                                                   
                                                                                                                                                                                                   // Cập nhật giá gốc
                                                                                                                                                                                                   $('#giaGoc').html('<span style="font-size: 1.125rem; text-decoration: line-through; color: #999;">' +
                                                                                                                                                                                                       donGia.toLocaleString() + 'đ</span>');
                                                                                                                                                                                               } else {
                                                                                                                                                                                                   // Nếu không có giảm giá, chỉ hiển thị giá gốc
                                                                                                                                                                                                   $('#giaGoc2').html('<span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d;">' +
                                                                                                                                                                                                       donGia.toLocaleString() + 'đ</span>');
                                                                                                                                                                                               }      */
                                                                                                        }
                                                                                                    });
                                                                                            }
                                                                                        });
                                                                                } else {
                                                                                    var mauSacOptions = $('#mauSacOptions .form-check');
                                                                                    mauSacOptions
                                                                                        .each(function() {
                                                                                            var currentOption = $(this);
                                                                                            currentOption
                                                                                                .find(
                                                                                                    'label')
                                                                                                .css(
                                                                                                    'color',
                                                                                                    ''); // Reset màu chữ
                                                                                            currentOption
                                                                                                .find(
                                                                                                    'input')
                                                                                                .prop(
                                                                                                    'disabled',
                                                                                                    false);
                                                                                        });
                                                                                }
                                                                            });
                                                                });

                                                        //<!--js cap nhat anh khi chon mau sac-- >
                                                        function updateProductImage(
                                                            tenSanPham) {
                                                            // Lấy các giá trị được chọn
                                                            let selectedColor = $(
                                                                    'input[name="mauSac"]:checked')
                                                                .val();
                                                            let selectedMemory = $(
                                                                    'input[name="boNho"]:checked')
                                                                .val();

                                                            // Kiểm tra nếu người dùng chưa chọn đầy đủ thuộc tính
                                                            if (!selectedColor ||
                                                                !selectedMemory) {
                                                                console
                                                                    .log("Vui lòng chọn đầy đủ màu sắc và bộ nhớ.");
                                                                return;
                                                            }

                                                            // Gửi AJAX để lấy hình ảnh phù hợp
                                                            $
                                                                .ajax({
                                                                    url: contextPath +
                                                                        '/product/getImageByAttributes',
                                                                    type: 'GET',
                                                                    data: {
                                                                        tenSanPham: tenSanPham,
                                                                        mauSac: selectedColor,
                                                                        boNho: selectedMemory
                                                                    },
                                                                    success: function(
                                                                        response) {
                                                                        var imageLink = response.imageLink;
                                                                        var maSP = response.maSP; // Lấy mã sản phẩm từ response
                                                                        var soLuong = response.soLuong;
                                                                        var giamGia = response.giamGia;
                                                                        var donGia = response.donGia;
                                                                        var mauSac = response.mauSac; // Màu sắc từ response
                                                                        console.log(soLuong)
                                                                        // Cập nhật mã sản phẩm vào input ẩn
                                                                        $(
                                                                                '#themFormMaSP')
                                                                            .val(
                                                                                maSP);

                                                                        // Cập nhật lại action của form với maSP mới
                                                                        var formAction = 'themVaoGio/' +
                                                                            maSP +
                                                                            '.htm';
                                                                        $(
                                                                                'form[action^="themVaoGio"]')
                                                                            .attr(
                                                                                'action',
                                                                                formAction);

                                                                        // Cập nhật ảnh nếu có hình ảnh mới
                                                                        if (imageLink) {
                                                                            $(
                                                                                    '#mainImageLink')
                                                                                .attr(
                                                                                    'data-lens-image',
                                                                                    imageLink);
                                                                            $(
                                                                                    '#mainImage')
                                                                                .attr(
                                                                                    'src',
                                                                                    imageLink);
                                                                        } else {
                                                                            console
                                                                                .log("Không tìm thấy hình ảnh cho thuộc tính đã chọn.");
                                                                        }

                                                                        // Cập nhật số lượng sản phẩm còn lại
                                                                        $(
                                                                                '#soLuongOnProduct')
                                                                            .html(
                                                                                'Còn lại: <i>' +
                                                                                soLuong +
                                                                                '</i>');



                                                                        // Kiểm tra nếu có giảm giá
                                                                        console.log("donGia", donGia)
                                                                        console.log("giamGia", giamGia)
                                                                        if (giamGia != null && giamGia > 0) {
                                                                            // Tính giá khuyến mãi
                                                                            var giaKhuyenMai = donGia * (1 - giamGia / 100.0);

                                                                            // Hiển thị giá khuyến mãi và giá gốc
                                                                            $('#giaKhuyenMai').html('<span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d;">' + formatCurrency(giaKhuyenMai) + '</span>');
                                                                            $('#giaGoc').html('<span style="font-size: 1.125rem; text-decoration: line-through; color: #999;">' + formatCurrency(donGia) + '</span>');

                                                                            // Cập nhật display cho giá khuyến mãi và giá gốc
                                                                            $('#giaKhuyenMai').css('display', 'inline'); // Hiển thị giá khuyến mãi
                                                                            $('#giaGoc').css('display', 'inline'); // Hiển thị giá gốc

                                                                            // Ẩn giá chuẩn (không có giảm giá)
                                                                            $('#giaChuan1').css('display', 'none');
                                                                            $('#giaChuan1').html('');
                                                                        } else {
                                                                            // Nếu không có giảm giá, chỉ hiển thị giá gốc
                                                                            $('#giaChuan1').html('<span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d;">' + formatCurrency(donGia) + '</span>');

                                                                            // Cập nhật display cho giá chuẩn
                                                                            $('#giaChuan1').css('display', 'inline'); // Hiển thị giá chuẩn

                                                                            // Ẩn giá khuyến mãi và giá gốc
                                                                            $('#giaKhuyenMai').css('display', 'none');
                                                                            $('#giaGoc').css('display', 'none');

                                                                            // Xóa nội dung của giá khuyến mãi và giá gốc khi không có giảm giá
                                                                            $('#giaKhuyenMai').html('');
                                                                            $('#giaGoc').html('');
                                                                        }


                                                                        // Kiểm tra nếu có giảm giá
                                                                        if (giamGia != null && giamGia > 0) {
                                                                            // Cập nhật thông tin ưu đãi
                                                                            $('#giamGia').html('<i>Ưu đãi: ' + giamGia + ' %</i>');
                                                                        } else {
                                                                            // Nếu không có giảm giá, ẩn phần ưu đãi
                                                                            $('#giamGia').html('');
                                                                        }
                                                                        // Cập nhật màu sắc và bộ nhớ trong
                                                                        $(
                                                                                '#mauSac')
                                                                            .html(
                                                                                mauSac); // Hiển thị màu sắc
                                                                        $(
                                                                                '#CTboNhoTrong')
                                                                            .html(
                                                                                response.boNho); // Hiển thị bộ nhớ trong

                                                                        // Cập nhật danh sách đánh giá
                                                                        var danhGiaListHtml = '';
                                                                        if (response.danhGia &&
                                                                            response.danhGia.length > 0) {
                                                                            response.danhGia
                                                                                .forEach(function(
                                                                                    danhGia) {
                                                                                    var starHtml = '';
                                                                                    for (var i = 1; i <= 5; i++) {
                                                                                        if (i <= danhGia.soSao) {
                                                                                            starHtml += '<i class="fas fa-star"></i>';
                                                                                        } else {
                                                                                            starHtml += '<i class="far fa-star"></i>';
                                                                                        }
                                                                                    }
                                                                                    danhGiaListHtml += '<li>' +
                                                                                        '<div class="media">' +
                                                                                        '    <div class="media-left">' +
                                                                                        '        <a href="#">' +
                                                                                        '            <img style="height: 70px; width: 70px;" class="media-object" src="assets/img/avatar.png" alt="avatar user">' +
                                                                                        '        </a>' +
                                                                                        '    </div>' +
                                                                                        '    <div class="media-body">' +
                                                                                        '        <h4 class="media-heading"><strong>' +
                                                                                        danhGia.nguoiDung +
                                                                                        '</strong> <span>' +
                                                                                        danhGia.ngay +
                                                                                        '</span></h4>' +
                                                                                        '        <div class="comment-rank c-support">' +
                                                                                        starHtml +
                                                                                        '</div>' +
                                                                                        '        <p>' +
                                                                                        danhGia.noiDung +
                                                                                        '</p>' +
                                                                                        '    </div>' +
                                                                                        '</div>' +
                                                                                        '</li>';
                                                                                });
                                                                        } else {
                                                                            danhGiaListHtml = '<li><p>Chưa có đánh giá nào.</p></li>';
                                                                        }

                                                                        $(
                                                                                '#review .aa-review-nav')
                                                                            .html(
                                                                                danhGiaListHtml);

                                                                        // Cập nhật thông tin đánh giá trung bình
                                                                        var soSaoTB = response.soSaoTB;
                                                                        if (soSaoTB > 0) {
                                                                            $(
                                                                                    '#review .product-rating-stars')
                                                                                .html(
                                                                                    '<span class="rating-count">Có ' +
                                                                                    response.danhGia.length +
                                                                                    ' đánh giá</span><br>' +
                                                                                    '<span class="soSaotb"><i>Đánh giá trung bình: ' +
                                                                                    soSaoTB +
                                                                                    '/5 <i class="fas fa-star"></i></i></span>');
                                                                            $(
                                                                                    '#soSaoTB')
                                                                                .html(
                                                                                    'Đánh giá: ' +
                                                                                    soSaoTB +
                                                                                    '/5 <i class="fas fa-star"></i>');
                                                                        } else {
                                                                            $(
                                                                                    '#review .product-rating-stars')
                                                                                .html(
                                                                                    '<span class="soSaotb"><i>Chưa có đánh giá</i></span>');
                                                                            $(
                                                                                    '#soSaoTB')
                                                                                .html(
                                                                                    '<i>Chưa có đánh giá</i>');
                                                                        }

                                                                        // Cập nhật thông tin về "Thêm vào giỏ" dựa trên soLuong
                                                                        if (soLuong == 0) {
                                                                            $('#productStockStatus').html('<button name="them" class="btn btn-warning" disabled="disabled">Thêm vào giỏ</button><span id="outOfStockMessage" style="font-style: italic; color: red;">Sản phẩm này đã hết hàng!</span>');
                                                                        } else {
                                                                            $('#productStockStatus').html('<button name="them" class="btn btn-warning btn-them">Thêm vào giỏ</button>');
                                                                        }


                                                                        $('#inputQuantity').attr('max', soLuong);
                                                                        console.log(response.trangThai)
                                                                        // Giả sử response.trangThai là giá trị trang thái của sản phẩm
                                                                        if (response.trangThai === false) {
                                                                            // Cập nhật trạng thái sản phẩm nếu sản phẩm ngừng kinh doanh
                                                                            $('#productStatus2').html('<div class="fs-5 my-3 gia">' +
                                                                                '<span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal; text-decoration: underline;">NGỪNG KINH DOANH</span>' +
                                                                                '</div>');
                                                                        } else {
                                                                            // Nếu sản phẩm vẫn còn kinh doanh, xóa thông báo
                                                                            $('#productStatus2').html('');
                                                                        }
                                                                    },
                                                                    error: function() {
                                                                        console
                                                                            .error("Lỗi khi lấy hình ảnh từ server.");
                                                                    }
                                                                });
                                                        }

                                                        // Hàm định dạng số với dấu phẩy (mô phỏng fmt:formatNumber)
                                                        function formatCurrency(
                                                            amount) {
                                                            return new Intl.NumberFormat(
                                                                    'vi-VN')
                                                                .format(amount); // Áp dụng định dạng Việt Nam
                                                        }
                                                        // Thêm sự kiện onchange vào các checkbox màu sắc và bộ nhớ
                                                        $(document)
                                                            .ready(
                                                                function() {
                                                                    $(
                                                                            'input[name="mauSac"], input[name="boNho"]')
                                                                        .change(
                                                                            function() {
                                                                                // Gọi hàm cập nhật hình ảnh
                                                                                updateProductImage('${sanPham.tenSanPham}');
                                                                            });
                                                                });
                                                    </script>

                                                    <!-- Nút Thêm vào giỏ -->

                                                    <div class="form-group">
                                                        <div class="g-recaptcha" data-sitekey="6LcgPaUqAAAAAGBZWv3MdsO8i_OHvy9Nb2VxzNiD"></div>
                                                    </div>
                                                    <div class="mt-3" id="productStockStatus">
                                                        <c:choose>
                                                            <c:when test="${sanPham.soLuong == 0}">
                                                                <button name="them" class="btn btn-warning" disabled="disabled">Thêm vào giỏ</button>
                                                                <span id="outOfStockMessage" style="font-style: italic; color: red;">Sản phẩm này đã hết hàng!</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button name="them" class="btn btn-warning btn-them">Thêm vào giỏ</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>

                                                </f:form>
                                                <span id="thongBao" class="custom-message">
                                                    ${messenger} </span>
                                                <div id="error-message" class="custom-message" style="color: red; display: none;">Vui lòng chọn đủ
                                                    tất cả các tùy chọn trước khi thêm vào giỏ hàng hoặc yêu
                                                    thích.</div>

                                                <br>
                                                <!-- Nút "Thêm vào yêu thích" -->
                                                 <button name="fav" class="btn btn-danger">
                                                    <a href="themVaoYT/${sanPham.maSP}.htm" style="color: white;">Thêm vào yêu thích</a>
                                                </button>

                                            </c:if>

                                            <c:if test="${sanPham.trangThai==false }">
                                                <div id="productStatus2" class="fs-5 my-3 gia">
                                                    <span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal; text-decoration: underline;">NGỪNG
                                                        KINH DOANH</span>
                                                </div>
                                            </c:if>
                                            <br>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="aa-product-details-bottom">

                                <ul class="nav nav-tabs" id="myTab2">
                                    <li><a href="#description" data-toggle="tab">Mô tả</a></li>
                                    <li><a href="#review" data-toggle="tab">Đánh giá</a></li>
                                    <li><a href="#specifications" data-toggle="tab">Thông
                                            số kỹ thuật</a></li>
                                </ul>

                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div class="tab-pane fade in active" id="description">
                                        <p>${sanPham.moTa}</p>
                                    </div>
                                    <div class="tab-pane fade " id="review">
                                        <h4 class="inDam">ĐÁNH GIÁ SẢN PHẨM</h4>
                                        <div class="aa-product-review-area">
                                            <div class="product-rating-stars">
                                                <c:if test="${sanPham.soSaoTB == 0}">
                                                    <span class="soSaotb"><i>Chưa có đánh giá</i></span>
                                                </c:if>
                                                <c:if test="${sanPham.soSaoTB > 0}">
                                                    <span class="rating-count">Có ${count} đánh giá</span>
                                                    <br>
                                                    <span class="soSaotb"><i>Đánh giá trung bình:
                                                            ${sanPham.soSaoTB}/5 <i class="fas fa-star"></i>
                                                        </i></span>
                                                </c:if>
                                            </div>

                                            <ul class="aa-review-nav">
                                                <c:forEach items="${danhGiaList}" var="danhGia">
                                                    <li>
                                                        <div class="media">
                                                            <div class="media-left">
                                                                <a href="#"> <img style="height: 70px; width: 70px;" class="media-object" src="assets/img/avatar.png" alt="avatar user">
                                                                </a>
                                                            </div>
                                                            <div class="media-body">
                                                                <h4 class="media-heading">
                                                                    <strong>${danhGia.nguoiDung.hoTen}</strong> <span>${danhGia.ngay}</span>
                                                                </h4>
                                                                <div class="comment-rank c-support">
                                                                    <c:if test="${danhGia.soSao == 1}">
                                                                        <i class="fas fa-star"></i>
                                                                    </c:if>
                                                                    <c:if test="${danhGia.soSao == 2}">
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                    </c:if>
                                                                    <c:if test="${danhGia.soSao == 3}">
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                    </c:if>
                                                                    <c:if test="${danhGia.soSao == 4}">
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                    </c:if>
                                                                    <c:if test="${danhGia.soSao == 5}">
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                        <i class="fas fa-star"></i>
                                                                    </c:if>
                                                                </div>
                                                                <p>${danhGia.noiDung}</p>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>

                                        </div>

                                    </div>
                                    <div class="tab-pane fade" id="specifications">
                                        <h3>Thông số kỹ thuật</h3>
                                        <table class="table table-striped">
                                            <tr>
                                                <th>Màn hình</th>
                                                <td>${sanPham.manHinh}</td>
                                            </tr>
                                            <tr>
                                                <th>Kích thước màn hình</th>
                                                <td>${sanPham.kichThuocManHinh}</td>
                                            </tr>
                                            <tr>
                                                <th>Độ phân giải</th>
                                                <td>${sanPham.doPhanGiai}</td>
                                            </tr>
                                            <tr>
                                                <th>Camera sau</th>
                                                <td>${sanPham.cameraSau}</td>
                                            </tr>
                                            <tr>
                                                <th>Camera trước</th>
                                                <td>${sanPham.cameraTruoc}</td>
                                            </tr>
                                            <tr>
                                                <th>CPU</th>
                                                <td>${sanPham.cpu}</td>
                                            </tr>
                                            <tr>
                                                <th>RAM</th>
                                                <td>${sanPham.ram}</td>
                                            </tr>
                                            <tr>
                                                <th>Bộ nhớ trong</th>
                                                <td id="CTboNhoTrong">${sanPham.boNhoTrong}</td>
                                            </tr>
                                            <tr>
                                                <th>Pin</th>
                                                <td>${sanPham.pin}</td>
                                            </tr>
                                            <tr>
                                                <th>Hệ điều hành</th>
                                                <td>${sanPham.heDieuHanh}</td>
                                            </tr>
                                            <tr>
                                                <th>Màu sắc</th>
                                                <td id="mauSac">${sanPham.mauSac}</td> <!-- Hiển thị màu sắc -->
                                            </tr>
                                            <tr>
                                                <th>Cổng kết nối</th>
                                                <td>${sanPham.congKetNoi}</td>
                                            </tr>
                                            <tr>
                                                <th>Kết nối khác</th>
                                                <td>${sanPham.ketNoiKhac}</td>
                                            </tr>
                                            <tr>
                                                <th>Kích thước</th>
                                                <td>${sanPham.kichThuoc}</td>
                                            </tr>
                                            <tr>
                                                <th>Trọng lượng</th>
                                                <td>${sanPham.trongLuong}</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>



                            <!-- Related product -->
                            <div class="aa-product-related-item">
                                <h4>SẢN PHẨM KHÁC</h4>
                                <ul class="aa-product-catg aa-related-item-slider">

                                    <c:forEach items="${sanPhamCungKieu}" var="sp">

                                        <li>
                                            <figure>
                                                <a class="aa-product-img" href="product/${sp.maSP}.htm"><img style="width: 250px; height: 300px;" src="${sp.hinhAnh.link}" alt="product img"></a>
                                                <figcaption>
                                                    <h4 class="aa-product-title">
                                                        <a href="product/${sp.maSP}.htm" style="font-weight: bold; color: #333;">${sp.tenSanPham}</a>
                                                    </h4>
                                                    <%-- <span class="aa-product-price">${sp.donGia}đ</span><span class="aa-product-price"><!-- <del>$65.50</del> --></span> --%>
                                                    <span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal;">
                                                        <fmt:formatNumber value="${sanPham.donGia}" pattern="#,##0" />đ
                                                    </span>
                                                </figcaption>
                                            </figure>
                                        </li>

                                    </c:forEach>

                                </ul>


                                <!-- quick view modal -->
                                <c:forEach items="${sanPhamCungKieu}" var="sp">
                                    <div class="modal fade" id="quick-view-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <div class="row">
                                                        <!-- Modal view slider -->

                                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                                            <div class="aa-product-view-slider">
                                                                <div class="simpleLens-gallery-container" id="demo-1">
                                                                    <div class="simpleLens-container">
                                                                        <div class="simpleLens-big-image-container">
                                                                            <a class="simpleLens-lens-image" data-lens-image="${sp.hinhAnh.link}"> <img src="${sp.hinhAnh.link}" class="simpleLens-big-image">
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <!-- Modal view content -->
                                                        <div class="col-md-6 col-sm-6 col-xs-12">

                                                            <div class="aa-product-view-content">

                                                                <h4>${sp.tenSanPham}</h4>

                                                                <%-- <span>${sp.moTa}</span> --%>

                                                                <div class="aa-price-block">
                                                                    <span style="font-size: 1.875rem; font-weight: bold; color: #ee4d2d; font-style: normal;">
                                                                        <fmt:formatNumber value="${sanPham.donGia}" pattern="#,##0" />đ
                                                                    </span>
                                                                    <!-- <p class="aa-product-avilability">Avilability: <span>In stock</span></p> -->
                                                                </div>
                                                                <p id="moTa" class="truncate-text">${sp.moTa}</p>
                                                                <script>
                                                                    var moTaElement = document
                                                                        .getElementById("moTa");
                                                                    var maxWords = 50; // Số từ tối đa bạn muốn hiển thị

                                                                    // Tách nội dung thành các từ và đếm số từ
                                                                    var words = moTaElement.textContent
                                                                        .split(' ');
                                                                    var wordCount = words.length;

                                                                    // Nếu số từ vượt quá giới hạn, ẩn nội dung và thêm một link để hiển thị toàn bộ nội dung
                                                                    if (wordCount > maxWords) {
                                                                        moTaElement.classList
                                                                            .remove("truncate-text");
                                                                        moTaElement.innerHTML = moTaElement.textContent
                                                                            .split(
                                                                                ' ')
                                                                            .slice(
                                                                                0,
                                                                                maxWords)
                                                                            .join(
                                                                                ' ') +
                                                                            '...';
                                                                    }
                                                                </script>

                                                                <div class="aa-prod-quantity">

                                                                    <p class="aa-prod-category">
                                                                        Loai: <a href="shop/${sanPham.maKieu.loai.maLoai}.htm">${sp.maKieu.loai.tenLoai}</a>
                                                                    </p>
                                                                    <p class="aa-prod-category">
                                                                        Kiểu: <a href="shop/${sanPham.maKieu.loai.maLoai}/${sanPham.maKieu.maKieu}.htm">${sp.maKieu.tenKieu}</a>
                                                                    </p>
                                                                </div>
                                                                <div class="aa-prod-view-bottom">
                                                                    <!-- <a href="#" class="aa-add-to-cart-btn"><span class="fa fa-shopping-cart"></span>Thêm vào giỏ</a> -->
                                                                    <a href="product/${sp.maSP}.htm" class="aa-add-to-cart-btn">Xem chi tiết</a>
                                                                </div>

                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                </c:forEach>
                                <!-- / quick view modal -->

                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </section>




        <%@ include file="../include/footer.jsp"%>

        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="<c:url value='assets/js/bootstrap.js'/>"></script>
        <!-- SmartMenus jQuery plugin -->
        <script type="text/javascript" src="<c:url value='assets/js/jquery.smartmenus.js'/>"></script>
        <!-- SmartMenus jQuery Bootstrap Addon -->
        <script type="text/javascript" src="<c:url value='assets/js/jquery.smartmenus.bootstrap.js'/>"></script>
        <!-- To Slider JS -->
        <script src="<c:url value='assets/js/sequence.js'/>"></script>
        <script src="<c:url value='assets/js/sequence-theme.modern-slide-in.js'/>"></script>
        <!-- Product view slider -->
        <script type="text/javascript" src="<c:url value='assets/js/jquery.simpleGallery.js'/>"></script>
        <script type="text/javascript" src="<c:url value='assets/js/jquery.simpleLens.js'/>"></script>
        <!-- slick slider -->
        <script type="text/javascript" src="<c:url value='assets/js/slick.js'/>"></script>
        <!-- Price picker slider -->
        <script type="text/javascript" src="<c:url value='assets/js/nouislider.js'/>"></script>
        <!-- Custom js -->
        <script src="<c:url value='assets/js/custom.js'/>"></script>
    </body>

</html>