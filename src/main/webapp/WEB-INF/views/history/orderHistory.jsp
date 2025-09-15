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
<link href="assets/css/orderHistory.css" rel="stylesheet">
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
<style>
#donHangItem:hover {
	background: #e5ffcc;
}
</style>
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
					<li class="active">Lịch sử mua hàng</li>
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
			<p style="font-size: 20px;">
				Anh/Chị:  <b>${user.hoTen}</b>
			</p>
			<p style="font-size: 20px; margin-bottom: 10px;">Trạng thái đơn hàng</p>
			<div class="group-button">
				<button id="btn-choXacNhan" class="btn-trangThai  js-trangThai">Chờ xác nhận</button>
				<button id="btn-dangGiao" class="btn-trangThai js-trangThai">Đang giao hàng</button>
				<button id="btn-thanhCong" class="btn-trangThai js-trangThai btn-trangThai-active">Giao hàng thành công</button>
				<button id="btn-daHuy" class="btn-trangThai js-trangThai">Đã hủy</button>
			</div>
			<div id="body-thanhCong" class="row bg-white body-content body-content-active" style="margin-bottom: 30px">
				<div class="col-md-12">
					<div class="cart-view-area ">
						<div class="cart-view-table ">
						<c:forEach var="donHang" items="${donHangThanhCongList}">
						
							<a id="donHangItem" href = "chiTietDonHang/${donHang.maDh}.htm"
								 class="
								card"
									style="display:block;width: 100%; border: 2px solid #ccc; border-radius: 15px; padding: 10px;">

									<div class="card-body" style="color: #ff6666; font-size: 20px;">
										<span class="fa fa-shopping-cart"></span>
										<h5 class="card-title" style="display: inline-block; font-size: 26px">
											Daily <strong>Shop</strong>
										</h5>
										<span
											style="padding: 5px; background-color: #99ff99; border-radius: 20px; float: right; color: #00994c;">Giao
											thành công</span>
										<p class="card-text" style="color: black">Thời gian đặt
											hàng: ${donHang.ngayTao}<!-- 16/09/2023 --></p>
									</div>
								<!-- </div> -->
							</a>
						</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div id="body-choXacNhan" class="row bg-white body-content" style="margin-bottom: 30px">
				<div class="col-md-12">
					<div class="cart-view-area ">
						<div class="cart-view-table ">
						<c:forEach var="donHang" items="${donHangChoXacNhanList}">
						
							<a id="donHangItem" href = "chiTietDonHang/${donHang.maDh}.htm"
								 class="
								card"
									style="display:block;width: 100%; border: 2px solid #ccc; border-radius: 15px; padding: 10px;">

									<div class="card-body" style="color: #ff6666; font-size: 20px;">
										<span class="fa fa-shopping-cart"></span>
										<h5 class="card-title" style="display: inline-block; font-size: 26px">
											Daily <strong>Shop</strong>
										</h5>
										<span
											style="padding: 5px; background-color: #ffe5cc; border-radius: 20px; float: right; color: #ff9933;">Chờ xác nhận</span>
										<p class="card-text" style="color: black">Thời gian đặt
											hàng: ${donHang.ngayTao}<!-- 16/09/2023 --></p>
									</div>
								<!-- </div> -->
							</a>
						</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div id="body-dangGiao" class="row bg-white body-content" style="margin-bottom: 30px">
				<div class="col-md-12">
					<div class="cart-view-area ">
						<div class="cart-view-table ">
						<c:forEach var="donHang" items="${donHangDangGiaoList}">
						
							<a id="donHangItem" href = "chiTietDonHang/${donHang.maDh}.htm"
								 class="
								card"
									style="display:block;width: 100%; border: 2px solid #ccc; border-radius: 15px; padding: 10px;">

									<div class="card-body" style="color: #ff6666; font-size: 20px;">
										<span class="fa fa-shopping-cart"></span>
										<h5 class="card-title" style="display: inline-block; font-size: 26px">
											Daily <strong>Shop</strong>
										</h5>
										<span
											style="padding: 5px; background-color: #ffe5cc; border-radius: 20px; float: right; color: #ff9933;">Đang
											giao hàng</span>
										<p class="card-text" style="color: black">Thời gian đặt
											hàng: ${donHang.ngayTao}<!-- 16/09/2023 --></p>
									</div>
								<!-- </div> -->
							</a>
						</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div id="body-daHuy" class="row bg-white body-content" style="margin-bottom: 30px">
				<div class="col-md-12">
					<div class="cart-view-area ">
						<div class="cart-view-table ">
						<c:forEach var="donHang" items="${donHangDaHuyList}">
						
							<a id="donHangItem" href = "chiTietDonHang/${donHang.maDh}.htm"
								 class="
								card"
									style="display:block;width: 100%; border: 2px solid #ccc; border-radius: 15px; padding: 10px;">

									<div class="card-body" style="color: #ff6666; font-size: 20px;">
										<span class="fa fa-shopping-cart"></span>
										<h5 class="card-title" style="display: inline-block; font-size: 26px">
											Daily <strong>Shop</strong>
										</h5>
										<span
											style="padding: 5px; background-color: #ff9999; border-radius: 20px; float: right; color: #ff3333;">Đã hủy</span>
										<p class="card-text" style="color: black">Thời gian đặt
											hàng: ${donHang.ngayTao}<!-- 16/09/2023 --></p>
									</div>
								<!-- </div> -->
							</a>
						</c:forEach>
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
	<script src="assets/js/custom.js">
		
	</script>

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
	<script type="text/javascript">
		const btnTrangThais = document.querySelectorAll('.js-trangThai')
		const btnThanhCong = document.getElementById('btn-thanhCong')
		const btnChoXacNhan = document.getElementById('btn-choXacNhan')
		const btnDangGiao = document.getElementById('btn-dangGiao')
		const btnDaHuy = document.getElementById('btn-daHuy')
		const bodyChoXacNhan = document.getElementById('body-choXacNhan')
		const bodyDangGiao = document.getElementById('body-dangGiao')
		const bodyThanhCong = document.getElementById('body-thanhCong')
		const bodyDaHuy = document.getElementById('body-daHuy')
		
		function activeTrangThai(){
			btnActiveTrangThai.classList.add('btn-trangThai-active')
			
		}
		function resetBodyContent(){
			bodyChoXacNhan.classList.remove('body-content-active')
			bodyDangGiao.classList.remove('body-content-active')
			bodyThanhCong.classList.remove('body-content-active')
			bodyDaHuy.classList.remove('body-content-active')
		}
		function noActiveTrangThai(){
			btnActiveTrangThai.classList.remove('btn-trangThai-active')
		}
		
		btnThanhCong.addEventListener('click', function(event){
			btnThanhCong.classList.add('btn-trangThai-active')
			btnChoXacNhan.classList.remove('btn-trangThai-active')
			btnDaHuy.classList.remove('btn-trangThai-active')
			btnDangGiao.classList.remove('btn-trangThai-active')
			bodyChoXacNhan.classList.remove('body-content-active')
			bodyDangGiao.classList.remove('body-content-active')
			bodyThanhCong.classList.remove('body-content-active')
			bodyDaHuy.classList.remove('body-content-active')
			bodyThanhCong.classList.add('body-content-active')
			
		})
		btnChoXacNhan.addEventListener('click', function(event){
			btnThanhCong.classList.remove('btn-trangThai-active')
			btnChoXacNhan.classList.add('btn-trangThai-active')
			btnDaHuy.classList.remove('btn-trangThai-active')
			btnDangGiao.classList.remove('btn-trangThai-active')
			bodyChoXacNhan.classList.remove('body-content-active')
			bodyDangGiao.classList.remove('body-content-active')
			bodyThanhCong.classList.remove('body-content-active')
			bodyDaHuy.classList.remove('body-content-active')
			bodyChoXacNhan.classList.add('body-content-active')
		})
		btnDaHuy.addEventListener('click', function(event){
			btnThanhCong.classList.remove('btn-trangThai-active')
			btnChoXacNhan.classList.remove('btn-trangThai-active')
			btnDaHuy.classList.add('btn-trangThai-active')
			btnDangGiao.classList.remove('btn-trangThai-active')
			bodyChoXacNhan.classList.remove('body-content-active')
			bodyDangGiao.classList.remove('body-content-active')
			bodyThanhCong.classList.remove('body-content-active')
			bodyDaHuy.classList.remove('body-content-active')
			bodyDaHuy.classList.add('body-content-active')
		})
		btnDangGiao.addEventListener('click', function(event){
			btnThanhCong.classList.remove('btn-trangThai-active')
			btnChoXacNhan.classList.remove('btn-trangThai-active')
			btnDaHuy.classList.remove('btn-trangThai-active')
			btnDangGiao.classList.add('btn-trangThai-active')
			bodyChoXacNhan.classList.remove('body-content-active')
			bodyDangGiao.classList.remove('body-content-active')
			bodyThanhCong.classList.remove('body-content-active')
			bodyDaHuy.classList.remove('body-content-active')
			bodyDangGiao.classList.add('body-content-active')
		})

		
	</script>

</body>
</html>