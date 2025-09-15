<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Quên Mật Khẩu</title>
<!-- Link -->
<link rel="shortcut icon" href="assets/img/favicon.png"
	type="image/x-icon">
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet" href='<c:url value="/assets/css/dangNhap.css"/>' />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>
	<div class="auth-background">
		<!-- Add the Home button/link here -->
		<div class="home-button">
			<a href="<c:url value='/ShopDienThoai/'/>" class="btn-home"> <i
				class="fas fa-home"></i> Home
			</a>
		</div>
		<div class="auth-container">
			<h1>Quên Mật Khẩu</h1>
			<form class="auth-form" action="form/forgotpass?tieptheo"
				method="post">
				<div class="form-group">
					<label for="email">Email/Username:</label> <input type="text"
						id="email" name="username" class="form-control"
						placeholder="Nhập email/username đã đăng ký">
				</div>
				<span class="error">${errorMessage}</span>
				<!-- reCAPTCHA -->
				<div class="form-group">
					<div class="g-recaptcha"
						data-sitekey="6LcgPaUqAAAAAGBZWv3MdsO8i_OHvy9Nb2VxzNiD"></div>
				</div>
				<button type="submit" class="btn-submit">Gửi Yêu Cầu</button>
			</form>
		</div>
	</div>
</body>
</html>
