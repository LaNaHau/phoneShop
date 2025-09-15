<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
	<base href="${pageContext.servletContext.contextPath}/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thống kê</title>
    <link rel="icon" href="assets/img/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
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
	
	<style>
		.chart-container {
		    background-color: #f1f1f1; /* Màu nền sáng hơn */
		}
	</style>
	
</head>

<body id="reportsPage">
    <div class="" id="home">
        <%@ include file="include/menu.jsp" %> 
        
        <div class="container">
        	<%-- <div class="row">
                <div class="col">
                    <p class="text-white mt-3 mb-5">Chào mừng quay lại, <b>${USER.hoTen}</b></p>
                </div>
            </div> --%>
        <h2 class="tm-block-title mt-3">Thống kê doanh thu</h2>
        <h5 class="text-warning">Tổng doanh thu đã bán : <fmt:formatNumber value="${tongDoanhThu}" pattern="#,##0" />đ</h5>
        
        <br>
        <h2 class="tm-block-title">Thống kê số người dùng</h2>
        <h5 class="text-warning">Số người dùng trên web : <fmt:formatNumber value="${tongSoNguoiDung}" pattern="#,##0" /></h5>
        
                    
            <div class="row tm-content-row">
                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 tm-block-col">
                    <div class="tm-bg-primary-dark tm-block">
                        <h2 class="tm-block-title">Thống kê doanh thu các tháng năm nay</h2>
                        <canvas id="doanhThuChart" class="chart-container""></canvas>
                    </div>
                </div>
                
                <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
                    <div class="tm-bg-primary-dark tm-block">
                        <h2 class="tm-block-title">Thống kê số đơn hàng</h2>
                        <canvas id="donHangChart" class="chart-container""></canvas>
                    </div>
                </div>          
                
                <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
                    <div class="tm-bg-primary-dark tm-block">
                        <h2 class="tm-block-title">Tỉ lệ đơn thành công và bị hủy</h2>
                        <canvas id="orderStatusChart" width="400" height="400"></canvas>

                    </div>
                </div>       
       
                
            </div>
        </div>
        
		<%@ include file="include/footer.jsp" %>
    </div>

    <script src="<c:url value='js/jquery-3.3.1.min.js'/>"></script>
    <!-- https://jquery.com/download/ -->
    <script src="<c:url value='js/moment.min.js'/>"></script>
    <!-- https://momentjs.com/ -->
    <%-- <script src="<c:url value='js/Chart.min.js'/>"></script> --%>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    
    <!-- http://www.chartjs.org/docs/latest/ -->
    <script src="<c:url value='js/bootstrap.min.js'/>"></script>
    <!-- https://getbootstrap.com/ -->
    <script src="<c:url value='js/tooplate-scripts.js'/>"></script>

    
    <script>
    
    // Lấy giá trị tổng doanh thu theo tháng từ controller
    var monthlyRevenues = ${monthlyRevenues};

    // Định nghĩa hàm vẽ biểu đồ doanh thu
    function drawdoanhThuChart() {
        var ctx = document.getElementById('doanhThuChart').getContext('2d');

        var config = {
            type: 'line',
            data: {
                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                datasets: [{
                    label: 'Doanh thu',
                    data: monthlyRevenues,
                    backgroundColor: 'rgb(54, 162, 235)',
                    borderColor: 'rgb(54, 162, 235)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Tháng'
                        }
                    },
                    y: {
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Doanh thu'
                        },
                        ticks: {
                            beginAtZero: true
                        }
                    }
                }
            }
        };

        var doanhThuChart = new Chart(ctx, config);
    }

    drawdoanhThuChart();


    function drawdonHangChart() {
        var ctx = document.getElementById('donHangChart').getContext('2d');

        var pendingOrders = ${pendingOrders};
        var deliveringOrders = ${deliveringOrders};
        var completedOrders = ${completedOrders};
        var cancelledOrders = ${cancelledOrders};

        var orderStatusData = [pendingOrders, deliveringOrders, completedOrders, cancelledOrders]; // Số lượng đơn hàng theo từng trạng thái

        var config = {
            type: 'bar',
            data: {
                labels: ['Chờ xác nhận', 'Đang giao', 'Thành công', 'Đã hủy'], // Các nhãn trục x (các trạng thái)
                datasets: [{
                    label: 'Số đơn hàng',
                    data: orderStatusData, // Số đơn hàng theo từng trạng thái
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.2)', // Xanh dương (chờ xác nhận)
                        'rgba(255, 255, 0, 0.2)', // Vàng (đang giao)
                        'rgba(0, 255, 0, 0.2)', // Xanh lá (thành công)
                        'rgba(255, 0, 0, 0.2)' // Đỏ (đã hủy)
                    ],
                    borderColor: 'rgb(54, 162, 235)', // Màu viền cho dòng
                    borderWidth: 2, // Độ dày viền cho dòng
                    pointBackgroundColor: 'rgb(54, 162, 235)', // Màu nền cho điểm dữ liệu
                    pointRadius: 4, // Đường kính điểm dữ liệu
                    pointHoverRadius: 6 // Đường kính điểm dữ liệu khi di chuột qua
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Trạng thái'
                        }
                    },
                    y: {
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Số đơn hàng'
                        },
                        ticks: {
                            beginAtZero: true
                        }
                    }
                }
            }
        };

        var barChart = new Chart(ctx, config);
    }

    drawdonHangChart();

	
	function drawOrderStatusChart() {
		  var ctx = document.getElementById('orderStatusChart').getContext('2d');
		  
		  var completedOrders = ${completedOrders};
		  var cancelledOrders = ${cancelledOrders};
		  
		  var data = {
		    labels: ['Thành công', 'Hủy'],
		    datasets: [{
		      data: [completedOrders, cancelledOrders],
		      backgroundColor: ['rgb(54, 162, 235)', 'rgb(255, 99, 132)']
		    }]
		  };
		  
		  var options = {
				    responsive: true,
				    maintainAspectRatio: false,
				    plugins: {
				      legend: {
				        labels: {
				          color: 'rgb(255, 255, 255)' // Màu chữ cho các nhãn
				        }
				      }
				    }
				  };
		  
		  var pieChart = new Chart(ctx, {
		    type: 'pie',
		    data: data,
		    options: options
		  });
		}

		drawOrderStatusChart();


</script>
    
    
</body>
</html>