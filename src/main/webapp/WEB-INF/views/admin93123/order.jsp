<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>

<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Quản lý đơn hàng</title>
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700">
<!-- https://fonts.google.com/specimen/Roboto -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/fontawesome.min.css"/>' />
<!-- https://fontawesome.com/ -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/bootstrap.min.css"/>' />
<!-- https://getbootstrap.com/ -->
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/templatemo-style.css"/>' />
<!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->
<style>
.fas.fa-eye:hover {
	transform: scale(1.2);
}
</style>
</head>

<body id="reportsPage">
	<div class="" id="home">
		<%@ include file="include/menu.jsp"%>
		<%-- <%@ include file="include/footer.jsp" %> --%>

		<div class="container">
			<!-- row -->
<div class="row tm-content-row">
    <div class="col-12 tm-block-col">
        <div class="tm-bg-primary-dark tm-block tm-block-scroll">
            <h4 class="text-info">
                <i class="fas fa-search"></i> Tìm kiếm đơn hàng
            </h4>
            
                        <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorSearch}">
                <div class="alert alert-danger" role="alert">
                    ${errorSearch}
                </div>
            </c:if>
            <f:form method="get" action="admin93123/order/search">
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <label for="hoTen">Tên người nhận</label>
                        <input type="text" class="form-control" id="hoTen" name="hoTen" value="${hoTen}" placeholder="Nhập tên người nhận">
                    </div>
                    <div class="form-group col-md-3">
                        <label for="trangThai">Trạng thái</label>
                        <select class="form-control" id="trangThai" name="trangThai">
                            <option value="">Tất cả</option>
                            <option value="1" ${trangThai == 1 ? 'selected' : ''}>Chờ xác nhận</option>
                            <option value="2" ${trangThai == 2 ? 'selected' : ''}>Đang giao</option>
                            <option value="3" ${trangThai == 3 ? 'selected' : ''}>Đã giao</option>
                            <option value="0" ${trangThai == 0 ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label for="ngayTaoMin">Ngày từ</label>
                        <input type="date" class="form-control" id="ngayTaoMin" name="ngayTaoMin" value="${ngayTaoMin}">
                    </div>
                    <div class="form-group col-md-3">
                        <label for="ngayTaoMax">Ngày đến</label>
                        <input type="date" class="form-control" id="ngayTaoMax" name="ngayTaoMax" value="${ngayTaoMax}">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </f:form>
        </div>
    </div>
</div>

			<!-- Bảng kết quả tìm kiếm -->
			<div class="row tm-content-row">
				<div class="col-12 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-scroll">
						<h4 class="text-info">
							<i class="fas fa-search"></i> Kết quả tìm kiếm
						</h4>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Mã đơn</th>
									<th scope="col">Người nhận</th>
									<th scope="col">Ngày đặt</th>
									<th scope="col">Tổng tiền</th>
									<th scope="col">Xem chi tiết</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listSearch}" var="dh">
									<tr>
										<th scope="row"><b>#${dh.maDh}</b></th>
										<td><b>${dh.hoTen}</b></td>
										<td>${dh.ngayTao}</td>
										<td><span style="color: #eff309e8;"> <fmt:formatNumber
													value="${dh.tongTien}" pattern="#,##0" />đ
										</span></td>
										<td><a href="chiTietDonHang/${dh.maDh}.htm"> <i
												class="fas fa-eye" title="Xem chi tiết đơn hàng"
												style="color: #0043ff;"></i>
										</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${empty listSearch}">
							<p class="text-warning">Không tìm thấy kết quả phù hợp.</p>
						</c:if>
					</div>
				</div>
			</div>
			<div class="row tm-content-row">

				<div class="col-12 tm-block-col">
					<div
						class="tm-bg-primary-dark tm-block tm-block-taller tm-block-scroll">
						<h4 class="text-info">
							<i class="fas fa-clock"></i> Đơn hàng chờ xác nhận
						</h4>
						<c:if test="${not empty successMessage}">
							<div class="alert alert-success">${successMessage}</div>
						</c:if>
						<c:if test="${not empty errorMessage}">
							<div class="alert alert-danger">${errorMessage}</div>
						</c:if>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Mã đơn</th>
									<!-- <th scope="col">Trạng thái</th> -->
									<th scope="col">Người nhận</th>
									<!-- <th scope="col">Địa chỉ</th> -->
									<th scope="col">Ngày đặt</th>
									<th scope="col">Tổng tiền</th>
									<th scope="col">Xem chi tiết</th>
									<th scope="col">Xác nhận duyệt</th>
									<th scope="col">Hủy đơn này</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listDonHang}" var="dh">
									<c:if test="${dh.trangThai==1}">
										<tr>

											<th scope="row"><b>#${dh.maDh}</b></th>

											<td><b>${dh.hoTen}</b></td>
											<%-- <td><b>${dh.diaChi}</b></td> --%>
											<td>${dh.ngayTao}</td>
											<td><span style="color: #eff309e8;"><fmt:formatNumber
														value="${dh.tongTien}" pattern="#,##0" />đ</span></td>
											<td><a href="chiTietDonHang/${dh.maDh}.htm"> <i
													class="fas fa-eye" title="Xem chi tiết đơn hàng"
													style="color: #0043ff; font-size: 25px; transition: transform 0.3s;"></i>
											</a></td>

											<td><f:form method="post">
													<input type="hidden" name="maDonHangDuyet"
														value="${dh.maDh}">
													<input type="hidden" name="trangThaiDonDuyet"
														value="${dh.trangThai}">
													<button class="btn-primary" title="Chuyển sang đang giao"
														type="submit" name="changeStatus2">Duyệt</button>
												</f:form></td>


											<td><f:form method="post">
													<input type="hidden" name="maDonHangHuy" value="${dh.maDh}">
													<input type="hidden" name="trangThaiDonHuy"
														value="${dh.trangThai}">
													<button class="btn-danger" title="Hủy đơn này"
														type="submit" name="changeStatus0">Hủy</button>
												</f:form></td>


										</tr>
									</c:if>
								</c:forEach>


							</tbody>
						</table>
					</div>
				</div>

				<div class="col-12 tm-block-col">
					<div
						class="tm-bg-primary-dark tm-block tm-block-taller tm-block-scroll">
						<h4 class="text-warning">
							<i class="fas fa-truck"></i> Đơn hàng đang được giao
						</h4>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Mã đơn</th>
									<!-- <th scope="col">Trạng thái</th> -->
									<th scope="col">Người nhận</th>
									<!-- <th scope="col">Địa chỉ</th> -->
									<th scope="col">Ngày đặt</th>
									<th scope="col">Tổng tiền</th>
									<th scope="col">Xem chi tiết</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listDonHang}" var="dh">
									<c:if test="${dh.trangThai == 2}">
										<tr>

											<th scope="row"><b>#${dh.maDh}</b></th>

											<td><b>${dh.hoTen}</b></td>
											<%-- <td><b>${dh.diaChi}</b></td> --%>
											<td>${dh.ngayTao}</td>
											<td><span style="color: #eff309e8;"><fmt:formatNumber
														value="${dh.tongTien}" pattern="#,##0" />đ</span></td>
											<td><a href="chiTietDonHang/${dh.maDh}.htm"> <i
													class="fas fa-eye" title="Xem chi tiết đơn hàng"
													style="color: yellow; font-size: 25px; transition: transform 0.3s;"></i>
											</a></td>
										</tr>
									</c:if>
								</c:forEach>


							</tbody>
						</table>
					</div>
				</div>

			</div>


			<div class="row tm-content-row">

				<div class="col-12 tm-block-col">
					<div
						class="tm-bg-primary-dark tm-block tm-block-taller tm-block-scroll">
						<h4 class="text-success">
							<i class="fas fa-check-circle"></i> Đơn hàng đã giao thành công
						</h4>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Mã đơn</th>
									<!-- <th scope="col">Trạng thái</th> -->
									<th scope="col">Người nhận</th>
									<!-- <th scope="col">Địa chỉ</th> -->
									<th scope="col">Ngày đặt</th>
									<th scope="col">Tổng tiền</th>
									<th scope="col">Xem chi tiết</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listDonHang}" var="dh">
									<c:if test="${dh.trangThai ==3}">
										<tr>

											<th scope="row"><b>#${dh.maDh}</b></th>
											<td><b>${dh.hoTen}</b></td>
											<%-- <td><b>${dh.diaChi}</b></td> --%>
											<td>${dh.ngayTao}</td>
											<td><span style="color: #eff309e8;"><fmt:formatNumber
														value="${dh.tongTien}" pattern="#,##0" />đ</span></td>
											<td><a href="chiTietDonHang/${dh.maDh}.htm"> <i
													class="fas fa-eye" title="Xem chi tiết đơn hàng"
													style="color: green; font-size: 25px; transition: transform 0.3s;"></i>
											</a></td>
										</tr>
									</c:if>
								</c:forEach>


							</tbody>
						</table>
					</div>
				</div>

				<div class="col-12 tm-block-col">
					<div
						class="tm-bg-primary-dark tm-block tm-block-taller tm-block-scroll">
						<h4 class="text-danger">
							<i class="fas fa-times-circle"></i> Đơn hàng đã bị hủy
						</h4>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Mã đơn</th>
									<!-- <th scope="col">Trạng thái</th> -->
									<th scope="col">Người nhận</th>
									<!-- <th scope="col">Địa chỉ</th> -->
									<th scope="col">Ngày đặt</th>
									<th scope="col">Tổng tiền</th>
									<th scope="col">Xem chi tiết</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listDonHang}" var="dh">
									<c:if test="${dh.trangThai == 0}">
										<tr>

											<th scope="row"><b>#${dh.maDh}</b></th>
											<td><b>${dh.hoTen}</b></td>
											<%-- <td><b>${dh.diaChi}</b></td> --%>
											<td>${dh.ngayTao}</td>
											<td><span style="color: #eff309e8;"><fmt:formatNumber
														value="${dh.tongTien}" pattern="#,##0" />đ</span></td>
											<td><a href="chiTietDonHang/${dh.maDh}.htm"> <i
													class="fas fa-eye" title="Xem chi tiết đơn hàng"
													style="color: red; font-size: 25px; transition: transform 0.3s;"></i>
											</a></td>
										</tr>
									</c:if>
								</c:forEach>


							</tbody>
						</table>
					</div>
				</div>

			</div>

		</div>

		<%@ include file="include/footer.jsp"%>
	</div>


	<!-- Đảm bảo rằng jQuery được tải trước các thư viện khác -->
	<script src="<c:url value='js/jquery-3.3.1.min.js'/>"></script>
	<script src="<c:url value='js/moment.min.js'/>"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<!-- Các thư viện khác -->
	<script src="<c:url value='js/bootstrap.min.js'/>"></script>
	<script src="<c:url value='js/tooplate-scripts.js'/>"></script>

	<script>
		Chart.defaults.color = 'white'; // Đặt màu mặc định cho các phần tử trong biểu đồ
		let ctxLine, ctxBar, ctxPie, optionsLine, optionsBar, optionsPie, configLine, configBar, configPie;
		let lineChart, barChart, pieChart; // Khai báo các biến biểu đồ đúng cách

		// DOM is ready
		$(function() {
			drawLineChart(); // Vẽ Line Chart
			drawBarChart(); // Vẽ Bar Chart
			drawPieChart(); // Vẽ Pie Chart

			$(window).resize(function() {
				updateLineChart();
				updateBarChart();
			});
		})
	</script>

</body>
</html>

