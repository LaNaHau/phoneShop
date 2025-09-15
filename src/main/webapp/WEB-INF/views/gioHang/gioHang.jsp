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



	<div class="aa-catg-head-banner-area">
		<div class="container">
			<div class="aa-catg-head-banner-content">
				<h2>Cart Page</h2>
				<ol class="breadcrumb">
					<li><a href="${pageContext.servletContext.contextPath}">Home</a></li>
					<li class="active">Cart</li>
				</ol>
			</div>
		</div>
	</div>
	</section>
	<!-- / catg header banner section -->

	<!-- Cart view section -->
	<c:set var="check" value="0" />
	<c:set var="tongTien" value="0" />
	<section id="cart-view">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<c:if test="${not empty errorMessage}">
						<div class="alert alert-danger">${errorMessage}</div>
					</c:if>
					<div class="cart-view-area">
						<div class="cart-view-table">

							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th></th>
											<th></th>
											<th>Sản Phẩm</th>
											<th>Màu Sắc</th>
											<th>Bộ Nhớ</th>
											<th>Đơn Giá</th>
											<th>Số Lượng</th>
											<th>Kho</th>
											<!-- Thêm cột Số Lượng trong Kho -->
											<th>Tổng</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="gioHang" items="${gioHangList}">
											<tr>
												<f:form action="gioHang/${gioHang.maGh}.htm" method="post">
													<td>
														<button class="remove-from-cart" id="btn-xoa" name="xoa"
															data-toggle="tooltip" title="xoá sản phẩm"
															data-original-title="Remove item"
															onclick="return confirmAction(event)">
															<i class="fa fa-trash"></i>
														</button>
													</td>
													<td><a href="product/${gioHang.sanPham.maSP}.htm">
															<img src="${gioHang.sanPham.hinhAnh.link}" alt="img">
													</a></td>
													<td><a class="aa-cart-title"
														href="product/${gioHang.sanPham.maSP}.htm">${gioHang.sanPham.tenSanPham}</a>
														<c:if test="${gioHang.sanPham.trangThai==false }">
															<span
																style="color: red; font-style: italic; font-size: 13px; font-weight: bold; text-decoration: underline;">
																Sản phẩm này đã ngừng kinh doanh, vui lòng xoá khỏi giỏ
																hàng! </span>
															<c:set var="check" value="${check+1}" />
														</c:if> <!-- Kiểm tra số lượng trong kho --> <c:if
															test="${gioHang.soLuong > gioHang.sanPham.soLuong}">
															<span
																style="color: red; font-style: italic; font-size: 13px; font-weight: bold; text-decoration: underline;">
																Số lượng yêu cầu vượt quá số lượng trong kho, vui lòng
																giảm số lượng! </span>
															<c:set var="check" value="${check+1}" />
														</c:if></td>
													<td>${gioHang.sanPham.mauSac}</td>
													<td>${gioHang.sanPham.boNhoTrong}</td>
													<td><fmt:formatNumber
															value="${gioHang.sanPham.giamGia != null ? (gioHang.sanPham.donGia * (100 - gioHang.sanPham.giamGia) / 100) : gioHang.sanPham.donGia}"
															pattern="#,##0" />đ</td>

													<td><input class="aa-cart-quantity" name="soLuong"
														type="number" value="${gioHang.soLuong}" min="1" required
														max="${gioHang.sanPham.soLuong}"
														${gioHang.sanPham.soLuong==0 || gioHang.sanPham.trangThai==false ? 'disabled' : '' }>
														<br>
														<button id="btn-update" name="update" type="submit"
															style="border: none; background: none; font-size: 13px; color: blue;"
															${gioHang.sanPham.soLuong==0 || gioHang.sanPham.trangThai==false ? 'disabled' : '' }>Cập
															Nhật</button></td>
													<td><span>${gioHang.sanPham.soLuong}</span> <!-- Hiển thị số lượng trong kho -->
													</td>
													<td><c:if
															test="${gioHang.sanPham.giamGia == '0' || gioHang.sanPham.giamGia == NULL}">
															<c:set var="soTien"
																value="${gioHang.sanPham.donGia * gioHang.soLuong}" />
														</c:if> <c:if
															test="${gioHang.sanPham.giamGia != '0' || gioHang.sanPham.giamGia != NULL}">
															<c:set var="soTien"
																value="${gioHang.sanPham.donGia * gioHang.soLuong * (1 - gioHang.sanPham.giamGia/100)}" />
														</c:if> <span style="color: #009432; font-weight: bold"> <fmt:formatNumber
																value="${soTien}" pattern="#,##0" />đ
													</span></td>
													<c:set var="tongTien" value="${tongTien+soTien}" />
												</f:form>
											</tr>
										</c:forEach>
									</tbody>

								</table>
							</div>

							<!-- Cart Total view -->
							<div class="cart-view-total">

								<table class="aa-totals-table">
									<tbody>

										<tr>
											<th>Tổng tiền</th>
											<td><fmt:formatNumber value="${tongTien}"
													pattern="#,##0" />đ</td>
										</tr>
									</tbody>
								</table>

								<c:if test="${gioHangList.size() > 0 && check==0}">
									<a href="donHang.htm" class="aa-cart-view-btn">ĐẶT HÀNG</a>
								</c:if>
								<c:if test="${gioHangList.size() <= 0 || check!=0}">
									<a href="donHang.htm" class="aa-cart-view-btn"
										style="pointer-events: none; color: black !important; background-color: gray !important;">ĐẶT
										HÀNG</a>
								</c:if>

							</div>
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