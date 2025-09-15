<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>

<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Quản lý Log</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700">
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin/css/fontawesome.min.css"/>' />
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin/css/bootstrap.min.css"/>' />
<link rel="stylesheet"
	href='<c:url value="/assets/css/admin/css/templatemo-style.css"/>' />
</head>
<body id="reportsPage">
	<div id="home">
		<%@ include file="include/menu.jsp"%>

		<!-- Main Content -->
		<div class="container mt-5">
			<h2 class="text-center mb-4">Quản lý Log người dùng</h2>

			<!-- Bộ lọc -->
			<form class="form-inline mb-4"
				action="<c:url value='/admin/log-management'/>" method="GET">
				<div class="form-group mr-2">
					<label for="username" class="mr-2">Người dùng:</label> <input
						type="text" id="username" name="username" class="form-control"
						value="${param.username}" placeholder="Tên người dùng">
				</div>
				<div class="form-group mr-2">
					<label for="activity" class="mr-2">Hành động:</label> <input
						type="text" id="activity" name="activity" class="form-control"
						value="${param.activity}" placeholder="Loại hành động">
				</div>
				<div class="form-group mr-2">
					<label for="date" class="mr-2">Ngày:</label> <input type="date"
						id="date" name="date" class="form-control" value="${param.date}">
				</div>
				<button type="submit" class="btn btn-primary">Lọc</button>
			</form>

			<!-- Bảng hiển thị log -->
			<table class="table table-bordered table-striped">
				<thead class="thead-dark">
					<tr>
						<th>#</th>
						<th>Người dùng</th>
						<th>Hành động</th>
						<th>Chi tiết</th>
						<th>IP</th>
						<th>Thời gian</th>
						<th>Mức độ</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="log" items="${logs}" varStatus="status">
						<tr>
							<td>${status.index + 1}</td>
							<td>${log.userName}</td>
							<td>${log.actionType}</td>
							<td>${log.actionDetails}</td>
							<td>${log.ipAddress}</td>
							<td><fmt:formatDate value="${log.actionTime}"
									pattern="dd/MM/yyyy HH:mm:ss" /></td>
							<td>${log.severityLevel}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- Phân trang -->
			<nav aria-label="Page navigation" class="mt-4">
				<ul class="pagination justify-content-center">
					<c:if test="${currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="<c:url value='/admin/log-management?page=${currentPage - 1}'/>"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach begin="1" end="${totalPages}" var="page">
						<li class="page-item ${page == currentPage ? 'active' : ''}">
							<a class="page-link"
							href="<c:url value='/admin/log-management?page=${page}' />">${page}</a>
						</li>
					</c:forEach>
					<c:if test="${currentPage < totalPages}">
						<li class="page-item"><a class="page-link"
							href="<c:url value='/admin/log-management?page=${currentPage + 1}'/>"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</nav>
			<div class="text-center mb-3">
				<a href="<c:url value='/admin/export-logs' />"
					class="btn btn-success"> Xuất file Excel </a>
			</div>

		</div>


		<%@ include file="include/footer.jsp"%>
	</div>
</body>
</html>
