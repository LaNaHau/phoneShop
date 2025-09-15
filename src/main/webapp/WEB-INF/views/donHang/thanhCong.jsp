<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Đặt hàng thành công</title>
<!-- link -->
<link rel="stylesheet"
	href="<c:url value="/assets/font/themify-icons/themify-icons.css"/>" />

<link rel="shortcut icon" href="assets/img/favicon.png"
	type="image/x-icon">
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">

<link
	href="https://fonts.googleapis.com/css?family=Nunito+Sans:400,400i,700,900&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400&display=swap"
	rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400&display=swap"
	rel="stylesheet" />
</head>
<style>
html{
font-family: "Roboto", sans-serif;
}
body {
	background-image: linear-gradient(to right, #797979, #806d84, #975b7c, #ad4360, #b53131);
	background-attachment: fixed;
	background-size: cover;
	    display: flex;
    align-items: center;
}

h1 {
	color: #FF6868;
	font-weight: 900;
	font-size: 40px;
	margin-bottom: 10px;
}

p {
	color: #404F5E;
	font-size: 20px;
	margin: 0;
}

i {
	color: #FF6868;
	font-size: 100px;
	line-height: 200px;
	
}
a{    margin-top: 20px;
    text-align: center;
    /* width: fit-content; */
    display: block;
    width: auto;
    background-color: #FF6868;
    padding: 10px;
    color: white;
    text-decoration: none;
    font-weight: bold;}

a:hover{
opacity: 0.7;
}

.card {
	background: white;
	padding: 60px;
	border-radius: 4px;
	box-shadow: 0 2px 3px #C8D0D8;
	display: inline-block;
	margin: 0 auto;
}
</style>
<body>
	<div class="card">
		<div
			style="border-radius: 200px; height: 200px; width: 200px; background: #F8FAF5; margin: 0 auto;">
			<i class="checkmark">✓</i>
		</div>
		<h1>ĐẶT HÀNG THÀNH CÔNG</h1>
		<p>
			Chúng tôi đã nhận được yêu cầu mua hàng của bạn;<br /> chúng tôi sẽ
			sớm liên hệ với bạn!
		</p>
		<a href=" ">Về trang chủ <b class="ti-arrow-right"></b> </a>
	</div>
</body>
</html>