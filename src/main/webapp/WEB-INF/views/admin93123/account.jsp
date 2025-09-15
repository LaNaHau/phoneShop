<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
	<base href="${pageContext.servletContext.contextPath}/">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Quản lý tài khoản</title>
    <link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Roboto:400,700"
    />
    <!-- https://fonts.google.com/specimen/Roboto -->
    <link rel="stylesheet" href='<c:url value="/assets/css/admin93123/css/fontawesome.min.css"/>' />   
    <!-- https://fontawesome.com/ -->
    <link rel="stylesheet" href='<c:url value="/assets/css/admin93123/css/bootstrap.min.css"/>' />
    <!-- https://getbootstrap.com/ -->
    <link rel="stylesheet" href='<c:url value="/assets/css/admin93123/css/templatemo-style.css"/>' />
    <!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->
  </head>

  <body id="reportsPage">
    <div class="" id="home">
        <%@ include file="include/menu.jsp" %> 
        <%@ include file="include/footer.jsp" %>
        
      <div class="container mt-5">
        <div class="row tm-content-row">
          <div class="col-12 tm-block-col">
            <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
              <h2 class="tm-block-title">Danh sách tài khoản</h2>
              <p class="text-white">Tài khoản</p>
              <select class="custom-select">
                <option value="0">Chọn loại tài khoản</option>
                <option value="1">Admin</option>
                <option value="2">Khách hàng</option>
              </select>
            </div>
          </div>
        </div>
        
      </div>

    </div>

    <script src="js/jquery-3.3.1.min.js"></script>
    <!-- https://jquery.com/download/ -->
    <script src="js/bootstrap.min.js"></script>
    <!-- https://getbootstrap.com/ -->
  </body>
</html>
