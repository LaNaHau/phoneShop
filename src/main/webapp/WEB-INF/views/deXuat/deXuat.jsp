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
    <title>Đề xuất</title>
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

  </head>
  <!-- !Important notice -->
  <!-- Only for product page body tag have to added .productPage class -->
  <body class="productPage">  
 
  <%@ include file="../include/header.jsp" %>

   <!-- wpf loader Two -->
    <div id="wpf-loader-two">          
      <div class="wpf-loader-two-inner">
        <span>Loading</span>
      </div>
    </div> 
    <!-- / wpf loader Two -->       
 <!-- SCROLL TOP BUTTON -->
    <a class="scrollToTop" href="#"><i class="fa fa-chevron-up"></i></a>
  <!-- END SCROLL TOP BUTTON -->


 <div style="margin-left:40%">
        <h2 id="message">Đề xuất cho bạn</h2>
 </div>	
  <!-- / menu -->  
 
  <!-- catg header banner section -->

  <!-- / catg header banner section -->

  <!-- product category -->
  <section id="aa-product-category">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-product-catg-content">
            <div class="aa-product-catg-head">
              <div class="aa-product-catg-head-right">
                <a id="grid-catg" href="#"><span class="fa fa-th"></span></a>
                <a id="list-catg" href="#"><span class="fa fa-list"></span></a>
              </div> 
            </div>
            <div class="aa-product-catg-body">
            <ul class="aa-product-catg">
              
                <c:forEach items="${listDeXuat}" var="sp" varStatus="loop">
                
                <li class= "SPham ${loop.index >= 6 ? 'd-none' : ''}">               
                  <figure>
                    <a class="aa-product-img" href="product/${sp.maSP}.htm"><img style="width:250px; height:300px;" src="${sp.hinhAnh.link}" alt="product img"></a>
                 <!--    <a class="aa-add-card-btn"href="#"><span class="fa fa-shopping-cart"></span>Thêm vào giỏ</a> -->
                     <figcaption>
                      <h4 class="aa-product-title"><a href="product/${sp.maSP}.htm" style="font-weight: bold; color: #3D71B6;">${sp.tenSanPham}</a></h4> 
                          
            	      <span class="aa-product-price"><fmt:formatNumber value="${sp.donGia}"  pattern="#,##0" />đ</span><span class="aa-product-price"></span>
                     
                    </figcaption>
                  </figure>
               
                </li>
                
                </c:forEach>
           </ul>
           </div>                                                                                                    
              
          </div>
        </div>
  
    </div>
    <c:if test="${listDeXuat.size()>6}">
		 <button id="loadMoreButton" class="btn btn-light btn-sm " style="margin-left:50%;">Xem thêm</button>		
		</c:if>
    <br>
    
    <br>
    </div>
      
            
  </section>
  <!-- / product category -->


   
  <%@ include file = "../include/footer.jsp" %>
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