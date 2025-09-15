<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<base href="${pageContext.servletContext.contextPath}/">
<%@ page import="ptithcm.entity.NguoiDungEntity" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    // Lấy giá trị từ session
    String userAvatar = "";
    try{
         userAvatar = "assets/uploads/" + ((NguoiDungEntity) session.getAttribute("USER")).getAvatar();

    }
	catch(Exception ex){
		userAvatar = "assets/uploads/";
	}
%>

<header id="aa-header">

<section id="menuu">
	<div class="container">
		<div class="menu-area">
			
			<div class="navbar navbar-default" role="navigation">
				<div class="navbar-collapse collapse">
					<!-- Left nav -->
					<ul class="nav navbar-nav">
						<li><a href="#"> <span class="fa fa-map-marker"></span> 97 Man Thiện, P.Hiệp phú, TP.Thủ Đức</a></li>
						<li><a href="#"><span class="fa fa-clock-o"></span>8:00 - 22:00</a></li>
						<li><a href="#"><span class="fa fa-phone"></span>090-xxxx-xxx</a></li>

					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>
</section> 

<style>
#menuu {
  display: inline;
  float: left;
  width: 100%;
  background-color: rgb(0,0,0);
   height: 32px; /* Chiều cao tùy chỉnh */
   margin-top: -5px; 
}
#menuu .menu-area {
  float: left;
  display: inline;
  width: 100%;
}
#menuu .menu-area .navbar-default {
  background-color: transparent;
  border: medium none;
  border-radius: 0;
  margin-bottom: 0;
  min-height: auto;
}
#menuu .menu-area .navbar-default .navbar-nav {
  display: inline-block;
  float: left;
  margin: 0;
  text-align: center;
  width: 100%;
}
#menuu .menu-area .navbar-default .navbar-nav li a {
  color: #fff;
  font-size: 16px;
  padding: 10px 15px;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
  -ms-transition: all 0.5s;
  -o-transition: all 0.5s;
  transition: all 0.5s;
}
#menuu .menu-area .navbar-default .navbar-nav .open a {
  background-color: #fff;
}
#menu .menu-area .navbar-default .navbar-nav .dropdown-menu li a {
  padding: 8px 15px;
}
#menu .menu-area .navbar-default .navbar-nav .dropdown-menu li a:hover, #menu .menu-area .navbar-default .navbar-nav .dropdown-menu li a:focus {
  color: #fff; 
}
#menu .menu-area .navbar-default .navbar-nav .dropdown-menu .dropdown-header {
  color: #555;
  display: block;
  font-size: 16px;
  padding: 3px 20px;
  text-transform: uppercase;
}
</style>
	
	<c:if test="${empty sessionScope.USER}">
	
	<div class="aa-header-bottom">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="aa-header-bottom-area">
                    <!-- logo  -->
                    <div class="aa-logo">
                        <!-- Text based logo -->
                        <a href=".htm">
                            <span class="fa fa-shopping-cart"></span>
                            <p>
                                PTIT PHONE<strong> SHOP</strong> <span>Your Shopping Partner</span>
                            </p>
                        </a>
                    </div>
                    <!-- Search and login container -->
                    <div class="aa-search-login-container">
                        <!-- Image Search Button -->
<%--                         <a href="${pageContext.servletContext.contextPath}/imageSearch.htm" class="search-button">
                            <button style="width: 50px; height: 40px;" name="btnImageSearch">
                                <span class="fa fa-picture-o"></span>
                            </button>
                        </a> --%>
                        <!-- Search Box -->
                        <div class="aa-search-boxx">
                            <form action="shop.htm" method="post">
                                <input type="text" name="key" id="search-barr" placeholder="Bạn tìm gì">
                                <button type="submit" name="btnSearch">
                                    <span class="fa fa-search"></span>
                                </button>
                            </form>
                        </div>
                        <!-- Login Box -->
                        <div class="aa-cartbox">
                            <a class="aa-cart-link" href="user/login.htm">
                                <span class="fa fa-user"></span>
                                <span class="aa-cart-title">ĐĂNG NHẬP</span>
                            </a>
                        </div>
                    </div> <!-- End of Search and login container -->
                </div>
            </div>
        </div>
    </div>
</div>


								
							</c:if>

<style>
.aa-header-bottom-area {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.aa-search-login-container {
    display: flex;
    align-items: center;
    margin-left: 20px; /* Đảm bảo nó căn sang phải */
    flex-grow: 1; /* Để phần tử con có thể phát triển */
}

.aa-search-boxx {
    margin-left: 10px;
    flex-grow: 1; /* Cho phép hộp tìm kiếm phát triển và chiếm không gian có sẵn */
}

.aa-search-boxx input[type="text"] {
   width: 500px;
    padding: 7px;
    border: 1px solid #ddd;
    border-radius: 3px 0 0 3px;
    margin-right: -5px;
}

.aa-search-boxx button {
    background-color: #333;
    color: #fff;
    border: none;
    padding: 7px 10px;
    border-radius: 0 3px 3px 0;
    cursor: pointer;
}

.aa-cartbox {
    margin-left: 10px; /* Đảm bảo nó không quá sát */
    display: flex;
    align-items: center;
}

.search-button {
    margin-left: 100px;
    
    
}

.aa-logo a {
    display: flex;
    align-items: center;
    text-decoration: none;
}

.aa-logo p {
    margin: 0;
    padding-left: 5px;
}

.aa-cartbox a {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #333;
}

.aa-cartbox .fa-user {
    margin-right: 5px;
}

@media (max-width: 768px) {
    .aa-header-bottom-area {
        flex-direction: column;
    }
    .aa-search-login-container {
        width: 100%;
        justify-content: space-between;
        margin-left: 0;
        margin-top: 10px;
    }
    .aa-search-boxx,
    .aa-cartbox,
    .search-button {
        width: 100%;
        margin: 5px 0;
    }
}


</style>

 <style>
 
		.nav > li {
            position: relative;
        }

        .nav > li:not(:last-child)::after {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            height: 100%;
            width: 1px;
            background-color: rgba(255, 255, 255, 0.3); /* Màu trắng lợt */

        }

        .nav > li > a {
            padding: 15px 20px;
        }

        .nav > li > a:hover {
            background-color: #f8f8f8;
        } 
 
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .header-links {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f8f8f8;
            padding: 35px 20px;
            border-bottom: 1px solid #ddd;
            width: 100%;
            box-sizing: border-box;
        }

        .header-links a {
            text-decoration: none;
            color: #333;
            margin: 0 10px;
        }

        .header-links a:hover {
            color: #333;
        }

        .header-links .aa-cart-link {
            display: flex;
            align-items: center;
        }

        .header-links .aa-cart-link .fa-shopping-basket {
            margin-right: 5px;
        }

        .header-links .aa-search-box {
            display: flex;
            align-items: center;
        }

        .header-links .aa-search-box input {
       		width: 500px; /* Đặt chiều rộng theo ý muốn */
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px 0 0 3px;
            margin-right: -5px; /* Để các nút tìm kiếm sát nhau */
        }

        .header-links .aa-search-box button {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 0 3px 3px 0;
            cursor: pointer;
        }

        .header-links .aa-search-box button .fa {
            margin-right: 0;
        }

       

        .header-links a[href=".htm"] {
            font-size: 36px;
            font-weight: bold;
            color: #333;
            font-family: 'Playfair Display', serif;
        }
        .header-links a[href="yeuThich.htm"], a[href="lich-su-mua-hang.htm"], a[href="userInfo.htm"], a[href="user/logout.htm"]  {
            font-size: 18px;
            color: #333;
        }
        .header-links a[href="gioHang.htm"] .fa-shopping-basket {
		    color: #ff6600; /* Màu cam cho icon */
		    font-size: 20px;
		}
		
		.header-links a[href="gioHang.htm"] .aa-cart-title {
		    color: #000; /* Màu đen cho chữ */
		    font-size: 18px;
		}
		
		@media (max-width: 1170px) {
    .header-links {
        flex-direction: column;
        align-items: flex-start;
    }
		
    </style>
</head>
<body>

	<c:if test="${not empty sessionScope.USER}">
	<div class="header-links">
    	<a href=".htm"> 
									PTIT PHONE <strong>Shop</strong> <!-- <span>Your Shopping Partner</span> -->
							
							</a> 
    	
<%--         <a href="${pageContext.servletContext.contextPath}/imageSearch.htm" class="search-button">
            <button style="width: 50px; height: 40px;" name="btnImageSearch">
                <span class="fa fa-picture-o"></span>
            </button>
        </a> --%>

        <div class="aa-search-box">
            <form action="shop.htm" method="post">
                <input type="text" name="key" id="search-barr" placeholder="Bạn tìm gì">
                <button type="submit" name="btnSearch">
                    <span class="fa fa-search"></span>
                </button>
            </form>
        </div>

       
        <a href="yeuThich.htm">YÊU THÍCH</a>
        <a href="lich-su-mua-hang.htm">LỊCH SỬ MUA</a>
        <a href="userInfo.htm">TÀI KHOẢN</a>
         <a class="aa-cart-link" href="gioHang.htm">
            <span class="fa fa-shopping-basket"></span>
            <span class="aa-cart-title">GIỎ HÀNG</span>
        </a>
       <%-- <a href="userInfo.htm">${sessionScope.USER.getUserName()}<img src="<%= userAvatar %>" class = "round-image" alt="Ảnh đã lưu"/> --%>
        <a href="user/logout.htm">ĐĂNG XUẤT</a>
    </c:if>
</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- / header bottom  -->
</header>
<!-- / header section -->

<section id="menu">
	<div class="container">
		<div class="menu-area">
			<!-- Navbar -->
			<div class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
				</div>
				<div class="navbar-collapse collapse">
					<!-- Left nav -->
					<ul class="nav navbar-nav">
						<li><a href=".htm">TRANG CHỦ</a></li>
						<li><a href="shop.htm">SẢN PHẨM</a></li>
						<li><a href=".htm">GIỚI THIỆU</a></li>		
						<li><a href=".htm">HÀNG GIẢM GIÁ</a></li>
						<li><a href=".htm">BỘ SƯU TẬP</a></li>
						<li><a href=".htm">TIN TỨC</a></li>
						<li><a href=".htm">CHÍNH SÁCH</a></li>
						<li><a href=".htm">LIÊN HỆ</a></li>
						<li><a href=".htm">HỆ THỐNG</a></li>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>
</section>
