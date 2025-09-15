<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-xl">
	<div class="container h-100">
		<!-- <a class="navbar-brand" href="admin93123/index.htm">
                    <h1 class="tm-site-title mb-0">TGDM</h1>
                    <div class="navbar-nav"><h1 class="tm-site-title mb-0 nav-link">TGDM</h1></div>
                </a>
                <button class="navbar-toggler ml-auto mr-0" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fas fa-bars tm-nav-icon"></i>
                </button> -->

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mx-auto h-100">
				<li class="nav-item"><a class="nav-link" href="#"> <i
						class="fa fa-home"></i> <!-- Trang chủ --> <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="admin93123/index.htm"> <i class="fa fa-chart-bar"></i>
						Thống kê <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="admin93123/order.htm"> <i class="fas fa-tachometer-alt"></i>
						Đơn hàng <span class="sr-only">(current)</span>
				</a></li>

				<li class="nav-item"><a class="nav-link"
					href="admin93123/product.htm"> <i class="fas fa-shopping-cart"></i>
						Sản phẩm
				</a></li>

				<!-- <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="fas fa-file-alt"></i>
                                Khuyến mãi
                            </a>
                        </li> -->


				<li class="nav-item "><a class="nav-link"
					href="admin93123/customerAccount.htm"> <i class="fas fa-users"></i>
						Tài khoản khách
				</a></li>

				<c:if test="${USER.getQuyen()==2}">
					<li class="nav-item"><a class="nav-link"
						href="admin93123/adminAccount.htm"> <i
							class="fas fa-user-secret"></i> Tài khoản Admin
					</a></li>
				</c:if>
			</ul>

			<ul class="navbar-nav h-100">

				<li class="nav-item"><a class="nav-link"
					href="admin93123/me.htm"> <i class="fas fa-user"></i> <b>Thông
							tin cá nhân</b>
				</a></li>

				<li class="nav-item"><a class="nav-link"
					href="admin93123/changePass.htm"> <i class="fas fa-lock"></i> <b>Đổi
							mật khẩu</b>
				</a> <br></li>
				<li class="nav-item"><a class="nav-link"
					href="admin93123/logView.htm"> <i class="fas fa-user"></i> <b>Quản
							lý Log người dùng</b>
				</a></li>

				<li class="nav-item"><a class="nav-link" href="user/logout.htm">
						<i class="fas fa-sign-out-alt"></i> <b>Đăng xuất</b>
				</a></li>
			</ul>
		</div>
	</div>
</nav>

<script>
	var path = window.location.pathname;
	var page = path.split("/").pop();
	var links = document.querySelectorAll(".nav-link");

	for (var i = 0; i < links.length; i++) {
		if (links[i].getAttribute("href").indexOf(page) !== -1) {
			links[i].classList.add("active");
		}
	}
</script>
