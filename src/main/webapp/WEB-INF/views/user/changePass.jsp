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
<title>Đổi Mật Khẩu</title>
<!-- Link -->
<link rel="shortcut icon" href="assets/img/favicon.png" type="image/x-icon">
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet" href='<c:url value="/assets/css/dangNhap.css"/>' />

</head>
<body>
	<div class="auth-background">
		<div class="auth-container">
			<h1>Đổi Mật Khẩu</h1>
			<form class="auth-form" action="form/changePass.htm" method="post">
				<div class="form-group">
					<label for="oldPassword">Mật khẩu cũ:</label>
					<input type="password" id="oldPassword" name="oldPassword" class="form-control" placeholder="Nhập mật khẩu cũ">
				</div>
				<div class="form-group">
					<label for="newPassword">Mật khẩu mới:</label>
					<input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới">
				</div>
				<div class="form-group">
					<label for="confirmPassword">Xác nhận mật khẩu:</label>
					<input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới">
				</div>
				<span class="error">${errorMessage}</span>
				<button type="submit" class="btn-submit">Xác Nhận</button>
			</form>
		</div>
	</div>
</body>
</html>
