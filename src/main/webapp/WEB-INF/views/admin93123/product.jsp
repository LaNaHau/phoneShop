<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>

<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Quản lý sản phẩm</title>
<link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700" />
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
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin93123/css/product.css"/>' />
</head>

<body id="reportsPage">
	<div class="" id="home">
		<%@ include file="include/menu.jsp"%>


		<div class="container mt-5">
			<a href="admin93123/product/addByFile.htm"
				class="btn btn-primary btn-block text-uppercase mb-3">Thêm sản
				phẩm bằng file</a>
			<%-- <span>${TrainMessage}</span> --%>
			
			<div class="tm-bg-primary-dark tm-block tm-block-scroll">
				<h4 class="text-info">
					<i class="fas fa-search"></i> Tìm kiếm sản phẩm
				</h4>
				                        <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorSearch}">
                <div class="alert alert-danger" role="alert">
                    ${errorSearch}
                </div>
            </c:if>
				<f:form method="get" action="admin93123/product/search">
					<div class="form-row">
						<div class="form-group col-md-12">
							<label for="tenSanPham">Tên sản phẩm</label> <input type="text"
								class="form-control" id="tenSanPham" name="tenSanPham"
								value="${tenSanPham}" placeholder="Nhập tên sản phẩm">
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
							<th>Ảnh</th>
							<th>Tên sản phẩm</th>
							<th>Màu sắc</th>
							<th>Dung lượng</th>
							<th>Giá bán</th>
							<th>Trạng thái</th>
							<th>Sửa</th>
							<th>Xóa</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listSearch}" var="sanPham">
							<tr>
									<!-- Randomly selected image -->
									<td><a href="admin93123/product/edit/${sanPham.maSP}.htm">
											<img class="card-img-top" src="${sanPham.randomImage}"
											alt="Ảnh đại diện sản phẩm"
											style="height: 40px; width: 50px;" />
									</a></td>
									<td class="tm-product-name">${sanPham.tenSanPham}</td>
									<td><c:forEach items="${sanPham.mauSacs}" var="mau">
											<span>${mau}</span>
											<br />
										</c:forEach></td>
									<td><c:forEach items="${sanPham.dungLuongs}"
											var="dungLuong">
											<span>${dungLuong}</span>
											<br />
										</c:forEach></td>
									<td><c:forEach items="${sanPham.giaBan}" var="gia">
											<span><fmt:formatNumber value="${gia}" pattern="#,##0" />đ</span>
											<br />
										</c:forEach></td>
									<td>${sanPham.trangThai ? "Đang bán" : "Ngừng bán"}</td>
									<td><a href="admin93123/product/edit/${sanPham.maSP}.htm">
											<i class="fas fa-pencil-alt tm-product-edit-icon"></i>
									</a></td>
									<td>
										<form method="post">
											<input type="hidden" name="maSPXoa" value="${sanPham.maSP}" />
											<button name="deleteSP" class="btn-danger" type="submit"
												onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
												<i class="far fa-trash-alt tm-product-delete-icon"></i>
											</button>
										</form>
									</td>
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

				<div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-products">

						<h2 class="tm-block-title">Các sản phẩm đang kinh doanh</h2>
						<div class="tm-product-table-container">
							<table>
								<thead>
									<tr>
										<th>Ảnh</th>
										<th>Tên sản phẩm</th>
										<th>Màu sắc</th>
										<th>Dung lượng</th>
										<th>Giá bán</th>
										<th>Trạng thái</th>
										<th>Sửa</th>
										<th>Xóa</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${groupedSanPhams}" var="sanPham">
										<tr>
											<!-- Randomly selected image -->
											<td><a href="admin93123/product/edit/${sanPham.maSP}.htm">
													<img class="card-img-top" src="${sanPham.randomImage}"
													alt="Ảnh đại diện sản phẩm"
													style="height: 40px; width: 50px;" />
											</a></td>
											<td class="tm-product-name">${sanPham.tenSanPham}</td>
											<td><c:forEach items="${sanPham.mauSacs}" var="mau">
													<span>${mau}</span>
													<br />
												</c:forEach></td>
											<td><c:forEach items="${sanPham.dungLuongs}"
													var="dungLuong">
													<span>${dungLuong}</span>
													<br />
												</c:forEach></td>
											<td><c:forEach items="${sanPham.giaBan}" var="gia">
													<span><fmt:formatNumber value="${gia}"
															pattern="#,##0" />đ</span>
													<br />
												</c:forEach></td>
																<td><f:form method="post">
													<input type="hidden" name="maSPSuaTT"
														value="${sanPham.maSP}">
													<input type="hidden" name="trangThaiSp"
														value="${sanPham.trangThai}">
													<button class="btn-primary" title="Chuyển sang ngừng bán"
														type="submit" name="changeStatus">Đang bán</button>
												</f:form></td>
											<td><a href="admin93123/product/edit/${sanPham.maSP}.htm">
													<i class="fas fa-pencil-alt tm-product-edit-icon"></i>
											</a></td>
											<td>
												<form method="post">
													<input type="hidden" name="maSPXoa" value="${sanPham.maSP}" />
													<button name="deleteSP" class="btn-danger" type="submit"
														onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
														<i class="far fa-trash-alt tm-product-delete-icon"></i>
													</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- table container -->
						<a href="admin93123/product/add.htm"
							class="btn btn-primary btn-block text-uppercase mb-3">Thêm
							sản phẩm</a>
					</div>

					<c:if test="${not empty errorMessageXoaSP}">
						<script type="text/javascript">
							alert("${errorMessageXoaSP}");
							window.location.href = "${pageContext.request.contextPath}/admin93123/product.htm";
						</script>
					</c:if>

				</div>

				<div class="col-sm-12 col-md-12 col-lg-4 col-xl-4 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-products">
						<h2 class="tm-block-title">Các kiểu sản phẩm</h2>
						<div class="tm-product-table-container">
							<table class="table tm-table-small tm-product-table">
								<thead>
									<tr>
										<th scope="col">Mã</th>
										<th scope="col">Tên Kiểu</th>
										<!-- <th scope="col">Trạng thái</th> -->
										<th scope="col">Sửa</th>
										<th scope="col">Xóa</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${listkieu}" var="kieu">
										<tr>
											<td class="tm-product-name">${kieu.maKieu}</td>
											<td class="tm-product-name">${kieu.tenKieu}</td>

											<td><a href="admin93123/brands/editKieu/${kieu.maKieu}.htm"
												class="tm-product-delete-link"> <i
													class="fas fa-pencil-alt tm-product-edit-icon"
													title="Sửa kiểu này"></i>
											</a></td>

											<td>
												<!-- <a class="tm-product-delete-link">
                        <i class="far fa-trash-alt tm-product-delete-icon"></i>
                      </a> -->
												<form method="post">
													<input type="hidden" name="maKieuXoa"
														value="${kieu.maKieu}" />
													<button name="deleteKieu" class="btn-danger"
														title="Xóa kiểu này" type="submit"
														onclick="return confirm('Bạn có chắc chắn muốn xóa kiểu này?')">
														<i class="far fa-trash-alt tm-product-delete-icon"></i>
													</button>
												</form>
											</td>

										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<!-- table container -->
						<!-- <button class="btn btn-primary btn-block text-uppercase mb-3">
              Thêm kiểu khác
            </button> -->
						<a href="admin93123/brands/addKieu.htm"
							class="btn btn-primary btn-block text-uppercase mb-3">Thêm
							kiểu</a>
					</div>

					<c:if test="${not empty errorMessageKieu}">
						<script type="text/javascript">
							alert("${errorMessageKieu}");
							window.location.href = "${pageContext.request.contextPath}/admin93123/product.htm";
						</script>
					</c:if>
				</div>

			</div>
		</div>



		<div class="container mt-5">
			<div class="row tm-content-row">
				<div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col">
					<!-- <div class="tm-bg-primary-dark tm-block tm-block-products"> -->
					<div class="tm-bg-primary-dark tm-block tm-block-products">
						<h2 class="tm-block-title">Các sản phẩm đã tạm ngừng kinh
							doanh</h2>
						<div class="tm-product-table-container">
							<table class="table table-hover tm-table-small tm-product-table">
								<thead>
									<tr>
										<th scope="col">Ảnh</th>
										<th scope="col">Tên sản phẩm</th>
										<th scope="col">Giá</th>
										<th scope="col">Còn</th>
										<!-- <th scope="col">&nbsp;</th> -->
										<th scope="col">Trạng thái</th>
										<th scope="col">Sửa</th>
										<th scope="col">Xóa</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${listNgungBan}" var="sanPham">
										<tr>

											<!-- <th scope="row"><input type="checkbox" /></th> -->
											<td><a href="admin93123/product/edit/${sanPham.maSP}.htm">
													<img class="card-img-top" src="${sanPham.hinhAnh.link}"
													alt="Ảnh đại diện sản phẩm" id="product-image"
													style="height: 40px; width: 50px;" />
											</a></td>
											<td class="tm-product-name">${sanPham.tenSanPham}</td>
											<td><span style="color: #eff309e8;"><fmt:formatNumber
														value="${sanPham.donGia}" pattern="#,##0" />đ</span></td>

											<td>${sanPham.soLuong}</td>

											<td><f:form method="post">
													<input type="hidden" name="maSPSuaTT"
														value="${sanPham.maSP}">
													<input type="hidden" name="trangThaiSp"
														value="${sanPham.trangThai}">
													<button class="btn-primary" title="Chuyển sang đang bán"
														type="submit" name="changeStatus">Ngừng bán</button>
												</f:form></td>

											<td><a href="admin93123/product/edit/${sanPham.maSP}.htm"
												class="tm-product-delete-link"> <i
													class="fas fa-pencil-alt tm-product-edit-icon"
													title="Sửa sản phẩm này"></i>
											</a></td>

											<td>
												<form method="post">
													<input type="hidden" name="maSPXoa" value="${sanPham.maSP}" />
													<button name="deleteSP" class="btn-danger"
														title="Xóa sản phẩm này" type="submit"
														onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
														<i class="far fa-trash-alt tm-product-delete-icon"></i>
													</button>
												</form>
											</td>

										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<!-- table container -->

					</div>
				</div>

				<div class="col-sm-12 col-md-12 col-lg-4 col-xl-4 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-products">
						<h2 class="tm-block-title">Các loại sản phẩm</h2>
						<div class="tm-product-table-container">
							<table class="table tm-table-small tm-product-table">
								<thead>
									<tr>
										<th scope="col">Tên Loại</th>
										<!-- <th scope="col">Trạng thái</th> -->
										<th scope="col">Sửa</th>
										<th scope="col">Xóa</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${listLoai}" var="loai">
										<tr>
											<td class="tm-product-name">${loai.tenLoai}</td>

											<td><a href="admin93123/brands/editLoai/${loai.maLoai}.htm"
												class="tm-product-delete-link"> <i
													class="fas fa-pencil-alt tm-product-edit-icon"
													title="Sửa loại này"></i>
											</a></td>

											<td>
												<!-- <a class="tm-product-delete-link">
                        <i class="far fa-trash-alt tm-product-delete-icon"></i>
                      </a> -->
												<form method="post">
													<input type="hidden" name="maLoaiXoa"
														value="${loai.maLoai}" />
													<button name="deleteLoai" class="btn-danger"
														title="Xóa loại này" type="submit"
														onclick="return confirm('Bạn có chắc chắn muốn xóa loại này?')">
														<i class="far fa-trash-alt tm-product-delete-icon"></i>
													</button>
												</form>
											</td>

										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<a href="admin93123/brands/addLoai.htm"
							class="btn btn-primary btn-block text-uppercase mb-3">Thêm
							loại</a>
					</div>

					<c:if test="${not empty errorMessageLoai}">
						<script type="text/javascript">
							alert("${errorMessageLoai}");
							window.location.href = "${pageContext.request.contextPath}/admin93123/product.htm";
						</script>
					</c:if>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-products">
						<h2 class="tm-block-title">Các voucher sản phẩm</h2>
						<div class="tm-product-table-container">
							<table class="table tm-table-small tm-product-table">
								<thead>
									<tr>
										<th scope="col">Mã Voucher</th>
										<th scope="col">Loại Voucher</th>
										<th scope="col">Nội dung</th>
										<th scope="col">Số lượng</th>
										<th scope="col">Trạng thái</th>
										<!-- <th scope="col">Trạng thái</th> -->
										<th scope="col">Sửa</th>
										<th scope="col">Xóa</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${listVoucher}" var="voucher">
										<tr>
											<td class="tm-product-name">${voucher.maVoucher}</td>
											<c:if test="${voucher.loai == 0}">
												<td class="tm-product-name">Giảm thẳng</td>
											</c:if>
											<c:if test="${voucher.loai == 1}">
												<td class="tm-product-name">Giảm phần trăm</td>
											</c:if>
											<c:if test="${voucher.loai == 0}">
												<td class="tm-product-name"><fmt:formatNumber
														value="${voucher.noiDung}" pattern="#,##0" /> VND</td>
											</c:if>

											<c:if test="${voucher.loai == 1}">
												<td class="tm-product-name">${voucher.noiDung}%</td>
											</c:if>
											<td class="tm-product-name">${voucher.soLuong}</td>
											<c:if test="${voucher.trangThai == 0}">
												<td class="tm-product-name">Còn hiệu lực</td>
											</c:if>
											<c:if test="${voucher.trangThai == 1}">
												<td class="tm-product-name">Hết hạn</td>
											</c:if>
											<td><a
												href="admin93123/voucher/edit/${voucher.maVoucher}.htm"
												class="tm-product-delete-link"> <i
													class="fas fa-pencil-alt tm-product-edit-icon"
													title="Sửa voucher này"></i>
											</a></td>

											<td>
												<!-- <a class="tm-product-delete-link">
                        <i class="far fa-trash-alt tm-product-delete-icon"></i>
                      </a> -->
												<form method="post">
													<input type="hidden" name="maVoucherXoa"
														value="${voucher.maVoucher}" />
													<button name="deleteVoucher" class="btn-danger"
														title="Xóa voucher này" type="submit"
														onclick="return confirm('Bạn có chắc chắn muốn xóa voucher này?')">
														<i class="far fa-trash-alt tm-product-delete-icon"></i>
													</button>
												</form>
											</td>

										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<a href="admin93123/voucher/add.htm"
							class="btn btn-primary btn-block text-uppercase mb-3">Thêm
							Voucher</a>
					</div>

					<c:if test="${not empty errorMessageVoucher}">
						<script type="text/javascript">
							alert("${errorMessageVoucher}");
							window.location.href = "${pageContext.request.contextPath}/admin93123/product.htm";
						</script>
					</c:if>
				</div>



			</div>
		</div>
		<%@ include file="include/footer.jsp"%>
	</div>


	<script src="<c:url value='js/jquery-3.3.1.min.js'/>"></script>
	<!-- https://jquery.com/download/ -->
	<script src="<c:url value='js/bootstrap.min.js'/>"></script>
	<!-- https://getbootstrap.com/ -->

	<!-- <script>
      $(function() {
        $(".tm-product-name").on("click", function() {
          window.location.href = "admin93123/product/edit.htm";
        });
      });
    </script> -->
	<script>
		$(document).ready(function() {
			$('.btn-primary').click(function() {
				var button = $(this);
				var message = button.data('message');
				if (message) {
					if (confirm(message)) {
						button.closest('form').submit();
					}
					return false;
				}
			});
		});
	</script>

</body>
</html>

