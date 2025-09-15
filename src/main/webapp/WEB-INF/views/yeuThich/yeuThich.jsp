<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PTIT PHONE SHOP | Cart Page</title>

<link href="assets/css/font-awesome.css" rel="stylesheet">
<!-- Bootstrap -->
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link href="assets/css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css"
	href="assets/css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="assets/css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css" href="assets/css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="assets/css/theme-color/default-theme1.css"
	rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link href="assets/css/sequence-theme.modern-slide-in.css"
	rel="stylesheet" media="all">

<!-- Main style sheet -->
<link href="assets/css/style.css" rel="stylesheet">

<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>


<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
	<%@ include file="../include/header.jsp"%>

	<!-- SCROLL TOP BUTTON -->
	<a class="scrollToTop" href="#"><i class="fa fa-chevron-up"></i></a>
	<!-- END SCROLL TOP BUTTON -->



	<!-- catg header banner section -->
	<section id="aa-catg-head-banner">
<!-- 		<img src="assets/img/fashion/fashion-header-bg-8.jpg"
			alt="fashion img"> -->
		<div class="aa-catg-head-banner-area">
			<div class="container">
				<div class="aa-catg-head-banner-content">
					<h2>Wishlist Page</h2>
					<ol class="breadcrumb">
						<li><a href="index.html">Home</a></li>
						<li class="active">Wishlist</li>
					</ol>
				</div>
			</div>
		</div>
	</section>
	<!-- / catg header banner section -->

	<!-- Cart view section -->
	<section id="cart-view">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="cart-view-area">
						<div class="cart-view-table aa-wishlist-table">
							<form action="">
								<div class="table-responsive">
									<table class="table">
										<thead>
											<tr>
												<th></th>
												<th>Hình ảnh</th>
												<th>Sản phẩm</th>
												<th>Đơn giá</th>
												<th>Trạng thái</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="yeuThich" items="${yeuThichList}">
												<tr>
													<f:form action="#" method="post">
														<td><a class="remove" href="xoaYeuThich/${yeuThich.id}.htm"><fa
																	class="fa fa-close"></fa></a></td>
														<td><a href="product/${yeuThich.sanPham.maSP}.htm"><img
																src="${yeuThich.sanPham.hinhAnh.link}" alt="img"></a></td>
														<td><a class="aa-cart-title" href="product/${yeuThich.sanPham.maSP}.htm" style="color: black">${yeuThich.sanPham.tenSanPham}</a></td>
														<td><fmt:formatNumber
																value="${yeuThich.sanPham.donGia}" pattern="#,##0" />đ</td>
														<c:choose>
															<c:when test="${yeuThich.sanPham.trangThai== true}">
																<td>Đang bán</td>
															</c:when>
															<c:otherwise>
																<td>Ngừng kinh doanh</td>
															</c:otherwise>
														</c:choose>
														<!-- <td><a href="#" class="aa-add-to-cart-btn">Thêm
															vào giỏ hàng</a></td> -->
														<td>

																	<button name="them" class="btn btn-warning" type="submit"><a class="" href="product/${yeuThich.sanPham.maSP}.htm">Xem sản phẩm</a></button>

															</td>
													</f:form>
												</tr>


											</c:forEach>
										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- / Cart view section -->


	<%@ include file="../include/footer.jsp"%>


	<!-- jQuery library -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="assets/js/bootstrap.js"></script>
	<!-- SmartMenus jQuery plugin -->
	<script type="text/javascript" src="assets/js/jquery.smartmenus.js"></script>
	<!-- SmartMenus jQuery Bootstrap Addon -->
	<script type="text/javascript"
		src="assets/js/jquery.smartmenus.bootstrap.js"></script>
	<!-- To Slider JS -->
	<script src="assets/js/sequence.js"></script>
	<script src="assets/js/sequence-theme.modern-slide-in.js"></script>
	<!-- Product view slider -->
	<script type="text/javascript" src="assets/js/jquery.simpleGallery.js"></script>
	<script type="text/javascript" src="assets/js/jquery.simpleLens.js"></script>
	<!-- slick slider -->
	<script type="text/javascript" src="assets/js/slick.js"></script>
	<!-- Price picker slider -->
	<script type="text/javascript" src="assets/js/nouislider.js"></script>
	<!-- Custom js -->
	<script src="assets/js/custom.js"></script>

	<script>
		function confirmAction(event) {
			var result = confirm("Xoá mặt hàng này khỏi giỏ hàng ?");
			if (result) {
				return true; // Tiếp tục chuyển hướng theo liên kết
			} else {
				event.preventDefault(); // Ngăn chặn chuyển hướng mặc định
				return false;
			}
		}
	</script>


</body>
</html>