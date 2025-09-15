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
<title>Quản lý tài khoản</title>
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700" />
<!-- https://fonts.google.com/specimen/Roboto -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/fontawesome.min.css"/>' />
<!-- https://fontawesome.com/ -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/bootstrap.min.css"/>' />
<!-- https://getbootstrap.com/ -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/templatemo-style.css"/>' />
<!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->

<style type="text/css">
.loi {
	color: orange;
	font-size: 13px;
	font-style: italic;
}
</style>

</head>

<body id="reportsPage">
	<div class="" id="home">
		<%@ include file="include/menu.jsp"%>





		<!-- TEST -->


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
								<h2 class="tm-block-title d-inline-block">THÔNG TIN</h2>
							</div>
						</div>
						<f:form action="admin93123/changeInfo.htm" class="tm-edit-product-form"
							modelAttribute="admin" method="POST">

							<div class="row">
								<div class="form-group mb-3 col-xs-12 col-sm-6">
									<label class="form-label">Họ Tên</label>

									<f:input type="text" class="form-control" path="hoTen"
										name="hoTen" autocomplete="off" />
									<span class="loi">${loiHoTen}</span>
								</div>

								<div class="form-group mb-3 col-xs-12 col-sm-6">
									<label class="form-label">Ngày Sinh</label> <input
										class="form-control" type="date" name="ngaySinh"
										value="${admin.ngaySinh}" /> <span class="loi">${loiNgaySinh}</span>
								</div>

								<div class="form-group mb-3 col-xs-12 col-sm-6">
									<label class="tittle">Giới Tính : </label> <label> <input
										type="radio" name="gioiTinh" value="true"
										${admin.gioiTinh ? 'checked="checked"' : ''} /> Nam
									</label> <label> <input type="radio" name="gioiTinh"
										value="false" ${!admin.gioiTinh ? 'checked="checked"' : ''} />
										Nữ
									</label> <br>




								</div>
								<div class="form-group mb-3 col-xs-12 col-sm-6">
									<label class="form-label">SĐT</label>
									<f:input class="form-control" type="text" path="sdt" name="sdt"
										autocomplete="off" />
									<span class="loi">${loiSdt}</span>

								</div>
								<div class="form-group col-12">
									<label class="form-label">Địa Chỉ</label>

									<f:input class="form-control" type="text" path="diaChi"
										name="diaChi" autocomplete="off" />
									<span class="loi">${loiDiaChi}</span>

								</div>

								<div class="form-group col-12">
									<label class="form-label">Email</label>
									<f:input type="text" placeholder="xxx@gmail.com"
										class="form-control" path="email" name="email"
										autocomplete="off" />
									<span class="loi">${loiEmail}</span>
								</div>



								<div class="col-12">
									<button type="submit"
										class="btn btn-primary btn-block text-uppercase" name="save">Cập
										nhật thông tin</button>
								</div>
							</div>

						</f:form>

					</div>
				</div>
			</div>
		</div>








	</div>

	<%@ include file="include/footer.jsp"%>

	<script src="js/jquery-3.3.1.min.js"></script>
	<!-- https://jquery.com/download/ -->
	<script src="js/bootstrap.min.js"></script>
	<!-- https://getbootstrap.com/ -->
</body>
</html>
