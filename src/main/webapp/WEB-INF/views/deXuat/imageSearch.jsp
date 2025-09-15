<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
 <link href="assets/css/font-awesome.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">   
    <!-- SmartMenus jQuery Bootstrap Addon CSS -->
    <link href="assets/css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
    <!-- Product view slider -->
    <link rel="stylesheet" type="text/css" href="assets/css/jquery.simpleLens.css">    
    <!-- slick slider -->
    <link rel="stylesheet" type="text/css" href="assets/css/slick.css">
    <!-- price picker slider -->
    <link rel="stylesheet" type="text/css" href="assets/css/nouislider.css">
    <!-- Theme color -->
    <link id="switcher" href="assets/css/theme-color/default-theme1.css" rel="stylesheet">
    <!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
    <!-- Top Slider CSS -->
    <link href="assets/css/sequence-theme.modern-slide-in.css" rel="stylesheet" media="all">

    <!-- Main style sheet -->
    <link href="assets/css/style.css" rel="stylesheet">    

    <!-- Google Font -->
    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'> 
    

<style>
  /* CSS để định vị hình ảnh và loading */
  .upload-btn-wrapper {
    text-align: center;
    margin-top: 20px;
  }

  #uploadedImageDisplay {
    width: 250px;
    height: 300px;
    margin: 20px auto; /* Để căn giữa theo chiều ngang và dưới theo chiều dọc */
    max-width: 100%;
    display: none;
  }

  #loading {
    display: none;
  }

  /* CSS để căn giữa danh sách sản phẩm */
  .content {
    margin-top: 20px;
    text-align: center;
  }
  
  #uploadedImage{
  	margin-top: 10px;
  }
  
  #btnSearchImg{
    margin-top: 10px;
  	margin-bottom: 20px;
  }
</style>


  </head>
  <!-- !Important notice -->
  <!-- Only for product page body tag have to added .productPage class -->
  
  <title>Image Search</title>
  
  <body class="productPage">  
 
  <%@ include file="../include/header.jsp" %>

  	
  	<div class="container content text-center">
        <h2>Tìm kiếm sản phẩm bằng hình ảnh</h2>
        <div class="upload-btn-wrapper">
            <form method="POST" enctype="multipart/form-data" onsubmit="return validateForm();">    
            	<input type="file" id="uploadedImage" name="avatar" onchange="handleImageUpload(this);">
				<button name="btnSearchImg" id="btnSearchImg" type="submit" onclick="showLoading();">Tìm sản phẩm tương tự</button>
            </form>
        </div>
         <div id="error-message" class="alert alert-danger" style="display: none;">
	        Bạn chưa tải lên tệp nào.
	    </div>
        <img id="uploadedImageDisplay" style="width: 250px; height: 300px;" alt="Uploaded Image">
        <div id="loading">
            <img src="assets/img/loading.gif" alt="Loading">
        </div>
        <div>
            <!-- Kiểm tra danh sách imageNames có rỗng hay không -->
            <c:choose>
                <c:when test="${not empty message}">
                    <p>Không có sản phẩm cần tìm.</p>
                </c:when>
                <c:otherwise>
                    <!-- Hiển thị danh sách sản phẩm -->
                    <h3>${messageTrue}</h3>
        			<div class="tab-pane fade in active" id="popular">
						<ul class="aa-product-catg aa-popular-slider">
							<!-- start single product item -->
							<c:forEach items="${products}" var="sp">
							<li>
								<figure>
									<a class="aa-product-img" href="product/${sp.maSP}.htm"><img
										src="${sp.hinhAnh.link}" style="width:250px; height:300px;"alt="product img"></a>
									<!-- <a class="aa-add-card-btn" href="#"><span
										class="fa fa-shopping-cart"></span>Add To Cart</a> -->
									<figcaption>
									<h4 class="aa-product-title">
										<a href="product/${sp.maSP}.htm"
											style="font-weight: bold; color: #3D71B6;">${sp.tenSanPham}</a>
									</h4>
									
									<span class="aa-product-price"><fmt:formatNumber
														value="${sp.donGia}" pattern="#,##0" />đ</span><span
													class="aa-product-price"></span>
								</figcaption>
								</figure>
							</li>
							</c:forEach>
						</ul>
					</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

   
  <%@ include file = "../include/footer.jsp" %>
  
  
<script>
  
  // JavaScript để hiển thị loading khi nhấn nút "Tìm sản phẩm"
  function showLoading() {
    $('#loading').css('display', 'block');
  }
  
//JavaScript để kiểm tra trước khi gửi form
  function validateForm() {
      var uploadedImageInput = document.getElementById('uploadedImage');
      var errorMessageBox = document.getElementById('error-message');
      var loadingImage = document.getElementById('loading');
      
      if (uploadedImageInput.files.length === 0) {
          // Hiển thị thông báo lỗi nếu không có tệp hình ảnh được chọn
          errorMessageBox.style.display = 'block';
       	  // Ẩn gif loading
          loadingImage.style.display = 'none';
          return false; // Ngăn chặn việc gửi form
      }
      
      // Nếu có tệp hình ảnh được chọn, ẩn thông báo lỗi và cho phép gửi form
      errorMessageBox.style.display = 'none';
      return true;
  }
  

  
//JavaScript để hiển thị hình ảnh khi tải lên và kiểm tra trước khi gửi form
  function handleImageUpload(input) {
      var errorMessageBox = document.getElementById('error-message');
      var loadingImage = document.getElementById('loading');
      var uploadedImageDisplay = document.getElementById('uploadedImageDisplay');
	  
      if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
              // Hiển thị hình ảnh
              uploadedImageDisplay.src = e.target.result;
              uploadedImageDisplay.style.display = 'block';
              
              // Ẩn thông báo lỗi
              errorMessageBox.style.display = 'none';
              
              // Ẩn gif loading
              loadingImage.style.display = 'none';
          }

          reader.readAsDataURL(input.files[0]);
      } else {
          // Hiển thị thông báo lỗi nếu không có tệp hình ảnh được chọn
          errorMessageBox.style.display = 'block';
          
          // Ẩn gif loading
          loadingImage.style.display = 'none';
      }
  }
  
  
  /*   // JavaScript để hiển thị hình ảnh khi tải lên
  function showImage(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#uploadedImageDisplay').attr('src', e.target.result);
        $('#uploadedImageDisplay').css('display', 'block');
      }

      reader.readAsDataURL(input.files[0]);
    }
  } */

  /* //JavaScript để kiểm tra trước khi gửi form
  function checkImage(input) {
      var errorMessageBox = document.getElementById('error-message');
      var loadingImage = document.getElementById('loading');

      if (input.files.length === 0) {
          // Hiển thị thông báo lỗi nếu không có tệp hình ảnh được chọn
          errorMessageBox.style.display = 'block';
          // Ẩn gif loading
          loadingImage.style.display = 'none';
      } else {
          // Nếu có tệp hình ảnh được chọn, ẩn thông báo lỗi và không hiển thị gif loading
          errorMessageBox.style.display = 'none';
      }
  } */
  
</script>
  
  
     <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="assets/js/bootstrap.js"></script>  
  <!-- SmartMenus jQuery plugin -->
  <script type="text/javascript" src="assets/js/jquery.smartmenus.js"></script>
  <!-- SmartMenus jQuery Bootstrap Addon -->
  <script type="text/javascript" src="assets/js/jquery.smartmenus.bootstrap.js"></script>  
  <!-- To Slider JS -->
  <script src="assets/js/sequence.js"></script>
  <script src="assets/js/sequence-theme.modern-slide-in.js"></script>  
  <!-- Product view slider -->
  <script type="text/javascript" src="assets/js/jquery.simpleGallery.js"></script>
  <script type="text/javascript" src="assets/js/jquery.simpleLens.js"></script>
  <!-- slick slider -->
  <script type="text/javascript" src="assets/js/slick.js"></script>
  <!-- Price picker slider -->
  <script type="text/javascript" src="assets/js/nouislider.js"></script>
  <!-- Custom js -->
  <script src="assets/js/custom.js"></script> 




	<script src="<c:url value='assets/js/search.js'/>"></script>
  </body>
</html>