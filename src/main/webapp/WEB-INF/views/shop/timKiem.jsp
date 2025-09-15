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
<title>PTIT PHONE SHOP | Product</title>
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
<link rel="stylesheet" type="text/css"
	href="assets/css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="assets/css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css" href="assets/css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="assets/css/theme-color/default-theme1.css"
	rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link href="assets/css/sequence-theme.modern-slide-in.css"
	rel="stylesheet" media="all">

<!-- Main style sheet -->
<link href="assets/css/style.css" rel="stylesheet">

<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>
<style>
.aa-product-price {
	color: #ee4d2d;
	font-size: 1.5rem;
	font-weight: bold;
}

.aa-product-price-discount {
	text-decoration: line-through;
	color: #999;
	font-size: 1rem;
	margin-left: 10px;
}

.aa-product-discount-badge {
	background-color: #ff5252;
	color: white;
	font-size: 0.9rem;
	font-weight: bold;
	padding: 3px 6px;
	border-radius: 5px;
	margin-left: 10px;
	display: inline-block;
}

.aa-product-img {
	display: block;
	width: 100%;
	height: auto;
}

.aa-product-title a {
	font-weight: bold;
	color: #333;
	text-decoration: none;
}

.aa-product-title a:hover {
	color: #ee4d2d;
}

li {
	list-style: none;
}

ul.aa-product-catg {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	padding: 0;
}

ul.aa-product-catg li {
	flex: 1 0 23%; /* Hiển thị 4 sản phẩm mỗi hàng */
	max-width: 23%;
}

figure {
	text-align: center;
	margin: 0;
}

figure img {
	border-radius: 8px;
	transition: transform 0.3s ease-in-out;
}

figure img:hover {
	transform: scale(1.05);
}
</style>
</head>
<!-- !Important notice -->
<!-- Only for product page body tag have to added .productPage class -->
<body class="productPage">

	<%@ include file="../include/header.jsp"%>

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


	<div style="margin-left: 40%">
		<h2 id="message">${message }</h2>
	</div>
	<hr>
	<c:if test="${listSP.size()==0}">
		<div class="d-flex justify-content-center align-items-center">
			<img src="assets/img/not-found.png" width="205" height="205"
				alt="..." />
		</div>
	</c:if>
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
								<a id="grid-catg" href="#"><span class="fa fa-th"></span></a> <a
									id="list-catg" href="#"><span class="fa fa-list"></span></a>
							</div>
						</div>
						<div class="aa-product-catg-body">
							<ul class="aa-product-catg">

								<c:forEach items="${listSP}" var="sp" varStatus="loop">
									<li class="SPham ${loop.index >= 6 ? 'd-none' : ''}">
										<figure>
											<!-- Hình ảnh sản phẩm -->
											<a class="aa-product-img" href="product/${sp.maSP}.htm">
												<img style="width: 250px; height: 300px;"
												src="${sp.hinhAnh.link}" alt="product img">
											</a>
											<figcaption>
												<!-- Tên sản phẩm -->
												<h4 class="aa-product-title">
													<a href="product/${sp.maSP}.htm"
														style="font-weight: bold; color: #333;">
														${sp.tenSanPham} </a>
												</h4>

												<!-- Giá sản phẩm -->
												<c:choose>
													<c:when test="${sp.giamGia != null && sp.giamGia ne '0'}">
														<span class="aa-product-price"
															style="color: #ee4d2d; font-size: 1.5rem; font-weight: bold;">
															<fmt:formatNumber
																value="${sp.donGia * (1 - sp.giamGia / 100)}"
																pattern="#,##0" />đ
														</span>
														<span class="aa-product-price"
															style="text-decoration: line-through; color: #999; font-size: 1rem; margin-left: 10px;">
															<fmt:formatNumber value="${sp.donGia}" pattern="#,##0" />đ
														</span>
														<span
															style="background-color: #ff5252; color: white; font-size: 0.9rem; font-weight: bold; padding: 3px 6px; border-radius: 5px; margin-left: 10px;">
															-<fmt:formatNumber value="${sp.giamGia}" pattern="#" />%
														</span>
													</c:when>
													<c:otherwise>
														<span class="aa-product-price"
															style="color: #ee4d2d; font-size: 1.5rem; font-weight: bold;">
															<fmt:formatNumber value="${sp.donGia}" pattern="#,##0" />đ
														</span>
													</c:otherwise>
												</c:choose>
											</figcaption>
										</figure> <!-- Tính năng bổ sung -->
										<div class="aa-product-hvr-content">
											<a href="#" data-toggle2="tooltip" data-placement="top"
												title="Quick View" data-toggle="modal"
												data-target="#quick-view-modal"> <span
												class="fa fa-search"></span>
											</a>
										</div>
									</li>
								</c:forEach>
							</ul>


						</div>
						<!-- quick view modal -->
						<%--   <c:forEach items="${listSP}" var="sp">                 
              <div class="modal fade" id="quick-view-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">                      
                    <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <div class="row">
                        <!-- Modal view slider -->
                        
                        <div class="col-md-6 col-sm-6 col-xs-12">                              
                          <div class="aa-product-view-slider">                               
                            <div class="simpleLens-gallery-container" id="demo-1">
                              <div class="simpleLens-container">
                                  <div class="simpleLens-big-image-container">
                                      <a class="simpleLens-lens-image" data-lens-image="${sp.hinhAnh.link}">
                                          <img src="${sp.hinhAnh.link}" class="simpleLens-big-image">
                                      </a>
                                  </div>
                              </div>                       
                            </div>
                          </div>                          
                        </div>
                        
                        
                        <!-- Modal view content -->
                        <div class="col-md-6 col-sm-6 col-xs-12">
                        
                          <div class="aa-product-view-content">
                          
                            <h3>${sp.tenSanPham}</h3>
                            
                            <div class="aa-price-block">
                               <span class="aa-product-price"><fmt:formatNumber value="${sp.donGia}"  pattern="#,##0" />đ</span><span class="aa-product-price"></span>									
                            </div>                 
                            <h4>Size</h4>
                            <div class="aa-prod-view-size">
                              <a href="#">S</a>
                              <a href="#">M</a>
                              <a href="#">L</a>
                              <a href="#">XL</a>
                            </div>
                            <div class="aa-prod-quantity">                     
                              
                              <p class="aa-prod-category">Loại: <a href="#">${sp.maKieu.loai.tenLoai}</a></p>
                              <p class="aa-prod-category"> Kiểu: <a href="#">${sp.maKieu.tenKieu}</a></p>
                            </div>
                            <div class="aa-prod-view-bottom">
                              <!-- <a href="#" class="aa-add-to-cart-btn"><span class="fa fa-shopping-cart"></span>Thêm vào giỏ</a> -->
                              <a href="product/${sp.maSP}.htm" class="aa-add-to-cart-btn">Xem chi tiết</a>
                            </div>
                            
                          </div>
                         
                        </div>
                      </div>
                    </div>                        
                  </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
              </div>
              </c:forEach> --%>



					</div>
				</div>

			</div>
			<c:if test="${listSP.size()>6}">
				<button id="loadMoreButton" class="btn btn-light btn-sm "
					style="margin-left: 50%;">Xem thêm</button>
			</c:if>
			<br> <br>
		</div>


	</section>
	<!-- / product category -->



	<%@ include file="../include/footer.jsp"%>
	<!-- jQuery library -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="assets/js/bootstrap.js"></script>
	<!-- SmartMenus jQuery plugin -->
	<script type="text/javascript" src="assets/js/jquery.smartmenus.js"></script>
	<!-- SmartMenus jQuery Bootstrap Addon -->
	<script type="text/javascript"
		src="assets/js/jquery.smartmenus.bootstrap.js"></script>
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