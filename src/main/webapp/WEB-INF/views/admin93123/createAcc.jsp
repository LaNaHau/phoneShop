<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
	<base href="${pageContext.servletContext.contextPath}/">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Thêm sản phẩm</title>
    <link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
    <!-- https://fonts.google.com/specimen/Roboto -->
    <link rel="stylesheet" href='<c:url value="/assets/css/admin93123/css/fontawesome.min.css"/>' />   
    <!-- https://fontawesome.com/ -->
    <link rel="stylesheet" href='<c:url value="/assets/css/admin93123/jquery-ui-datepicker/jquery-ui.min.css" />' type="text/css"  /> 
    <!-- http://api.jqueryui.com/datepicker/ -->
    <link rel="stylesheet" href='<c:url value="/assets/css/admin93123/css/bootstrap.min.css"/>' />
    <!-- https://getbootstrap.com/ -->
    <link rel="stylesheet" href='<c:url value="/assets/css/admin93123/css/templatemo-style.css"/>' />
    <!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->
	
	
	<style type="text/css">
	
	
	*[id$=errors]{
color:#ffc107;
font-style: italic;
font-size: 15px;
}
	
	</style>
	
	
 </head>

<body id="reportsPage">
    <div class="" id="home">
        <%@ include file="include/menu.jsp" %>
    
    <div class="container tm-mt-big tm-mb-big">
      <div class="row">
        <div class="col-xl-9 col-lg-10 col-md-12 col-sm-12 mx-auto">
          <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
            <div class="row">
              <div class="col-12">
              		<c:if test="${not empty successMessage}">
					    <div class="alert alert-success">${successMessage}</div>
					</c:if>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger">${errorMessage}</div>
					</c:if>
                <h2 class="tm-block-title d-inline-block">Thêm Admin mới</h2>
              </div>
            </div>
            <f:form action="admin93123/form/addAcc.htm" class="tm-edit-product-form" modelAttribute="admin" method="POST" >
            
           <div class="row">
	    				<div class="form-group mb-3 col-xs-12 col-sm-6">
	    				     <label class="form-label">Họ Tên</label>
					<f:input type="text" class="form-control" path="hoTen" />
					<f:errors path="hoTen" /> 	
	    				</div>
	    				
	    				<div class="form-group mb-3 col-xs-12 col-sm-6">   				    
	    				   <label class="form-label">Ngày Sinh</label>
					<input type="date" class="form-control" id="ngaySinh"
						 name="ngaySinh" value="${user.ngaySinh}" />
					<f:errors path="ngaySinh" />
	    			</div>
	    			<div class="form-group mb-3 col-xs-12 col-sm-6">
					<label class="form-label">Giới Tính:</label> <br>
					 <label><f:radiobutton
							path="gioiTinh" value="1" /> Nam</label> <br>
							<label><f:radiobutton
							path="gioiTinh" value="0" /> Nữ</label>
							
					<f:errors path="gioiTinh" />

				</div>
				<div class="form-group mb-3 col-xs-12 col-sm-6">
					<label class="form-label">SĐT</label>
					<f:input type="text" class="form-control" path="sdt"  autocomplete="off"/>
					<f:errors path="sdt" />
				</div>
                    <div class="form-group col-12">
    				  <label class="form-label">Địa Chỉ</label>
					<f:input type="text" class="form-control" path="diaChi"  autocomplete="off"/>
					<f:errors path="diaChi" />
    				  
    				</div>  
    				
    				<div class="form-group mb-3 col-xs-12 col-sm-6">
					<label class="form-label">Email</label>
					<f:input type="text" placeholder="xxx@gmail.com"
						class="form-control" path="email" name="email"  autocomplete="off" />
					<f:errors path="email" />
				</div>
				<div class="form-group mb-3 col-xs-12 col-sm-6">
					<label class="form-label">Username</label>
					<f:input type="text" class="form-control" path="userName"  autocomplete="off" />
					<f:errors path="userName" />
				</div>
				<div class="form-group mb-3 col-xs-12 col-sm-6">
					<label class="form-label">Password (tối thiểu 8 kí tự)</label>
					<f:input type="password" class="form-control" path="passWord" />
					<f:errors path="passWord" />
				</div>
				<div class="form-group mb-3 col-xs-12 col-sm-6">
				<label class="form-label">Nhập lại mật khẩu </label> <input
						type="password" class="form-control" name="re-passWord">
				</div>
    				
    				    
          <div class="col-12">
                <button type="submit" class="btn btn-primary btn-block text-uppercase" name="add">Thêm admin</button>
          </div>  
          </div>
          
          </f:form>
        </div>
      </div>
    </div>
    </div>
    </div>


    <script src="<c:url value='js/jquery-3.3.1.min.js'/>"></script>
    <!-- https://jquery.com/download/ -->
    <script src="<c:url value='jquery-ui-datepicker/jquery-ui.min.js'/>"></script>
    <!-- https://jqueryui.com/download/ -->
    <script src="<c:url value='js/bootstrap.min.js'/>"></script>
    <!-- https://getbootstrap.com/ -->
    
    
    
  </body>
</html>

