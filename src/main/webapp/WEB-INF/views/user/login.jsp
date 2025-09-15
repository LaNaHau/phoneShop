<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<!-- Link CSS -->
<link rel="stylesheet" href='<c:url value="/assets/css/dangNhap.css"/>' />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- Thêm script reCAPTCHA -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>

	<div class="auth-background">
	            <!-- Add the Home button/link here -->
            <div class="home-button">
                <a href="<c:url value='/ShopDienThoai/'/>" class="btn-home">
                    <i class="fas fa-home"></i> Home
                </a>
            </div>
		<div class="auth-container">
			<h1>Login</h1>
			<p>Have an account?</p>
			<f:form class="auth-form" id="form-login" action="form/login?login"
				modelAttribute="user" method="post">
				<div class="form-group">
					<f:input path="userName" placeholder="Username"
						cssClass="form-control" autocomplete="off" />
					<f:errors path="userName" class="error" />
				</div>
				<div class="form-group">
					<f:password path="passWord" placeholder="Password"
						cssClass="form-control" />
					<f:errors path="passWord" class="error" />
				</div>
				    <!-- reCAPTCHA -->
    <div class="form-group">
        <div class="g-recaptcha" data-sitekey="6LcgPaUqAAAAAGBZWv3MdsO8i_OHvy9Nb2VxzNiD"></div>
    </div>
				<button type="submit" class="btn-submit">SIGN IN</button>
				<div class="options">
					<label><input type="checkbox"> Remember Me</label> <a
						href="forgotpass">Forgot Password</a>
				</div>
				<div class="social-login">
					<p>_____________________</p>
					<div class="social-buttons">
						<!-- <button type="button" class="btn-social facebook">Facebook</button>
						<button type="button" class="btn-social twitter">Twitter</button>
					 --></div>
				</div>
			</f:form>

			<span class="error">${errorMessage}</span>
			<p class="switch-option">
				Don't have an account? <a href="<c:url value='/signup'/>"
					class="switch-to-signup">Sign Up</a>
			</p>
		</div>
	</div>
</body>
</html>
