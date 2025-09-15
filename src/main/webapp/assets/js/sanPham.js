/*//// Lấy ra các phần tử cần sử dụng
//const decreaseBtn = document.getElementById("decreaseBtn");
//const increaseBtn = document.getElementById("increaseBtn");
//const inputQuantity = document.getElementById("inputQuantity");
//const conLaiAn = document.getElementById("conLaiAn");
//// Đặt giá trị mặc định là 1
//let quantity = 1;
//let spConLai=conLaiAn.value;
//inputQuantity.value = quantity;
//
//// Thiết lập sự kiện cho các nút
//decreaseBtn.addEventListener("click", function() {
//	if (quantity > 1) {
//		quantity--;
//		inputQuantity.value = quantity;
//	}
//});
//
//increaseBtn.addEventListener("click", function() {
//	if (quantity <spConLai) {
//		quantity++;
//		inputQuantity.value = quantity;
//	}
//});
//
//// Kiểm tra tính hợp lệ của dữ liệu nhập vào
//inputQuantity.addEventListener("change", function() {
//	let value = parseInt(this.value);
//	if (isNaN(value) || value < 1 || value>spConLai) {
//		quantity = 1;
//		this.value = 1;
//	} else {
//		quantity = value;
//	}
//});

$(document).ready(function() {
	// Log các biến để kiểm tra
	console.log("Context path:", contextPath);
	console.log("Tên sản phẩm:", tenSanPham);
	console.log("Số lượng sản phẩm:", soLuongSanPham);
	// Khi chọn bộ nhớ, gọi Ajax để lấy danh sách màu sắc
// Khi chọn bộ nhớ, gọi Ajax để lấy danh sách màu sắc
$("#boNho").change(function () {
    const boNho = $(this).val(); // Lấy giá trị bộ nhớ đã chọn
    const tenSanPham = encodeURIComponent("${sanPham.tenSanPham}"); // Mã hóa tên sản phẩm

    const mauSacList = $("#mauSac");
    mauSacList.empty();

    if (!boNho) {
        // Nếu chọn lại, gửi yêu cầu để lấy danh sách gốc
        $.ajax({
            url: "${pageContext.servletContext.contextPath}/product/getMauSac",
            type: "GET",
            data: {
                tenSanPham: tenSanPham,
                boNho: "" // Truyền giá trị rỗng để lấy danh sách gốc
            },
            success: function (data) {
                mauSacList.append('<option value="">Chọn lại màu sắc</option>');
                data.forEach(function (mauSac) {
                    mauSacList.append('<option value="' + mauSac + '">' + mauSac + '</option>');
                });
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi gọi Ajax:", error);
            }
        });
    } else {
        // Nếu có bộ nhớ được chọn, lấy màu sắc liên quan
        $.ajax({
            url: "${pageContext.servletContext.contextPath}/product/getMauSac",
            type: "GET",
            data: {
                tenSanPham: tenSanPham,
                boNho: boNho
            },
            success: function (data) {
                mauSacList.append('<option value="">Chọn lại màu sắc</option>');
                data.forEach(function (mauSac) {
                    mauSacList.append('<option value="' + mauSac + '">' + mauSac + '</option>');
                });
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi gọi Ajax:", error);
            }
        });
    }
});

// Khi chọn màu sắc, gọi Ajax để lấy danh sách bộ nhớ
$("#mauSac").change(function () {
    const mauSac = $(this).val(); // Lấy giá trị màu sắc đã chọn
    const tenSanPham = encodeURIComponent("${sanPham.tenSanPham}"); // Mã hóa tên sản phẩm

    const boNhoList = $("#boNho");
    boNhoList.empty();

    if (!mauSac) {
        // Nếu chọn lại, gửi yêu cầu để lấy danh sách gốc
        $.ajax({
            url: "${pageContext.servletContext.contextPath}/product/getBoNho",
            type: "GET",
            data: {
                tenSanPham: tenSanPham,
                mauSac: "" // Truyền giá trị rỗng để lấy danh sách gốc
            },
            success: function (data) {
                boNhoList.append('<option value="">Chọn lại bộ nhớ</option>');
                data.forEach(function (boNho) {
                    boNhoList.append('<option value="' + boNho + '">' + boNho + '</option>');
                });
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi gọi Ajax:", error);
            }
        });
    } else {
        // Nếu có màu sắc được chọn, lấy bộ nhớ liên quan
        $.ajax({
            url: "${pageContext.servletContext.contextPath}/product/getBoNho",
            type: "GET",
            data: {
                tenSanPham: tenSanPham,
                mauSac: mauSac
            },
            success: function (data) {
                boNhoList.append('<option value="">Chọn lại bộ nhớ</option>');
                data.forEach(function (boNho) {
                    boNhoList.append('<option value="' + boNho + '">' + boNho + '</option>');
                });
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi gọi Ajax:", error);
            }
        });
    }
});

});




*/

 $(document).ready(function () {
      // Hàm kiểm tra xem người dùng đã chọn đầy đủ các tùy chọn chưa
      function isValidSelection() {
          var isColorSelected = $('input[name="mauSac"]:checked').length > 0; // Kiểm tra màu sắc
          var isMemorySelected = $('input[name="boNho"]:checked').length > 0; // Kiểm tra bộ nhớ

          return isColorSelected && isMemorySelected; // Trả về true nếu đã chọn đủ
      }

      // Khi người dùng nhấn "Thêm vào giỏ hàng"
      $('button[name="them"]').click(function (e) {
          e.preventDefault(); // Ngừng hành động mặc định của nút (nếu có)

          if (isValidSelection()) {
              // Nếu đã chọn đủ, thực hiện hành động thêm vào giỏ hàng
              $(this).closest('form').submit(); // Submit form để thêm vào giỏ hàng
          } else {
              // Nếu chưa chọn đủ, hiển thị thông báo lỗi
              $('#error-message').show();
          }
      });

      // Khi người dùng nhấn "Thêm vào yêu thích"
      $('button[name="fav"]').click(function (e) {
          e.preventDefault(); // Ngừng hành động mặc định của nút (nếu có)

          if (isValidSelection()) {
              // Nếu đã chọn đủ, chuyển đến trang thêm vào yêu thích
              window.location.href = $(this).find('a').attr('href'); // Lấy URL trong link và chuyển hướng
          } else {
              // Nếu chưa chọn đủ, hiển thị thông báo lỗi
              $('#error-message').show();
          }
      });
  });