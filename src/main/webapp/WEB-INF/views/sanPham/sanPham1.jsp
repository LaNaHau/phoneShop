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

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
	crossorigin="anonymous">
<link rel="stylesheet" href='<c:url value="/assets/css/product.css"/>' />

<link href="assets/css/style.css" rel="stylesheet">
<link rel="stylesheet"
	href='<c:url value="/assets/css/font-awesome.css"/>' />
<!-- Bootstrap -->
<link rel="stylesheet" href='<c:url value="/assets/css/bootstrap.css"/>' />
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/jquery.smartmenus.bootstrap.css"/>' />
<!-- Product view slider -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/jquery.simpleLens.css"/>' />
<!-- slick slider -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/assets/css/slick.css"/>' />
<!-- price picker slider -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/assets/css/nouislider.css"/>' />
<!-- Theme color -->
<link id="switcher" rel="stylesheet"
	href='<c:url value="/assets/css/theme-color/default-theme1.css"/>' />
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link media="all" rel="stylesheet"
	href='<c:url value="/assets/css/sequence-theme.modern-slide-in.css"/>' />

<!-- Main style sheet -->
<link rel="stylesheet" href='<c:url value="/assets/css/style.css"/>' />

<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<section class="product-details">
    <div class="container">
		<div>
		        <ol class="breadcrumb">
            <li><a href="${pageContext.servletContext.contextPath}/">Trang chủ</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/shop.htm">Điện thoại</a></li>
            <li><a href="shop/${sanPham.maKieu.loai.maLoai}.htm">${sanPham.maKieu.loai.tenLoai}</a></li>
            <li class="active">${sanPham.tenSanPham}</li>
        </ol>
		</div>
        
        <div class="row">
            <!-- Hình ảnh sản phẩm -->
            <div class="col-md-6">
                <div class="product-image">
                    <img src="${sanPham.hinhAnh.link}" alt="${sanPham.tenSanPham}" class="img-fluid">
                </div>
            </div>
            
            <!-- Thông tin sản phẩm -->
            <div class="col-md-6">
                <h1>${sanPham.tenSanPham}</h1>
                <div class="product-rating">
                    <c:if test="${sanPham.soSaoTB == 0}">
                        <span>Chưa có đánh giá</span>
                    </c:if>
                    <c:if test="${sanPham.soSaoTB > 0}">
                        <span>Đánh giá: ${sanPham.soSaoTB}/5</span>
                        <div class="stars">
                            <c:forEach var="i" begin="1" end="${sanPham.soSaoTB}">
                                <i class="fas fa-star"></i>
                            </c:forEach>
                            <c:forEach var="i" begin="${sanPham.soSaoTB + 1}" end="5">
                                <i class="far fa-star"></i>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>

                <div class="price">
                    <span class="original-price"><fmt:formatNumber value="${sanPham.donGia}" pattern="#,##0" />đ</span>
                </div>
                
                <p>Còn lại: ${sanPham.soLuong}</p>
                <f:form action="themVaoGio/${sanPham.maSP}.htm" method="post">
                    <div class="d-flex">
                        <input type="number" name="soLuong" class="form-control" min="1" max="${sanPham.soLuong}" value="1" style="width: 90px;" />
                        <button type="submit" class="btn btn-warning ms-3">Thêm vào giỏ</button>
                    </div>
                </f:form>
                <a href="themVaoYT/${sanPham.maSP}.htm" class="btn btn-danger mt-3">Thêm vào yêu thích</a>
            </div>
        </div>
        
        <!-- Bảng thông số kỹ thuật -->
        <div class="row mt-5">
            <div class="col-12">
                <h3>Thông số kỹ thuật</h3>
                <table class="table table-bordered">
                    <tr>
                        <td>Màn hình</td>
                        <td>${sanPham.manHinh}</td>
                    </tr>
                    <tr>
                        <td>CPU</td>
                        <td>${sanPham.cpu}</td>
                    </tr>
                    <tr>
                        <td>RAM</td>
                        <td>${sanPham.ram}</td>
                    </tr>
                    <tr>
                        <td>Bộ nhớ</td>
                        <td>${sanPham.boNhoTrong}</td>
                    </tr>
                    <tr>
                        <td>Pin</td>
                        <td>${sanPham.pin}</td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- Đánh giá -->
        <div class="row mt-5">
            <div class="col-12">
                <h3>Đánh giá sản phẩm</h3>
                <ul>
                    <c:forEach items="${danhGiaList}" var="danhGia">
                        <li>
                            <strong>${danhGia.nguoiDung.hoTen}</strong> (${danhGia.ngay}) 
                            <p>${danhGia.noiDung}</p>
                            <div class="stars">
                                <c:forEach var="i" begin="1" end="${danhGia.soSao}">
                                    <i class="fas fa-star"></i>
                                </c:forEach>
                                <c:forEach var="i" begin="${danhGia.soSao + 1}" end="5">
                                    <i class="far fa-star"></i>
                                </c:forEach>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <!-- Sản phẩm liên quan -->
        <div class="row mt-5">
            <div class="col-12">
                <h3>Sản phẩm liên quan</h3>
                <div class="row">
                    <c:forEach items="${sanPhamCungKieu}" var="sp">
                        <div class="col-md-3">
                            <div class="product-card">
                                <a href="product/${sp.maSP}.htm">
                                    <img src="${sp.hinhAnh.link}" alt="${sp.tenSanPham}" class="img-fluid">
                                    <h5>${sp.tenSanPham}</h5>
                                    <span><fmt:formatNumber value="${sp.donGia}" pattern="#,##0" />đ</span>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="../include/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
