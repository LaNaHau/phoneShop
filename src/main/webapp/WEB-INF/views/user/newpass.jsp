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
<title>Mật Khẩu Mới</title>
<style>
.requirement {
	text-align: left;
}

.requirement.valid {
	color: green;
}

</style>
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
			<h1>Mật Khẩu Mới</h1>
			<form class="auth-form" action="form/newpass?hoanTat" method="post">
				<div class="form-group">
					<label for="newPassword">Mật khẩu mới:</label>
					<input type="password" id="newPassword" name="password" class="form-control" placeholder="Nhập mật khẩu mới">
					<ul>
						<li id="uppercase" class="error requirement">Chứa ít nhất một
							ký tự in hoa</li>
						<li id="number" class="error requirement">Gồm ít nhất một chữ
							số từ 0-9</li>
						<li id="special" class="error requirement">Chứa các ký tự đặc
							biệt (!@#$%^&*)</li>
						<li id="length" class="error requirement">Độ dài ít nhất 8 ký
							tự</li>

					</ul>
				</div>
				<div class="form-group">
					<label for="confirmPassword">Xác nhận mật khẩu:</label>
					<input type="password" id="confirmPassword" name="confirmPass" class="form-control" placeholder="Nhập lại mật khẩu mới">
				</div>
				<span class="error">${errorMessage}</span>
				<button type="submit" class="btn-submit">Cập Nhật</button>
			</form>
		</div>
	</div>
	<script type="text/javascript">
    const passwordInput = document.getElementById('newPassword');
    const requirements = {
        uppercase: document.getElementById('uppercase'),
        lowercase: document.getElementById('lowercase'),
        number: document.getElementById('number'),
        special: document.getElementById('special'),
        length: document.getElementById('length'),
    };

    passwordInput.addEventListener('input', () => {
        const value = passwordInput.value;

        // kiem tra upper
        if (/[A-Z]/.test(value)) {
            requirements.uppercase.classList.add('valid');
        } else {
            requirements.uppercase.classList.remove('valid');
        }

        // kiem tra numbers
        if (/[0-9]/.test(value)) {
            requirements.number.classList.add('valid');
        } else {
            requirements.number.classList.remove('valid');
        }

        // kiem tra ky tu dac biet
        if (/[^A-Za-z0-9]/.test(value)) {
            requirements.special.classList.add('valid');
        } else {
            requirements.special.classList.remove('valid');
        }
        
        // kiem tra do dai chuoi
        if (value.length >= 8) {
            requirements.length.classList.add('valid');
        } else {
            requirements.length.classList.remove('valid');
        }
    });
    </script>
</body>
</html>
