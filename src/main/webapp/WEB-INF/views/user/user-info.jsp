<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<style>
/* Nút "Cập nhật thông tin" */
#btn-save {
	background-color: #007bff; /* Màu xanh dương nhạt */
	color: #fff; /* Màu chữ trắng */
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

#btn-save:hover {
	background-color: #0056b3; /* Màu xanh dương đậm hơn khi hover */
	transform: scale(1.05); /* Phóng to nhẹ khi hover */
}

#btn-save:active {
	background-color: #004085; /* Màu tối hơn khi nhấn */
	transform: scale(0.95); /* Thu nhỏ nhẹ khi nhấn */
}

/* Nút "Xác nhận" */
.aa-browse-btn {
	background-color: #28a745; /* Màu xanh lá */
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.aa-browse-btn:hover {
	background-color: #218838; /* Màu xanh lá đậm hơn khi hover */
	transform: scale(1.05);
}

.aa-browse-btn:active {
	background-color: #1e7e34; /* Màu tối hơn khi nhấn */
	transform: scale(0.95);
}
</style>

<base href="${pageContext.servletContext.contextPath}/">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PTIT PHONE SHOP | Account Page</title>
<script>
	function displayImage(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				document.getElementById('avatar').src = e.target.result;
			}

			reader.readAsDataURL(input.files[0]); // Convert to base64 string
		}
	}
</script>
<link rel="stylesheet"
	href='<c:url value="/assets/css/font-awesome.css"/>' />
<!-- Bootstrap -->
<link rel="stylesheet" href='<c:url value="/assets/css/bootstrap.css"/>'>
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/jquery.smartmenus.bootstrap.css"/>'>
<!-- Product view slider -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/assets/css/jquery.simpleLens.css"/>'>
<!-- slick slider -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/assets/css/slick.css"/>'>
<!-- price picker slider -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/assets/css/nouislider.css"/>'>
<!-- Theme color -->
<link id="switcher" rel="stylesheet"
	href='<c:url value="/assets/css/theme-color/default-theme.css"/>'>
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link rel="stylesheet" media="all"
	href='<c:url value="/assets/css/sequence-theme.modern-slide-in.css"/>'>

<!-- Main style sheet -->
<link rel="stylesheet" href='<c:url value="/assets/css/style.css"/>'>

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


	<!-- SCROLL TOP BUTTON -->
	<a class="scrollToTop" href="#"><i class="fa fa-chevron-up"></i></a>
	<!-- END SCROLL TOP BUTTON -->


	<%@ include file="../include/header.jsp"%>
	<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="aa-myaccount-area">
						<div class="row">
							<div class="col-md-6">
								<div class="aa-myaccount-login">
									<h4>Thông tin cá nhân</h4>

									<f:form class="aa-login-form" action="form/info.htm"
										modelAttribute="user" method="post">
										<%-- <img id="avatar" src="assets/uploads/${user.avatar}" alt="Ảnh đã lưu" class = "round-image" style="width:200px; height: 200px;"/>
										
										<input type="file" id = "fileInput" name="image" accept="image/*" onchange="displayImage(this)"><br>
										 --%>
										<span class="loi" style="color: red; font-size: 13px;">${loiAvatar}</span>
										<label for="">Username : </label>
										<b> <span> ${user.userName != null ? user.userName : ''}
										</span></b>
										<br>
										<f:input class="hide" path="maNd" name="maNd"
											value="${user.maNd != null ? user.maNd : ''}" />

										<label for="">Họ Tên :</label>
										<f:input class="value" type="text" path="hoTen" name="hoTen"
											autocomplete="off" />
										<span class="loi" style="color: red; font-size: 13px;">${loiHoTen}</span>
										<br>
										<%-- <img id="avatar" src="assets/uploads/${user.avatar}" alt="Ảnh đã lưu" class = "round-image" style="width:200px; height: 200px;"/>
										
										<input type="file" id = "fileInput" name="image" accept="image/*" onchange="displayImage(this)"><br>
										 --%>
										<span class="loi" style="color: red; font-size: 13px;">${loiAvatar}</span>
										<label for="">Email : </label>

										<b> <span> ${user.email} </span></b>
										<br>

										<label for="">SDT : </label>
										<b> <span> ${user.sdt} </span></b>
										<br>
										<label class="tittle">Giới Tính : </label>
										<label> <input type="radio" name="gioiTinh"
											value="true" ${user.gioiTinh ? 'checked="checked"' : ''} />
											Nam
										</label>
										<label> <input type="radio" name="gioiTinh"
											value="false" ${!user.gioiTinh ? 'checked="checked"' : ''} />
											Nữ
										</label>
										<br>
										<label class="tittle">Ngày Sinh: </label>
										<input class="value" type="date" name="ngaySinh"
											value="${user.ngaySinh != null ? user.ngaySinh : ''}" />
										<span class="loi" style="color: red; font-size: 13px;">${loiNgaySinh}</span>
										<br>
										<label for="">Địa Chỉ : </label>
										<f:input class="value" type="text" path="diaChi" name="diaChi"
											autocomplete="off" />
										<span class="loi" style="color: red; font-size: 13px;">${loiDiaChi}</span>
										<br>

										<button id="btn-save" name="save" class="aa-browse-btn">Cập
											nhật thông tin</button>
										<br>
										<br>
										<br>
										<c:if test="${not empty successMessage}">
											<div class="alert alert-success">${successMessage}</div>
										</c:if>
									</f:form>

								</div>
							</div>
							<div class="col-md-6">
								<div class="aa-myaccount-register">
									<h4>Đổi mật khẩu</h4>
									<f:form class="aa-login-form" action="form/changePass.htm"
										modelAttribute="user" method="post">
										<label for="">Mật khẩu cũ<span>*</span></label>
										<input type="password" name="password" />
										<span class="loi" style="color: red; font-size: 13px;">${loiPassword}</span>
										<br>
										<label for="">Mật khẩu mới (tối thiểu 8 kí tự)<span>*</span></label>
										<input type="password" name="newPassword" />
										<span class="loi" style="color: red; font-size: 13px;">${loiNewPassword}</span>
										<br>
										<label for="">Nhập lại mật khẩu mới<span>*</span></label>
										<input type="password" name="reNewPassword" />
										<span class="loi" style="color: red; font-size: 13px;">${loiRePassword}</span>
										<br>
										<button id="btn-save" name="save" class="aa-browse-btn">Xác
											nhận</button>

									</f:form>
									<br> <br> <br>
									<c:if test="${not empty successPassMessage}">
										<div class="alert alert-success">${successPassMessage}</div>
									</c:if>
								</div>
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


</body>
</html>