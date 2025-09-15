<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Đăng Ký</title>
<style>
.requirement {
	text-align: left;
}

.requirement.valid {
	color: green;
}
</style>
<!-- Link CSS -->
<link rel="stylesheet" href="<c:url value='/assets/css/signup.css'/>" />
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap"
	rel="stylesheet" />
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
			<h1>Đăng Ký</h1>
			<p>Tạo tài khoản để trải nghiệm tốt hơn</p>

			<f:form class="auth-form" action="form/signup?signup"
				modelAttribute="user" method="post">
				<!-- Email -->
				<div class="form-group">
					<label>Email</label>
					<f:input type="text" placeholder="xxx@gmail.com"
						class="form-control" path="email" autocomplete="off" />
					<f:errors path="email" class="error" />
				</div>

				<!-- Username -->
				<div class="form-group">
					<label>Username</label>
					<f:input type="text" class="form-control" path="userName"
						autocomplete="off" />
					<f:errors path="userName" class="error" />
				</div>

				<!-- Password -->
				<div class="form-group">
					<label>Password (tối thiểu 8 ký tự)</label>
					<f:input type="password" class="form-control" path="passWord" id="password"/>
					<f:errors path="passWord" class="error" />
					<ul>
						<li id="uppercase" class="error requirement">Chứa ít nhất một
							ký tự in hoa</li>
						<li id="number" class="error requirement">Gồm ít nhất một chữ
							số từ 0-9</li>
						<li id="special" class="error requirement">Chứa các ký tự đặc
							biệt (!@#$%^&*)</li>

					</ul>
				</div>

				<!-- Confirm Password -->
				<div class="form-group">
					<label>Nhập lại mật khẩu</label> <input type="password"
						class="form-control" name="re-passWord" />
				</div>

				<!-- Full Name -->
				<div class="form-group">
					<label>Họ Tên</label>
					<f:input type="text" class="form-control" path="hoTen" />
					<f:errors path="hoTen" class="error" />
				</div>

				<!-- Gender -->
				<div class="form-group">
					<label>Giới Tính:</label>
					<div>
						<label><f:radiobutton path="gioiTinh" value="1" /> Nam</label> <label><f:radiobutton
								path="gioiTinh" value="0" /> Nữ</label>
					</div>
					<f:errors path="gioiTinh" class="error" />
				</div>

				<!-- Date of Birth -->
				<div class="form-group">
					<label>Ngày Sinh</label> <input type="date" class="form-control"
						id="ngaySinh" name="ngaySinh" value="${user.ngaySinh}" />
					<f:errors path="ngaySinh" class="error" />
				</div>

				<!-- Phone -->
				<div class="form-group">
					<label>Số Điện Thoại</label>
					<f:input type="text" class="form-control" path="sdt"
						autocomplete="off" />
					<f:errors path="sdt" class="error" />
				</div>

				<!-- Address -->
				<div class="form-group">
					<label>Địa Chỉ</label>
					<f:input type="text" class="form-control" path="diaChi"
						autocomplete="off" />
					<f:errors path="diaChi" class="error" />
				</div>
				<!-- reCAPTCHA -->
				<div class="form-group">
					<div class="g-recaptcha"
						data-sitekey="6LcgPaUqAAAAAGBZWv3MdsO8i_OHvy9Nb2VxzNiD"></div>
				</div>
				<!-- Submit Button -->
				<button class="btn-submit" type="submit" name="signup">Đăng
					Ký</button>
			</f:form>

			<div class="options">
				<a href="login.htm">Đã có tài khoản? Đăng nhập</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
    const passwordInput = document.getElementById('password');
    const requirements = {
        uppercase: document.getElementById('uppercase'),
        lowercase: document.getElementById('lowercase'),
        number: document.getElementById('number'),
        special: document.getElementById('special'),
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
    });
    </script>
</body>
</html>
