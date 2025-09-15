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
<title>Sửa Voucher</title>
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
								<h2 class="tm-block-title d-inline-block">Sửa Voucher</h2>
							</div>
						</div>
						<f:form action="admin93123/voucher/edit/${voucher.maVoucher}.htm"
							class="tm-edit-product-form" method="POST"
							modelAttribute="voucher">
							<div class="row tm-edit-product-row">
								<div class="col-xl-12 col-lg-12 col-md-12">

									<div class="form-group mb-3">
										<label for="name">Mã Voucher</label>
										<f:input id="maVoucher" path="maVoucher" type="text"
											value="${voucher.maVoucher}" class="form-control validate"
											required="true" readonly="true"/>
									</div>
									<c:if test="${voucher.loai == 0}">
										<div class="form-group mb-3">
											<label for="name">Loại Voucher</label>
											<f:select class="custom-select" id="loai" path="loai">
												<option value=0 selected>Giảm thẳng</option>
												<option value=1>Giảm phần trăm</option>
											</f:select>
										</div>
									</c:if>
									<c:if test="${voucher.loai == 1}">
										<div class="form-group mb-3">
											<label for="name">Loại Voucher</label>
											<f:select class="custom-select" id="loai" path="loai">
												<option value=0>Giảm thẳng</option>
												<option value=1 selected>Giảm phần trăm</option>
											</f:select>
										</div>
									</c:if>
									<div class="form-group mb-3">
										<label for="name">Nội dung</label>
										<f:input id="noiDung" path="noiDung" type="number"
											value="${voucher.noiDung}" min="0"
											class="form-control validate" required="true" />
									</div>
									<div class="form-group mb-3">
										<label for="name">Số lượng</label>
										<f:input id="soLuong" path="soLuong" type="number"
											value="${voucher.soLuong}" min="0"
											class="form-control validate" required="true" />
									</div>
									<c:if test="${voucher.trangThai == 0}">
										<div class="form-group mb-3">
										<label for="name">Trạng thái</label>
										<f:select class="custom-select" id="trangThai"
											path="trangThai">
											<option value=0 selected>Còn hiệu lực</option>
											<option value=1>Hết hiệu lực</option>
										</f:select>
									</div>
									</c:if>
									<c:if test="${voucher.trangThai == 1}">
										<div class="form-group mb-3">
										<label for="name">Trạng thái</label>
										<f:select class="custom-select" id="trangThai"
											path="trangThai">
											<option value=0>Còn hiệu lực</option>
											<option value=1 selected>Hết hiệu lực</option>
										</f:select>
									</div>
									</c:if>

									<c:if test="${not empty successMessage}">
										<div class="alert alert-success">${successMessage}</div>
									</c:if>
									<c:if test="${not empty errorMessage}">
										<div class="alert alert-danger">${errorMessage}</div>
									</c:if>
								</div>
								<div class="col-12">
									<button type="submit"
										class="btn btn-primary btn-block text-uppercase" name="update">Sửa
										voucher</button>
								</div>
							</div>

						</f:form>
					</div>
				</div>
			</div>
		</div>
		<%-- <%@ include file="include/footer.jsp" %> --%>
	</div>


	<script src="<c:url value='js/jquery-3.3.1.min.js'/>"></script>
	<!-- https://jquery.com/download/ -->
	<script src="<c:url value='jquery-ui-datepicker/jquery-ui.min.js'/>"></script>
	<!-- https://jqueryui.com/download/ -->
	<script src="<c:url value='js/bootstrap.min.js'/>"></script>
	<!-- https://getbootstrap.com/ -->


</body>
</html>

