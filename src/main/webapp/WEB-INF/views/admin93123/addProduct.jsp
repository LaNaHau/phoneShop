<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Thêm sản phẩm</title>
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700">
<!-- https://fonts.google.com/specimen/Roboto -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/fontawesome.min.css"/>' />
<!-- https://fontawesome.com/ -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/jquery-ui-datepicker/jquery-ui.min.css" />'
	type="text/css" />
<!-- http://api.jqueryui.com/datepicker/ -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/bootstrap.min.css"/>' />
<!-- https://getbootstrap.com/ -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/templatemo-style.css"/>' />
<!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->

</head>

<body id="reportsPage">
	<div class="" id="home">
		<%@ include file="include/menu.jsp"%>

		<div class="container tm-mt-big tm-mb-big">
			<div class="row">
				<div class="col-xl-9 col-lg-10 col-md-12 col-sm-12 mx-auto">
					<div class="tm-bg-primary-dark tm-block tm-block-h-auto">
						<div class="row">
							<div class="col-12">
								<c:if test="${not empty successMessage}">
									<div class="alert alert-success">${successMessage}</div>
								</c:if>
								<c:if test="${not empty errorMessage}">
									<div class="alert alert-danger">${errorMessage}</div>
								</c:if>
								<h2 class="tm-block-title d-inline-block">Thêm sản phẩm mới</h2>
							</div>
						</div>
						<f:form action="admin93123/product/add.htm"
							class="tm-edit-product-form" modelAttribute="productForm"
							method="POST" enctype="multipart/form-data">
							<div class="row tm-edit-product-row">
								<!-- Cột 1 -->
								<div class="col-xl-4 col-lg-4 col-md-12">
									<div class="form-group mb-3">
										<label for="masp">Mã sản phẩm</label>
										<f:input id="masp" path="maSP" type="text"
											class="form-control validate" required="true" />
									</div>
									<div class="form-group mb-3">
										<label for="kieuSP">Kiểu sản phẩm</label>
										<f:select class="custom-select" id="kieuSP"
											path="maKieu.maKieu">
											<c:forEach items="${listkieu}" var="k">
												<option value="${k.maKieu}"
													${k.maKieu == sanPham.maKieu.maKieu ? 'selected="selected"' : ''}>
													${k.tenKieu}</option>
											</c:forEach>
										</f:select>
									</div>
									<div class="form-group mb-3">
										<label for="tenSanPham">Tên sản phẩm</label>
										<f:input id="tenSanPham" path="tenSanPham" type="text"
											class="form-control validate" required="true" />
									</div>
									<div class="form-group mb-3">
										<label for="moTa">Mô tả</label>
										<f:textarea id="moTa" path="moTa"
											class="form-control validate" rows="3"></f:textarea>
									</div>
									<div class="form-group mb-3">
										<label for="soLuong">Số lượng</label>
										<f:input id="soLuong" path="soLuong" type="number" min="1"
											class="form-control validate" required="true" />
									</div>
								</div>

								<!-- Cột 2 -->
								<div class="col-xl-4 col-lg-4 col-md-12">
									<div class="form-group mb-3">
										<label for="donGia">Giá bán</label>
										<f:input id="donGia" path="donGia" type="number" min="0"
											class="form-control validate" required="true" />
									</div>
									<div class="form-group mb-3">
										<label for="trangThai">Trạng thái</label>
										<f:select id="trangThai" path="trangThai"
											class="custom-select">
											<option value="true">Đang bán</option>
											<option value="false">Ngừng bán</option>
										</f:select>
									</div>
									<div class="form-group mb-3">
										<label for="mauSac">Màu sắc</label>
										<f:input id="mauSac" path="mauSac" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="avatar">Hình ảnh đại diện</label> <input
											type="file" name="avatar" id="avatar"
											class="form-control-file" onchange="previewAvatar(event);"
											required="true" /> <img id="avatar-preview" class="d-none"
											alt="Avatar preview"
											style="width: 100%; height: auto; margin-top: 10px;" />
									</div>
									<div class="form-group mb-3">
										<label for="manHinh">Màn hình</label>
										<f:input id="manHinh" path="manHinh" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="kichThuocManHinh">Kích thước màn hình</label>
										<f:input id="kichThuocManHinh" path="kichThuocManHinh"
											type="text" class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="doPhanGiai">Độ phân giải</label>
										<f:input id="doPhanGiai" path="doPhanGiai" type="text"
											class="form-control validate" />
									</div>

									<div class="form-group mb-3">
										<label for="giamGia">Giảm giá</label>
										<f:input id="giamGia" path="giamGia" type="number" min="0"
											max="100" class="form-control validate" />
									</div>

								</div>

								<!-- Cột 3 -->
								<div class="col-xl-4 col-lg-4 col-md-12">
									<div class="form-group mb-3">
										<label for="cameraSau">Camera sau</label>
										<f:input id="cameraSau" path="cameraSau" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="cameraTruoc">Camera trước</label>
										<f:input id="cameraTruoc" path="cameraTruoc" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="cpu">CPU</label>
										<f:input id="cpu" path="cpu" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="ram">RAM</label>
										<f:input id="ram" path="ram" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="boNhoTrong">Bộ nhớ trong</label>
										<f:input id="boNhoTrong" path="boNhoTrong" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="pin">Pin</label>
										<f:input id="pin" path="pin" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="congKetNoi">Cổng kết nối</label>
										<f:input id="congKetNoi" path="congKetNoi" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="ketNoiKhac">Kết nối khác</label>
										<f:input id="ketNoiKhac" path="ketNoiKhac" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="kichThuoc">Kích thước</label>
										<f:input id="kichThuoc" path="kichThuoc" type="text"
											class="form-control validate" />
									</div>
									<div class="form-group mb-3">
										<label for="trongLuong">Trọng lượng</label>
										<f:input id="trongLuong" path="trongLuong" type="text"
											class="form-control validate" />
									</div>
								</div>

								<!-- Nút Thêm -->
								<div class="col-12">
									<button type="submit"
										class="btn btn-primary btn-block text-uppercase" name="add">Thêm
										sản phẩm</button>
								</div>
							</div>
						</f:form>


					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="<c:url value='js/jquery-3.3.1.min.js'/>"></script>
	<!-- https://jquery.com/download/ -->
	<script src="<c:url value='jquery-ui-datepicker/jquery-ui.min.js'/>"></script>
	<!-- https://jqueryui.com/download/ -->
	<script src="<c:url value='js/bootstrap.min.js'/>"></script>
	<!-- https://getbootstrap.com/ -->

	<script src="//cdn.ckeditor.com/4.21.0/standard/ckeditor.js"></script>
	<script>
		CKEDITOR.replace('moTa');
	</script>

	<script>
		function previewAvatar(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var avatarPreview = document.getElementById('avatar-preview');
				avatarPreview.src = reader.result;
				avatarPreview.classList.remove('d-none');
			};
			reader.readAsDataURL(event.target.files[0]);
		}

		function validateForm() {
			var avatar = document.getElementById("avatar");
			var images = document.getElementById("images");
			var thongSo = document.getElementById("thongSo");

			if (avatar.value == "") {
				// Nếu chưa chọn hình đại diện, hiển thị thông báo lỗi
				document.getElementById("avatar-error").style.display = "block";
				return false;
			}
			return true;
		}

		// Gán hàm validateForm cho sự kiện onSubmit của form
		document.getElementsByTagName("form")[0].onsubmit = validateForm;
	</script>

</body>
</html>

