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
      
        
      <div class="container mt-5">
        <div class="row tm-content-row">
          <div class="col-12 tm-block-col">
            <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
              <h2 class="tm-block-title">Danh sách tài khoản Admin</h2>
              <a href="admin93123/createAcc.htm"><button type="button" class="btn btn-primary">Thêm tài khoản Admin</button></a>
             <table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">USERNAME</th>
      <th scope="col">HỌ TÊN</th>
        <th scope="col">TRẠNG THÁI</th>
          <th scope="col">THAO TÁC</th>
        <th scope="col">    </th>
    </tr>
  </thead>
  <tbody>
 <c:forEach var="admin" items="${adminList}" >
  <tr>
  <td>${admin.maNd }	</td>
      <td>${admin.userName }</td>
      <td>${admin.hoTen }</td>
      <td>
      <c:if test="${admin.trangThai==false}">
      <span style="color: red">Ngừng hoạt động</span> 
      
      </c:if>
       <c:if test="${admin.trangThai==true}">
      <span style="color: #ffc107">Hoạt động</span> 
      
      </c:if>
      </td>
      <td>
      <c:if test="${admin.trangThai==false}">
      <a href="admin93123/on/${admin.maNd}.htm" style="color: #80c2eb ; font-size: 20px" >  <i id="toggleIcon1" class="fas fa-toggle-off"></i></a> 
      
      </c:if>
       <c:if test="${admin.trangThai==true}">
      <a href="admin93123/off/${admin.maNd}.htm" style="color: #80c2eb;font-size: 20px">  <i id="toggleIcon1" class="fas fa-toggle-on"></i></a> 
      
      </c:if>
      
      </td>
      <td><a href="admin93123/inforAcc/${admin.maNd}.htm" style="color:aqua">Chi tiết</a> </td>
  </tr>
  </c:forEach>
  
   
  
  </tbody>
</table>
            </div>
          </div>
        </div>
        
      </div>


	  <%-- <%@ include file="include/footer.jsp" %> --%>
    </div>

    <script src="js/jquery-3.3.1.min.js"></script>
    <!-- https://jquery.com/download/ -->
    <script src="js/bootstrap.min.js"></script>
    <!-- https://getbootstrap.com/ -->
  </body>
</html>
