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
<title>Xác Nhận Mã</title>
<!-- link -->
<link rel="shortcut icon" href="assets/img/favicon.png"
	type="image/x-icon">
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet" href="<c:url value='/assets/css/verify.css'/>" />
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>
	<div class="auth-background">
		<div class="auth-container">
			<h1>Xác Nhận Mã</h1>
			<p>Hãy nhập mã xác nhận được gửi đến email:</p>
			<p id="span-email" class="email-display">${USERSIGNUP.email}</p>

			<form class="auth-form" action="form/verify.htm" method="post">
				<div class="form-group">
					<label for="verification-code">Nhập mã xác nhận:</label>
					<div class="form-input">
						<input type="text" class="form-control input-char" name="a"
							maxlength="1" autocomplete="off"> <input type="text"
							class="form-control input-char" name="b" maxlength="1"
							autocomplete="off"> <input type="text"
							class="form-control input-char" name="c" maxlength="1"
							autocomplete="off"> <input type="text"
							class="form-control input-char" name="d" maxlength="1"
							autocomplete="off"> <input type="text"
							class="form-control input-char" name="e" maxlength="1"
							autocomplete="off"> <input type="text"
							class="form-control input-char" name="f" maxlength="1"
							autocomplete="off">
					</div>
				</div>

				<span class="error messenger">${messenger}</span> <span
					class="options again">${again}</span> <span class="error">Thời
					gian nhập OTP: <span class="error timer" id="timer">${timer}</span>
					<button type="submit" class="btn-submit" id="btn-veri"
						name="verify">Xác Nhận</button>
					<button type="submit" class="btn-submit" id="btn-again"
						name="again">Gửi lại mã</button>
					<div class="form-group">
						<div class="g-recaptcha"
							data-sitekey="6LcgPaUqAAAAAGBZWv3MdsO8i_OHvy9Nb2VxzNiD"></div>
					</div>
			</form>
		</div>
	</div>

	<script>
		const inputs = document.querySelectorAll('.input-char');
		inputs.forEach((input, index) => {
			input.addEventListener('keyup', (event) => {
				const value = event.target.value;
				const maxLength = event.target.maxLength;
				if (value.length === maxLength) {
					if (index < inputs.length - 1) {
						inputs[index + 1].focus();
					}
				}
			});
		});
		let thoigian = document.getElementById("timer");
		let dem = Number(thoigian.innerHTML);
		if(dem > 0){
			const demnguoc = setInterval(function(){
				dem--;
				thoigian.innerHTML = dem;
				if(dem == 0){
					thoigian.innerHTML = "OTP đã hết hạn";
					clearInterval(demnguoc);
				}
			},1000);
		}
	</script>
</body>
</html>
