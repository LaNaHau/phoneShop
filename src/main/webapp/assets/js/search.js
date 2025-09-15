$(document).ready(function() {
  // Số sản phẩm hiển thị ban đầu
  var visibleItems = 6;
  var loadMoreButton = document.getElementById("loadMoreButton");
  // Xử lý hiển thị ban đầu
  $('.SPham:lt(' + visibleItems + ')').removeClass('d-none');
  
  // Xử lý sự kiện nhấp vào nút "Xem thêm"
 loadMoreButton.addEventListener("click", function(){
    // Hiển thị thêm 6 sản phẩm
    visibleItems += 6;
    $('.SPham:lt(' + visibleItems + ')').removeClass('d-none');
    
    // Kiểm tra nếu không còn sản phẩm ẩn, ẩn nút "Xem thêm"
    if ($('.SPham.d-none').length === 0) {
     loadMoreButton.style.display = "none";
    }
  });
});
