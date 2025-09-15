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
<link href="assets/css/modalDanhGia.css" rel="stylesheet">
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
<!-- Thêm thư viện SweetAlert vào đầu trang -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
					<li><a href="index.html">Home</a></li>
					<li class="active">Lịch sử đơn hàng</li>
					<li class="active">Chi tiết đơn hàng</li>
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
			<h1>Chi tiết đơn hàng</h1>
			<div class="card-body" style="color: #ff6666; font-size: 20px;">
				<span class="fa fa-shopping-cart"></span>
				<h5 class="card-title"
					style="display: inline-block; font-size: 26px">
					Daily <strong>Shop</strong>
				</h5>

				<p class="card-text" style="color: black">Anh/chị:
					${donHang.hoTen}</p>
				<p class="card-text" style="color: black">Thời gian đặt hàng:
					${donHang.ngayTao}</p>
				<p class="card-text" style="color: black">Số điện thoại:
					${donHang.sdt}</p>
				<p class="card-text" style="color: black">Địa chỉ:
					${donHang.diaChi}</p>
				<p class="card-text" style="color: black">Phương thức: Thanh
					toán khi nhận hàng</p>
				<c:choose>
					<c:when test="${donHang.trangThai == 0 }">
						<span
							style="padding: 5px; background-color: #ff9999; border-radius: 20px; /*  float: right; */ color: #ff3333;">Đã
							hủy</span>
					</c:when>
					<c:when test="${donHang.trangThai == 1 }">
						<span
							style="padding: 5px; background-color: #ffe5cc; border-radius: 20px; /* float: right; */ color: #ff9933;">Chờ
							xác nhận</span>
					</c:when>
					<c:when test="${donHang.trangThai == 2 }">
						<span
							style="padding: 5px; background-color: #ffe5cc; border-radius: 20px; /* float: right */; color: #ff9933;">Đang
							giao hàng</span>
					</c:when>
					<c:otherwise>
						<span
							style="padding: 5px; background-color: #99ff99; border-radius: 20px; /* float: right; */ color: #00994c;">Giao
							thành công</span>
					</c:otherwise>

				</c:choose>

			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="cart-view-area">
						<div class="cart-view-table">

							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th></th>
											<th>Sản Phẩm</th>
											<th>Màu Sắc</th>
											<th>Bộ Nhớ</th>
											<th>Đơn Giá</th>
											<th>Số Lượng</th>
											<th>Tổng</th>
											<c:if test="${donHang.trangThai == 3 }">
												<td></td>
											</c:if>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="ctDonHangItem" items="${ctDonHangList}">
											<tr>
												<!-- Hiển thị hình ảnh sản phẩm -->
												<td><a href="product/${ctDonHangItem.sanPham.maSP}.htm">
														<img src="${ctDonHangItem.sanPham.hinhAnh.link}" alt="img">
												</a></td>

												<!-- Tên sản phẩm -->
												<td><a class="aa-cart-title"
													href="product/${ctDonHangItem.sanPham.maSP}.htm">
														${ctDonHangItem.sanPham.tenSanPham} </a> <c:if
														test="${ctDonHangItem.sanPham.trangThai == false}">
														<span
															style="color: red; font-style: italic; font-size: 13px; font-weight: bold; text-decoration: underline;">
															Sản phẩm này đã ngừng kinh doanh, vui lòng xoá khỏi giỏ
															hàng! </span>
														<c:set var="check" value="${check + 1}" />
													</c:if></td>

												<!-- Hiển thị màu sắc -->
												<td><b>${ctDonHangItem.sanPham.mauSac}</b></td>

												<!-- Hiển thị bộ nhớ -->
												<td><b>${ctDonHangItem.sanPham.boNhoTrong}</b></td>

												<!-- Hiển thị đơn giá -->
												<td><fmt:formatNumber
														value="${ctDonHangItem.sanPham.donGia}" pattern="#,##0" />đ
												</td>

												<!-- Hiển thị số lượng -->
												<td>
													<p class="aa-cart-quantity"
														style="width: 100%; height: 100%; padding-top: 36px;">
														${ctDonHangItem.soLuong}</p>
												</td>

												<!-- Hiển thị tổng giá -->
												<td><c:set var="giamGia"
														value="${ctDonHangItem.sanPham.giamGia}" /> <c:choose>
														<c:when test="${giamGia != null && giamGia != '0'}">
															<c:set var="soTien"
																value="${(ctDonHangItem.sanPham.donGia * (1 - giamGia/100)) * ctDonHangItem.soLuong}" />
														</c:when>
														<c:otherwise>
															<c:set var="soTien"
																value="${ctDonHangItem.sanPham.donGia * ctDonHangItem.soLuong}" />
														</c:otherwise>
													</c:choose> <span style="color: #009432; font-weight: bold"> <fmt:formatNumber
															value="${soTien}" pattern="#,##0" />đ
												</span></td>


												<!-- Hiển thị trạng thái đánh giá nếu trạng thái đơn hàng là 3 -->
												<c:if test="${donHang.trangThai == 3 }">
													<c:choose>
														<c:when test="${ctDonHangItem.trangThaiDanhGia == true}">
															<td>
																<button
																	style="padding: 4px; background-color: #CCFFCC; border-radius: 10px; color: #00cc66; border: solid 2px #CCFFCC;">
																	Đã đánh giá sản phẩm</button>
															</td>
														</c:when>
														<c:otherwise>
															<td>
																<button
																	class="js-danhGiaSP-${ctDonHangItem.sanPham.maSP}"
																	style="padding: 4px; background-color: #ffcc99; border-radius: 10px; color: #cc6600; border: solid 2px #ffcc99;">
																	Đánh giá sản phẩm</button>
															</td>
														</c:otherwise>
													</c:choose>
												</c:if>

												<!-- Cập nhật tổng tiền -->
												<c:set var="tongTien" value="${donHang.tongTien}" />
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

								<c:choose>

									<c:when test="${donHang.trangThai == 1 }">
										<a href="huyDonHang/${donHang.maDh}.htm">
											<button class="js-danhGiaSP-${ctDonHangItem.sanPham.maSP}"
												style="font-size: 20px; padding: 10px; background-color: #ff6666; margin-right: 50px; margin-top: 30px; color: #fff; border: solid 2px #ff6666;">Hủy
												đơn hàng</button>
										</a>
									</c:when>
									<c:when test="${donHang.trangThai == 2 }">
										<a href="daNhanHang/${donHang.maDh}.htm">
											<button class="js-danhGiaSP-${ctDonHangItem.sanPham.maSP}"
												style="font-size: 20px; padding: 10px; background-color: #00cc00; margin-right: 50px; margin-top: 30px; color: #fff; border: solid 2px #00cc00;">Đã
												nhận hàng</button>
										</a>


									</c:when>
									<c:otherwise>

									</c:otherwise>

								</c:choose>



							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- / Cart view section -->
	<c:forEach var="ctDonHangItem" items="${ctDonHangList}">
		<c:if test="${ctDonHangItem.trangThaiDanhGia == false }">





			<div
				class="modal-danh-gia js-modal-danh-gia-${ctDonHangItem.sanPham.maSP}">
				<div
					class="modal-danh-gia-container js-modal-danh-gia-container-${ctDonHangItem.sanPham.maSP}">
					<div class="container">

						<div class="modal-danh-gia-header">
							<h1 class="modal-dang-gia-title">Đánh giá sản phẩm</h1>
						</div>

						<!-- Modal view slider -->
						<div class="col-md-5 col-sm-5 col-xs-12">
							<div class="aa-product-view-slider">
								<!-- 							<div id="demo-1" class="simpleLens-gallery-container">
 -->
								<div class="simpleLens-gallery-container">
									<div class="simpleLens-container">
										<div class="simpleLens-big-image-container">
											<a data-lens-image="${ctDonHangItem.sanPham.hinhAnh.link}"
												class="simpleLens-lens-image"><img
												src="${ctDonHangItem.sanPham.hinhAnh.link}"
												class="simpleLens-big-image"></a>
										</div>
									</div>
									<!-- <div class="simpleLens-thumbnails-container">
                          <a data-big-image="img/view-slider/medium/polo-shirt-1.png" data-lens-image="img/view-slider/large/polo-shirt-1.png" class="simpleLens-thumbnail-wrapper" href="#">
                            <img src="img/view-slider/thumbnail/polo-shirt-1.png">
                          </a>                                    
                          <a data-big-image="img/view-slider/medium/polo-shirt-3.png" data-lens-image="img/view-slider/large/polo-shirt-3.png" class="simpleLens-thumbnail-wrapper" href="#">
                            <img src="img/view-slider/thumbnail/polo-shirt-3.png">
                          </a>
                          <a data-big-image="img/view-slider/medium/polo-shirt-4.png" data-lens-image="img/view-slider/large/polo-shirt-4.png" class="simpleLens-thumbnail-wrapper" href="#">
                            <img src="img/view-slider/thumbnail/polo-shirt-4.png">
                          </a>
                      </div> -->
								</div>
							</div>
						</div>
						<h1 class="mt-3"
							style="font-size: 3rem; font-weight: bold; color: #3D71B6;">${ctDonHangItem.sanPham.tenSanPham}</h1>
						<form
							action="chiTietDonHang/${donHang.maDh}/${ctDonHangItem.sanPham.maSP}.htm"
							method="post">
							<h3>Đánh giá số sao</h3>
							<div style="width: 60%">
								<div class="star-widget">
									<input type="radio" name="rate" value="5"
										id="rate-5-${ctDonHangItem.sanPham.maSP}"> <label
										for="rate-5-${ctDonHangItem.sanPham.maSP}" class="fa fa-star"></label>
									<input type="radio" name="rate" value="4"
										id="rate-4-${ctDonHangItem.sanPham.maSP}"> <label
										for="rate-4-${ctDonHangItem.sanPham.maSP}" class="fa fa-star"></label>
									<input type="radio" name="rate" value="3"
										id="rate-3-${ctDonHangItem.sanPham.maSP}"> <label
										for="rate-3-${ctDonHangItem.sanPham.maSP}" class="fa fa-star"></label>
									<input type="radio" name="rate" value="2"
										id="rate-2-${ctDonHangItem.sanPham.maSP}"> <label
										for="rate-2-${ctDonHangItem.sanPham.maSP}" class="fa fa-star"></label>
									<input type="radio" name="rate" value="1"
										id="rate-1-${ctDonHangItem.sanPham.maSP}"> <label
										for="rate-1-${ctDonHangItem.sanPham.maSP}" class="fa fa-star"></label>
								</div>
							</div>
							<div class="modal-danh-gia-body">
								<!-- <textarea id="w3review" name="w3review" rows="4" cols="70"
								placeholder="Nội dung đánh giá"></textarea> -->
								<textarea name="content-danhGia" rows="4" cols="70"
									placeholder="Nội dung đánh giá"></textarea>
							</div>
							<button name="submit-rating" id="submitRating"
								style="padding: 4px; background-color: #ff8000; border-radius: 0px; color: #fff; border: solid 2px #ff8000;">Gửi
								đánh giá</button>
						</form>
					</div>
				</div>
				s

			</div>
		</c:if>
	</c:forEach>
	<%-- 	<%@ include file="../include/footer.jsp"%> --%>


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
	<script type="text/javascript">
	<c:forEach var="ctDonHangItem" items="${ctDonHangList}">
		<c:if test="${ctDonHangItem.trangThaiDanhGia == false}">
			const rateProduct_${ctDonHangItem.sanPham.maSP} = document.querySelector('.js-danhGiaSP-${ctDonHangItem.sanPham.maSP}')
			const modalDanhGiaSP_${ctDonHangItem.sanPham.maSP} = document.querySelector('.js-modal-danh-gia-${ctDonHangItem.sanPham.maSP}')
			const modalDanhGiaContainer_${ctDonHangItem.sanPham.maSP} = document.querySelector('.js-modal-danh-gia-container-${ctDonHangItem.sanPham.maSP}')
			function showDanhGia_${ctDonHangItem.sanPham.maSP}(){
				modalDanhGiaSP_${ctDonHangItem.sanPham.maSP}.classList.add('open-modal-danh-gia')
			}
			function hideDanhGia_${ctDonHangItem.sanPham.maSP}(){
				modalDanhGiaSP_${ctDonHangItem.sanPham.maSP}.classList.remove('open-modal-danh-gia')
			}
			rateProduct_${ctDonHangItem.sanPham.maSP}.addEventListener('click', showDanhGia_${ctDonHangItem.sanPham.maSP})
	
			modalDanhGiaSP_${ctDonHangItem.sanPham.maSP}.addEventListener('click', hideDanhGia_${ctDonHangItem.sanPham.maSP})
			modalDanhGiaContainer_${ctDonHangItem.sanPham.maSP}.addEventListener('click', function(event){
				event.stopPropagation()
			})
		</c:if>
	</c:forEach>
	</script>
	<script type="text/javascript">
		const submitRating = document.getElementById('submitRating')
		submitRating.addEventListener('click', function(event){
			alert.show("Đánh giá thành công")
		})
	</script>
	<script>
        // Kiểm tra xem có thông báo lỗi không
        <c:if test="${not empty error}">
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: '${error}',  // Thông báo lỗi từ ModelMap
                confirmButtonText: 'OK'
            });
        </c:if>
    </script>
</body>
</html>